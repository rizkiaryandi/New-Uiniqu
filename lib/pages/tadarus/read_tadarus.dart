import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

import '../../dummy/surah_list.dart';

class ReadTadarus extends StatefulWidget {
  const ReadTadarus(this.numberSurah);

  @override
  State<ReadTadarus> createState() => _ReadTadarusState();

  final int numberSurah;
}

class _ReadTadarusState extends State<ReadTadarus> {
  dynamic _items = {
    "number": "",
    "name": "",
    "name_latin": "",
    "number_of_ayah": "",
    "text": [],
    "translations": {
      "id": {"name": "", "text": []}
    },
    "tafsir": {
      "id": {
        "kemenag": {"name": "", "source": "", "text": []}
      }
    }
  };

  int nSurah = 0;

  void initState() {
    this.loadSurah(widget.numberSurah);
    super.initState();
  }

  Future<void> loadSurah(int numberS) async {
    final String response =
        await rootBundle.loadString('assets/quran/surah/${numberS}.json');
    final data = await jsonDecode(jsonEncode(json.decode(response)));

    setState(() {
      _items = data['${numberS}'];
      nSurah = numberS;
      // _items['text'].length
    });
  }

  _actionMore(dynamic detail) {
    return showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          color: Colors.grey[900],
          height: 300,
          child: Column(
            children: [
              ListTile(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                title: Text(
                  detail["name_latin"],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                subtitle: Text(
                  detail['translations']['id']['name'] +
                      " • Surat ke-${nSurah}",
                  style: TextStyle(fontStyle: FontStyle.italic, fontSize: 11),
                ),
              ),
              nSurah < 114
                  ? Card(
                      child: InkWell(
                        onTap: () {
                          loadSurah(nSurah + 1);
                          Navigator.pop(context);
                        },
                        child: ListTile(
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                          title: Text(
                            "Surat Selanjutnya (${surah_list[nSurah]})",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          trailing: Icon(
                            Icons.chevron_right,
                            size: 28,
                          ),
                        ),
                      ),
                    )
                  : Container(),
              nSurah > 1
                  ? Card(
                      child: InkWell(
                        onTap: () {
                          loadSurah(nSurah - 1);
                          Navigator.pop(context);
                        },
                        child: ListTile(
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                          title: Text(
                            "Surat Sebelumnya (${surah_list[nSurah - 2]})",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          leading: Icon(
                            Icons.chevron_left,
                            size: 28,
                          ),
                        ),
                      ),
                      color: Colors.grey[900],
                    )
                  : Container(),
            ],
          ),
        );
      },
    );
  }

  _ayahDetail(dynamic nAyah) {
    return showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          color: Colors.grey[900],
          height: 300,
          child: Column(
            children: [
              ListTile(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                title: Text(
                  _items["name_latin"] + " • ${nAyah}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              Card(
                margin: EdgeInsets.zero,
                child: InkWell(
                  onTap: () {
                    print("object");
                  },
                  child: ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 4),
                    title: Text(
                      "Tandai Terakhir Baca",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 12, height: 1),
                    ),
                    leading: Icon(Icons.pin_drop, size: 18),
                    minLeadingWidth: 0,
                  ),
                ),
                color: Colors.grey[900],
              ),
              Card(
                margin: EdgeInsets.zero,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    _tafsirMore(nAyah);
                  },
                  child: ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 4),
                    title: Text(
                      "Lihat Tafsir (Kemenag)",
                      style: TextStyle(fontSize: 12, height: 1),
                    ),
                    leading: Icon(Icons.remove_red_eye_outlined, size: 18),
                    minLeadingWidth: 0,
                  ),
                ),
                color: Colors.grey[900],
              ),
            ],
          ),
        );
      },
    );
  }

  _tafsirMore(nAyah) {
    return showModalBottomSheet<void>(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          color: Colors.grey[900],
          height: MediaQuery.of(context).size.height * 0.9,
          child: Column(
            children: [
              ListTile(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                title: Text(
                  "Tafsir Kemenag",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                subtitle: Text(
                  "Surat " + _items["name_latin"] + " • ${nAyah}",
                  style: TextStyle(fontStyle: FontStyle.italic, fontSize: 12),
                ),
                trailing: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Text(
                      _items['tafsir']['id']['kemenag']['text']['${nAyah}']),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    dynamic surah = _items;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            surah['name_latin'],
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
              onPressed: () {
                _actionMore(surah);
              },
              icon: Icon(Icons.more_horiz),
              iconSize: 28,
            ),
          ],
        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(18, 0, 18, 8),
              child: Text(
                surah['translations']['id']['name'] +
                    " • ${surah["number_of_ayah"]} ayat",
                style: TextStyle(fontSize: 12, color: Colors.grey[350]),
              ),
              width: MediaQuery.of(context).size.width,
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 0,
                    color: Colors.transparent,
                    child: new InkWell(
                      onTap: () => {_ayahDetail(index + 1)},
                      child: ListTile(
                          title: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 20),
                            child: Text(
                              surah['text']["${index + 1}"],
                              style: TextStyle(
                                  fontSize: 28, height: 2, fontFamily: 'Sch'),
                              textAlign: TextAlign.right,
                            ),
                          ),
                          subtitle: Text(
                              surah['translations']['id']['text']
                                  ["${index + 1}"],
                              style: TextStyle(fontSize: 14)),
                          leading: CircleAvatar(
                            backgroundColor: Colors.grey[700],
                            foregroundColor: Colors.white,
                            child: Text(
                                "${index + 1}", // ambil karakter pertama text
                                style: TextStyle(fontSize: 14)),
                          )),
                    ),
                  );
                },
                itemCount: surah['text'].length,
              ),
            )
          ],
        ));
  }
}
