import 'package:hive/hive.dart';

part 'tadarus_model.g.dart';

@HiveType(typeId: 0)
class Tadarus {
  @HiveField(0)
  String timestamps;

  @HiveField(1)
  String surah_name;

  @HiveField(2)
  int surah_number;

  @HiveField(3)
  int ayah_number;

  Tadarus(
      {required this.timestamps,
      required this.surah_name,
      required this.surah_number,
      required this.ayah_number});

  @override
  Tadarus get() {
    return Tadarus(
        timestamps: timestamps,
        surah_name: surah_name,
        surah_number: surah_number,
        ayah_number: ayah_number);
  }
}
