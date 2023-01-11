import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';

import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class DetailSearch extends StatefulWidget {
  const DetailSearch({super.key});

  @override
  State<DetailSearch> createState() => _DetailSearchState();
}

class _DetailSearchState extends State<DetailSearch>
    with SingleTickerProviderStateMixin {
  @override
  final _searchController = TextEditingController();
  bool _isLoading = false;
  List items = [];

  FocusNode inputNode = FocusNode();
  int _filterIndex = 2;
  String searchText = "";
  List placeholder = [
    "Cari nama atau nomor surah",
    "Pencarian ayat (Arabic Text)",
    "Cari terjemahan ayat",
    "Cari tafsir per Ayat"
  ];

  void initState() {
    super.initState();
  }

  void changeFilter(int i) {
    setState(() {
      _filterIndex = i;

      _searchController.clear();
      FocusScope.of(context).requestFocus(inputNode);
    });
  }

  void searchAction() {
    setState(() {
      items = [];
      _isLoading = true;
    });
    if (searchText.length > 0) {
      if (_filterIndex == 1) {
        if (_filterIndex == 1) {
          dynamic search(String input, itemsa) {
            dynamic item = itemsa["text"];
            List data = [];

            for (int i = 0; i < item.length; i++) {
              if (item["${i + 1}"]
                      .toString()
                      .toLowerCase()
                      .indexOf(searchText.toLowerCase()) >
                  0) {
                data.add({
                  "surah_number": itemsa['number'],
                  "surah_name": itemsa['name_latin'],
                  "ayah_number": i + 1,
                  "text": item["${i + 1}"].toString()
                });
              }
            }
            return data;
          }

          for (int i = 1; i <= 114; i++) {
            dynamic target;
            List list;
            rootBundle
                .loadString('assets/quran/surah/${i}.json')
                .then((response) => {
                      target =
                          jsonDecode(jsonEncode(json.decode(response)))['${i}'],
                      list = search(searchText, target),
                      if (list.length > 0)
                        {
                          setState(() {
                            items += [
                              {
                                "surah_number": target['number'],
                                "surah_name": target['name_latin'],
                                "translation": target['translations']['id']
                                    ['name'],
                                "list": list
                              }
                            ];
                          })
                        }
                    })
                .whenComplete(() => {
                      setState(() {
                        _isLoading = false;
                        searchText = "";
                        // print(items);
                      })
                    });
          }
        }
      } else if (_filterIndex == 2) {
        dynamic search(String input, itemsa) {
          dynamic item = itemsa["translations"]["id"]["text"];

          for (int i = 0; i < item.length; i++) {
            if (item["${i + 1}"]
                    .toString()
                    .toLowerCase()
                    .indexOf(searchText.toLowerCase()) >
                0) {
              items.add({
                "surah_number": itemsa['number'],
                "surah_name": itemsa['name_latin'],
                "ayah_number": (i + 1).toString(),
                "text": item["${i + 1}"]
              });
            }
          }
        }

        for (int i = 1; i <= 114; i++) {
          dynamic target;
          rootBundle
              .loadString('assets/quran/surah/${i}.json')
              .then((response) => {
                    target =
                        jsonDecode(jsonEncode(json.decode(response)))['${i}'],
                    search(searchText, target)
                  })
              .whenComplete(() => {
                    setState(() {
                      _isLoading = false;

                      // print(items);
                    })
                  });
        }
      } else if (_filterIndex == 3) {
        dynamic search(String input, itemsa) {
          dynamic item = itemsa["tafsir"]["id"]["kemenag"]["text"];
          List data = [];

          for (int i = 0; i < item.length; i++) {
            if (item["${i + 1}"]
                    .toString()
                    .toLowerCase()
                    .indexOf(searchText.toLowerCase()) >
                0) {
              data.add({
                "surah_number": itemsa['number'],
                "surah_name": itemsa['name_latin'],
                "ayah_number": i + 1,
                "text": item["${i + 1}"].toString()
              });
            }
          }
          return data;
        }

        for (int i = 1; i <= 114; i++) {
          dynamic target;
          List list = [];
          rootBundle
              .loadString('assets/quran/surah/${i}.json')
              .then((response) => {
                    target =
                        jsonDecode(jsonEncode(json.decode(response)))['${i}'],
                    list = search(searchText, target),
                    if (list.length > 0)
                      {
                        setState(() {
                          items.add(list);
                        })
                      }
                  })
              .whenComplete(() => {
                    setState(() {
                      _isLoading = false;

                      // print(items);
                    })
                  });
        }
      }
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Pencarian",
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.only(left: 4),
                child: Text(
                  "Pencarian berdasarkan: ",
                  style: TextStyle(color: Colors.grey[300], fontSize: 12),
                ),
              ),
              Container(
                child: new ButtonBar(
                  alignment: MainAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        changeFilter(0);
                      },
                      child: Text(
                        "Surah",
                        style: TextStyle(fontSize: 12),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _filterIndex == 0
                            ? Colors.grey[800]
                            : Colors.grey[600],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        changeFilter(1);
                      },
                      child: Text(
                        "آية",
                        style: TextStyle(fontSize: 12),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _filterIndex == 1
                            ? Colors.grey[800]
                            : Colors.grey[600],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        changeFilter(2);
                      },
                      child: Text(
                        "Terjemahan",
                        style: TextStyle(fontSize: 12),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _filterIndex == 2
                            ? Colors.grey[800]
                            : Colors.grey[600],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        changeFilter(3);
                      },
                      child: Text(
                        "Tafsir",
                        style: TextStyle(fontSize: 12),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _filterIndex == 3
                            ? Colors.grey[800]
                            : Colors.grey[600],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              TextField(
                focusNode: inputNode,
                controller: _searchController,
                onChanged: (text) {
                  setState(() {
                    searchText = text;
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
                  hintText: placeholder[_filterIndex],
                  hintStyle: TextStyle(color: Colors.grey, fontSize: 13.5),
                  prefixIcon: Container(
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    width: 14,
                  ),
                  suffixIcon: _searchController.text.length > 0
                      ? IconButton(
                          onPressed: () => {
                            _searchController.clear(),
                            setState(() {
                              // _items = _itemsF;
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
              ),
              Container(
                padding: EdgeInsets.only(top: 8),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      searchAction();
                    },
                    child: Text(
                      "Mulai Pencarian",
                      style: TextStyle(fontSize: 14),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 14),
                      backgroundColor: Colors.grey[700],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ),
              (_isLoading
                  ? Container(
                      child: SpinKitThreeInOut(
                        color: Colors.white,
                        size: 18.0,
                      ),
                    )
                  : Container(
                      padding: EdgeInsets.only(top: 4),
                    )),
              Expanded(
                  child: ListView.builder(
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.zero,
                    elevation: 0,
                    color: Colors.transparent,
                    child: new InkWell(
                      onTap: () => {
                        // _navigateAndDisplaySelection(
                        //     context, int.parse(surah[index]["nomor"]), 0, false)
                      },
                      child: ListTile(
                        title: Text(
                            "${items[index]["surah_name"]}", // ambil karakter pertama text
                            style: TextStyle(fontSize: 16.5)),
                        subtitle: Text(
                          "${items[index]["text"]}",
                          style: TextStyle(fontSize: 11.5),
                          overflow: TextOverflow.ellipsis,
                        ),
                        leading: CircleAvatar(
                          backgroundColor: Colors.grey[700],
                          foregroundColor: Colors.white,
                          child: Text(
                              "${items[index]["ayah_number"]}", // ambil karakter pertama text
                              style: TextStyle(fontSize: 14)),
                        ),
                      ),
                    ),
                  );
                },
                itemCount: items.length,
              ))
            ],
          )),
    );
  }
}
