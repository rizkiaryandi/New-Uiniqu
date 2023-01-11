import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:fluttertoast/fluttertoast.dart';

//Components
import '../components/toast.dart';
import '../components/spinnerDialog.dart';

//Services
import '../services/auth_service.dart';

//Models
import '../models/auth_model.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  String username = "";
  String password = "";

  FToast fToast = FToast();

  void initState() {
    fToast.init(context);
    super.initState();
  }

  Future saveUserInfo(AuthModel item) async {
    var box = await Hive.openBox<AuthModel>('auth');
    box.put('userinfo', item);
  }

  void loginAction() {
    DialogBuilder(context).showSpinnerDialog('Proses Autentikasi');
    AuthService().loginAction({
      'username': username,
      'password': password
    }).then((value) => {
          FocusScope.of(context).requestFocus(new FocusNode()),
          DialogBuilder(context).hideOpenDialog(),
          (value?.token != null
              ? {
                  saveUserInfo(value!),
                  toast.successToast(
                      fToast, "Halo, selamat datang ${value.name}"),
                  Navigator.pop(context, "toUserInfo"),
                }
              : toast.dangerToast(fToast, "Terjadi kesalahan saat masuk")),
        });
  }

  Widget build(BuildContext context) {
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
                  loginAction();
                },
                child: Text(
                  "Masuk",
                  style: TextStyle(fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 0),
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
                  Navigator.pop(context, "toRegister");
                  // _openRegister();
                },
                child: Text(
                  "Register Akun Uiniqu",
                  style: TextStyle(fontSize: 14),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[900],
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 0),
                    side: const BorderSide(width: 2, color: Colors.white),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18))),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
