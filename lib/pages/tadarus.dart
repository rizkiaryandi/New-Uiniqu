import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:just_audio/just_audio.dart';
// import 'package:just_audio_mpv/just_audio_mpv.dart';

import 'dart:convert';

import './tadarus/read_tadarus.dart' as detail;

class TadarusWidget extends StatefulWidget {
  const TadarusWidget({super.key});

  @override
  State<TadarusWidget> createState() => _TadarusWidgetState();
}

class _TadarusWidgetState extends State<TadarusWidget> {
  @override
  List _items = [];
  List _itemsF = [];
  late AudioPlayer player;

  setPlay(url) async {
    player = new AudioPlayer();

    await player.setUrl(url);
  }

  void initState() {
    this.loadSurah();
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
                trailing: TextButton(
                  onPressed: () {
                    // Navigator.of(context).push(MaterialPageRoute(
                    //   builder: (context) => audio.Audiotest(1);

                    setPlay(detail["audio"]);
                  },
                  child: Icon(
                    Icons.play_arrow,
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
    );
  }

  Widget build(BuildContext context) {
    final List surah = _items;
    return Container(
      child: Column(children: [
        Padding(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: TextField(
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
              cursorColor: Colors.white,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0),
                  fillColor: Color.fromARGB(30, 255, 255, 255),
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none),
                  hintText: 'Cari nama atau nomor surah',
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                  prefixIcon: Container(
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    width: 16,
                  )),
            )),
        Expanded(
            child: ListView.builder(
          itemBuilder: (context, index) {
            return Card(
              elevation: 0,
              color: Colors.transparent,
              child: new InkWell(
                onTap: () => {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => detail.ReadTadarus(index + 1)))
                },
                child: ListTile(
                  title: Text(surah[index]["nama"],
                      style: TextStyle(fontSize: 18)),
                  subtitle: Text((surah[index]["type"] == 'mekah'
                          ? 'Makkiyah'
                          : 'Madaniyah') +
                      " • ${surah[index]["ayat"]} ayat"),
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
    );
  }
}
