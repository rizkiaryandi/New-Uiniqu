class Surah {
  final String arti;
  final String asma;
  final String ayat;
  final String nama;
  final String type;
  final String urut;
  final String audio;
  final String nomor;
  final String rukuk;
  final String keterangan;

  const Surah(
      {required this.arti,
      required this.asma,
      required this.ayat,
      required this.nama,
      required this.type,
      required this.urut,
      required this.audio,
      required this.nomor,
      required this.rukuk,
      required this.keterangan});

  static Surah fromJson(json) => Surah(
      arti: json['arti'],
      asma: json['asma'],
      ayat: json['ayat'],
      nama: json['nama'],
      type: json['type'],
      urut: json['urut'],
      audio: json['audio'],
      nomor: json['nomor'],
      rukuk: json['rukuk'],
      keterangan: json['keterangan']);
}
