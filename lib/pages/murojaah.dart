import 'package:flutter/material.dart';

class MurojaahWidget extends StatefulWidget {
  const MurojaahWidget({super.key});

  @override
  State<MurojaahWidget> createState() => _MurojaahWidgetState();
}

class _MurojaahWidgetState extends State<MurojaahWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Center(
          child: Text(
        "Segera hadir muroja'ah hafalan surah Al Quran nantikan update terbarunya hanya di UINIQU",
        textAlign: TextAlign.center,
      )),
    );
  }
}
