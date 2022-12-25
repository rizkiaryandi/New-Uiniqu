import 'package:flutter/material.dart';
import './pages/tadarus.dart';
import './pages/murojaah.dart';
import './pages/login.dart' as login;
import 'package:hive/hive.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  dynamic name = "";
  dynamic username = "";
  dynamic password = "";

  FToast fToast = FToast();

  void initState() {
    fToast.init(context);
    super.initState();
  }

  _toast(message) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.white,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Icon(
            Icons.check_circle,
            color: Colors.grey[900],
          ),
          SizedBox(
            width: 6.0,
          ),
          Text(message, style: TextStyle(color: Colors.grey[900])),
        ],
      ),
    );
    return fToast.showToast(
        child: toast,
        toastDuration: Duration(seconds: 2),
        positionedToastBuilder: (context, child) {
          return Positioned(
            child: child,
            bottom: 16.0,
            right: 16.0,
          );
        });
  }

  _openLogin() {
    return showModalBottomSheet<void>(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: Colors.grey[900],
            height: 500,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text(
                    "Masuk Uiniqu",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 4, bottom: 8),
                  child: Text(
                    "Input username dan password akun anda",
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: TextField(
                    onChanged: (text) {
                      setState(() {
                        username = text;
                      });
                    },
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                        fillColor: Color.fromARGB(30, 255, 255, 255),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide.none),
                        hintText: 'Username',
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                        prefixIcon: Container(
                          padding: EdgeInsets.only(right: 15, left: 15),
                          child: Icon(
                            Icons.person_outline,
                            color: Colors.white,
                            size: 26,
                          ),
                        )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: TextField(
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    onChanged: (text) {
                      setState(() {
                        password = text;
                      });
                    },
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                        fillColor: Color.fromARGB(30, 255, 255, 255),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide.none),
                        hintText: 'Password',
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                        prefixIcon: Container(
                          padding: EdgeInsets.only(right: 15, left: 15),
                          child: Icon(
                            Icons.lock_outline,
                            color: Colors.white,
                            size: 24,
                          ),
                        )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 12, left: 20, right: 20),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _toast("Login berhasil, selamat datang " + name);
                      },
                      child: Text(
                        "Masuk",
                        style: TextStyle(fontSize: 16),
                      ),
                      style: ElevatedButton.styleFrom(
                          padding:
                              EdgeInsets.symmetric(vertical: 16, horizontal: 0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4))),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 14, bottom: 14),
                  child: Text(
                    "Belum punya akun?",
                    style: TextStyle(fontSize: 12, color: Colors.grey[50]),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 0, left: 20, right: 20),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _openRegister();
                      },
                      child: Text(
                        "Register Akun Uiniqu",
                        style: TextStyle(fontSize: 14),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[900],
                          padding:
                              EdgeInsets.symmetric(vertical: 16, horizontal: 0),
                          side: const BorderSide(width: 2, color: Colors.white),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18))),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  _openRegister() {
    return showModalBottomSheet<void>(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: Colors.grey[900],
            height: 500,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text(
                    "Register Akun Uiniqu",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 4, bottom: 8),
                  child: Text(
                    "Cukup 1 langkah untuk membuat akun Uiniqu",
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: TextField(
                    onChanged: (text) {
                      setState(() {
                        name = text;
                      });
                    },
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                        fillColor: Color.fromARGB(30, 255, 255, 255),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide.none),
                        hintText: 'Nama Lengkap',
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                        prefixIcon: Container(
                          padding: EdgeInsets.only(right: 15, left: 15),
                          child: Icon(
                            Icons.person_pin_circle_outlined,
                            color: Colors.white,
                            size: 24,
                          ),
                        )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: TextField(
                    onChanged: (text) {
                      setState(() {
                        username = text;
                      });
                    },
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                        fillColor: Color.fromARGB(30, 255, 255, 255),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide.none),
                        hintText: 'Username',
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                        prefixIcon: Container(
                          padding: EdgeInsets.only(right: 15, left: 15),
                          child: Icon(
                            Icons.person_outline,
                            color: Colors.white,
                            size: 26,
                          ),
                        )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: TextField(
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    onChanged: (text) {
                      setState(() {
                        password = password;
                      });
                    },
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                        fillColor: Color.fromARGB(30, 255, 255, 255),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: BorderSide.none),
                        hintText: 'Password',
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 15),
                        prefixIcon: Container(
                          padding: EdgeInsets.only(right: 15, left: 15),
                          child: Icon(
                            Icons.lock_outline,
                            color: Colors.white,
                            size: 24,
                          ),
                        )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 12, left: 20, right: 20),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _openLogin();
                        _toast(
                            "Sukses, silahkan melakukan login dengan akun anda");
                      },
                      child: Text(
                        "Register",
                        style: TextStyle(fontSize: 16),
                      ),
                      style: ElevatedButton.styleFrom(
                          padding:
                              EdgeInsets.symmetric(vertical: 16, horizontal: 0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4))),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 14, bottom: 14),
                  child: Text(
                    "Sudah punya akun?",
                    style: TextStyle(fontSize: 12, color: Colors.grey[50]),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 0, left: 20, right: 20),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _openLogin();
                      },
                      child: Text(
                        "Kembali ke Halaman Masuk",
                        style: TextStyle(fontSize: 14),
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[900],
                          padding:
                              EdgeInsets.symmetric(vertical: 16, horizontal: 0),
                          side: const BorderSide(width: 2, color: Colors.white),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18))),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  _openUserInfo() {
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
                  Navigator.pop(context);
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
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              bottom: PreferredSize(
                  preferredSize: Size.fromHeight(40),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: TabBar(
                        padding: EdgeInsets.only(left: 16),
                        indicator: UnderlineTabIndicator(
                            borderSide: BorderSide(
                              width: 4,
                              color: Color(0xFF646464),
                            ),
                            insets:
                                EdgeInsets.only(left: 0, right: 8, bottom: 4)),
                        tabs: [
                          Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Tab(text: "Tadarus")),
                          Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Tab(text: "Muroja'ah")),
                        ],
                        isScrollable: true,
                        labelPadding: EdgeInsets.only(left: 0, right: 0),
                      ))),
              title: Text(widget.title),
              actions: [
                IconButton(
                  onPressed: () {
                    _openLogin();
                  },
                  icon: Icon(
                    Icons.person_outline,
                    size: 28,
                  ),
                ),
              ],
              elevation: 0,
              backgroundColor: Colors.transparent,
              // bottomOpacity: 0.0,
            ),
            body: TabBarView(children: [
              TadarusWidget(),
              MurojaahWidget(),
            ])));
  }
}
