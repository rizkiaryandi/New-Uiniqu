//Libraries
import 'package:hive/hive.dart';

part 'auth_model.g.dart';

@HiveType(typeId: 1)
class AuthModel {
  AuthModel({
    required this.name,
    required this.username,
    required this.photo_url,
    required this.created_at,
    required this.updated_at,
    required this.token,
  });

  @HiveField(0)
  String? name;

  @HiveField(1)
  String? username;

  @HiveField(2)
  String? photo_url;

  @HiveField(3)
  String? created_at;

  @HiveField(4)
  String? updated_at;

  @HiveField(5)
  String? token;

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
        name: json["name"],
        username: json["username"],
        photo_url: json["photo_url"],
        created_at: json["created_at"],
        updated_at: json["updated_at"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "username": username,
        "photo_url": photo_url,
        "created_at": created_at,
        "updated_at": updated_at,
        "token": token,
      };

  @override
  AuthModel get() {
    return AuthModel(
        name: name,
        username: username,
        photo_url: photo_url,
        created_at: created_at,
        updated_at: updated_at,
        token: token);
  }
}
