import 'package:flutter/material.dart';
import '../dummy/surah.dart';

class TadarusWidget extends StatefulWidget {
  const TadarusWidget({super.key});

  @override
  State<TadarusWidget> createState() => _TadarusWidgetState();
}

class _TadarusWidgetState extends State<TadarusWidget> {
  @override
  Widget build(BuildContext context) {
    // final List bulan = [
    //   "Januari",
    //   "Fabruari",
    //   "Maret",
    //   "April",
    //   "Mei",
    //   "Juni",
    //   "Juli",
    //   "Agustus",
    //   "September",
    //   "Oktober",
    //   "November",
    //   "Desember"
    // ];

    final List surah = Surah.data;
    return Container(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
                title:
                    Text(surah[index]["nama"], style: TextStyle(fontSize: 18)),
                subtitle: Text((surah[index]["type"] == 'mekah'
                        ? 'Makkiyah'
                        : 'Madaniyah') +
                    " - ${surah[index]["ayat"]} ayat"),
                leading: CircleAvatar(
                  backgroundColor: Colors.grey,
                  foregroundColor: Colors.white,
                  child: Text("${index + 1}", // ambil karakter pertama text
                      style: TextStyle(fontSize: 20)),
                )),
          );
        },
        itemCount: surah.length,
      ),
    );
  }
}
