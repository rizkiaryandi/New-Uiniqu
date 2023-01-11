import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//Libraries
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:just_audio/just_audio.dart';
import 'package:hive/hive.dart';
import 'dart:convert';

//Pages
import './tadarus/read_tadarus.dart' as detail;
import './tadarus/detail_search.dart' as detailSearch;

//Models
import 'package:uiniqu/models/tadarus_model.dart';

//Components
import '../components/toast.dart';

class TadarusWidget extends StatefulWidget {
  const TadarusWidget({super.key});

  @override
  State<TadarusWidget> createState() => _TadarusWidgetState();
}

class _TadarusWidgetState extends State<TadarusWidget> {
  @override
  List _items = [];
  List _itemsF = [];

  String playerStat = "false";
  String playPauseStat = "play";
  final searchController = TextEditingController();

  late AudioPlayer player;
  Tadarus lastRead = new Tadarus(
      timestamps: '', surah_name: '', surah_number: 0, ayah_number: 0);
  bool isLast = false;
  bool isDetailSearch = false;

  FToast fToast = FToast();

  setStart(url) async {
    if (playerStat == "false") {
      setState(() {
        playerStat = "loading";
        print(playerStat);
      });
      player = AudioPlayer();
      final duration = await player.setUrl(url);
      await player
          .play()
          .then((_) => {
                setState(() {
                  playerStat = "true";
                  playPauseStat = "pause";

                  print(playerStat);
                })
              })
          .catchError((_) => {
                setState(() {
                  playerStat = "false";
                  playPauseStat = "pause";
                  toast.dangerToast(
                      fToast, "Terjadi kesalahan saat memuat audio");
                })
              });
    }
  }

  void setPlay() async {
    await player.play().then((_) => {
          setState(() {
            playPauseStat = "play";
          })
        });
  }

  void setPause() async {
    await player.pause().then((_) => {
          setState(() {
            playPauseStat = "pause";
          })
        });
  }

  Future getLastRead() async {
    var box = await Hive.openBox<Tadarus>('tadarus');
    var getLast = box.get('last');
    setState(() {
      if (getLast != null) {
        lastRead = getLast.get();
        isLast = true;
      }
    });
  }

  void initState() {
    fToast.init(context);
    this.loadSurah();
    this.getLastRead();
    super.initState();
  }

  Future<void> loadSurah() async {
    final String response =
        await rootBundle.loadString('assets/quran/surah.json');
    final data = await json.decode(response);
    setState(() {
      _items = data;
      _itemsF = data;
    });
  }

  _surahMore(dynamic detail) {
    return showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          color: Colors.grey[900],
          height: MediaQuery.of(context).size.height * 0.75,
          child: Column(
            children: [
              ListTile(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                title: Text(
                  detail["nama"],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                subtitle: Text(
                  detail["arti"],
                  style: TextStyle(fontStyle: FontStyle.italic, fontSize: 12),
                ),
                trailing: playerStat == "false"
                    ? TextButton(
                        onPressed: () {
                          // Navigator.of(context).push(MaterialPageRoute(
                          //   builder: (context) => audio.Audiotest(1);

                          setStart(detail["audio"]);
                        },
                        child: Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                        ),
                      )
                    : playerStat == "loading"
                        ? TextButton(onPressed: () {}, child: Text("..."))
                        : TextButton(
                            onPressed: () {
                              if (playPauseStat == "play") {
                                setPause();
                              } else if (playPauseStat == "pause") {
                                setPlay();
                              }
                            },
                            child: Icon(
                              playPauseStat == "play"
                                  ? Icons.play_arrow
                                  : Icons.pause,
                              color: Colors.white,
                            ),
                          ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Html(data: detail["keterangan"]),
                ),
              )
            ],
          ),
        );
      },
    ).whenComplete(() => {
          setState(() {
            playerStat = "false";
            playPauseStat = "play";
          })
        });
  }

  Future<void> _navigateAndDisplaySelection(
      BuildContext context, surah_number, ayah_number, stat) async {
    FocusScope.of(context).requestFocus(new FocusNode());
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              detail.ReadTadarus(surah_number, ayah_number - 1, stat)),
    );

    // When a BuildContext is used from a StatefulWidget, the mounted property
    // must be checked after an asynchronous gap.
    if (!mounted) return;

    // After the Selection Screen returns a result, hide any previous snackbars
    // and show the new result.
    this.getLastRead();
    setState(() {
      _items = _itemsF;
      searchController.clear();
      isDetailSearch = false;
    });
  }

  Widget build(BuildContext context) {
    final List surah = _items;
    return WillPopScope(
      child: Container(
        child: Column(children: [
          isLast
              ? Padding(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    elevation: 0,
                    color: Colors.grey[700],
                    child: InkWell(
                      onTap: () {
                        _navigateAndDisplaySelection(
                            context,
                            lastRead.surah_number,
                            lastRead.ayah_number - 1,
                            true);
                      },
                      child: ListTile(
                        title: Text("Terakhir dibaca: ",
                            // ambil karakter pertama text
                            style: TextStyle(fontSize: 14)),
                        subtitle: Text(
                            "${lastRead.surah_name} • ${lastRead.ayah_number}", // ambil karakter pertama text
                            style: TextStyle(fontSize: 12)),
                      ),
                    ),
                  ),
                )
              : Container(),
          (isDetailSearch == true
              ? Container(
                  padding: EdgeInsets.fromLTRB(16, 4, 16, 0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isDetailSearch = false;
                        });

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => detailSearch.DetailSearch(),
                            ));
                      },
                      child: Text(
                        "Klik untuk pencarian lebih mendalam",
                        style: TextStyle(fontSize: 11.4),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[800],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(9))),
                    ),
                  ),
                )
              : Padding(
                  padding: EdgeInsets.zero,
                )),
          Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: TextField(
                controller: searchController,
                onChanged: (text) {
                  List<dynamic> search(String input) {
                    return _itemsF
                        .where((e) =>
                            e["nama"]
                                .toUpperCase()
                                .contains(input.toUpperCase()) ||
                            e["nomor"]
                                .toUpperCase()
                                .contains(input.toUpperCase()))
                        .toList();
                  }

                  setState(() {
                    _items = search(text);
                  });
                },
                onTap: () {
                  setState(() {
                    isDetailSearch = true;
                  });
                },
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0),
                  fillColor: Color.fromARGB(30, 255, 255, 255),
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide.none),
                  hintText: 'Cari nama atau nomor surah',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 13.5),
                  prefixIcon: Container(
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    width: 14,
                  ),
                  suffixIcon: searchController.text.length > 0
                      ? IconButton(
                          onPressed: () => {
                            searchController.clear(),
                            setState(() {
                              _items = _itemsF;
                              FocusScope.of(context)
                                  .requestFocus(new FocusNode());
                            }),
                          },
                          icon: Icon(
                            Icons.clear,
                            size: 18,
                            color: Colors.white,
                          ),
                        )
                      : Text(""),
                ),
              )),
          Expanded(
              child: ListView.builder(
            itemBuilder: (context, index) {
              return Card(
                elevation: 0,
                color: Colors.transparent,
                child: new InkWell(
                  onTap: () => {
                    _navigateAndDisplaySelection(
                        context, int.parse(surah[index]["nomor"]), 0, false)
                  },
                  child: ListTile(
                    title: Text(
                        surah[index]["nama"], // ambil karakter pertama text
                        style: TextStyle(fontSize: 16.5)),
                    subtitle: Text(
                      (surah[index]["type"] == 'mekah'
                              ? 'Makkiyah'
                              : 'Madaniyah') +
                          " • ${surah[index]["ayat"]} ayat",
                      style: TextStyle(fontSize: 11.5),
                    ),
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey[700],
                      foregroundColor: Colors.white,
                      child: Text(
                          "${surah[index]["nomor"]}", // ambil karakter pertama text
                          style: TextStyle(fontSize: 14)),
                    ),
                    trailing: TextButton(
                      onPressed: () {
                        _surahMore(surah[index]);
                      },
                      child: Icon(
                        Icons.more_horiz,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              );
            },
            itemCount: surah.length,
          ))
        ]),
      ),
      onWillPop: () async {
        this.getLastRead();
        return false;
      },
    );
  }
}
