import 'package:flutter/material.dart';

class MurojaahWidget extends StatefulWidget {
  const MurojaahWidget({super.key});

  @override
  State<MurojaahWidget> createState() => _MurojaahWidgetState();
}

class _MurojaahWidgetState extends State<MurojaahWidget> {
  @override
  Widget build(BuildContext context) {
    final List bulan = [
      "Januari",
      "Fabruari",
      "Maret",
      "April",
      "Mei",
      "Juni",
      "Juli",
      "Agustus",
      "September",
      "Oktober",
      "November",
      "Desember"
    ];
    return Container(
      child: Center(child: Text("Murojaah")),
    );
  }
}
