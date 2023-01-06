import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:uiniqu/models/auth_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

//Components
import '../components/toast.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({super.key});

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  bool isLogin = false;
  FToast fToast = FToast();
  AuthModel userinfo = new AuthModel(
      name: '',
      username: '',
      photo_url: '',
      created_at: '',
      updated_at: '',
      token: '');

  void initState() {
    fToast.init(context);
    this.getUserInfo();
    super.initState();
  }

  Future getUserInfo() async {
    var box = await Hive.openBox<AuthModel>('auth');
    var getUser = box.get('userinfo');
    setState(() {
      if (getUser != null) {
        isLogin = true;
        userinfo = getUser.get();

        box.close();
      }
    });
  }

  Future logout() async {
    toast.mainToast(fToast, "Anda telah keluar");
    var box = await Hive.openBox<AuthModel>('auth');
    box.delete('userinfo');

    box.clear();
    box.close();

    Navigator.pop(context);
  }

  getDateCreated(String date) {
    List months = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember'
    ];
    var year = date.split("-")[0];
    var month = months[int.parse(date.split("-")[1]) - 1];

    return month + " " + year;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.grey[900],
      height: 300,
      child: isLogin
          ? Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 32, bottom: 8),
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        userinfo.name![0].toUpperCase(),
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(30),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 2),
                  child: Text(
                    userinfo.name!,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 12),
                  child: Text(
                    "Bergabung ${getDateCreated(userinfo.created_at!)}",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    logout();
                  },
                  child: Text(
                    "Keluar",
                    style: TextStyle(fontSize: 12),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    side: const BorderSide(width: 1, color: Colors.white),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.0)),
                  ),
                )
              ],
            )
          : Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 32, bottom: 8),
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Icon(
                        Icons.person_outline,
                        size: 56,
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(30),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 2),
                  child: Text(
                    "Hamba Allah",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 12),
                  child: Text(
                    "Silahkan masuk untuk fitur yang lebih lengkap",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, "toLogin");
                    // Navigator.of(context).push(
                    //     MaterialPageRoute(builder: (context) => login.Login()));
                  },
                  child: Text(
                    "Masuk",
                    style: TextStyle(fontSize: 14),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    side: const BorderSide(width: 2, color: Colors.white),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.0)),
                  ),
                )
              ],
            ),
    );
  }
}
