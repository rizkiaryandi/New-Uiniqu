import 'package:flutter/material.dart';

//Pages
import './pages/tadarus.dart';
import './pages/murojaah.dart';

// Pages for Modal
import './pages/user_info.dart';
import './pages/register.dart';
import './pages/login.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  _openRegister() {
    Future<void> future = showModalBottomSheet<void>(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) => Register());

    future.then((void value) => {
          if ({value}.toString() == '{toLogin}') _openLogin()
        });
  }

  _openLogin() {
    Future<void> future = showModalBottomSheet<void>(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) => Login());

    future.then((void value) => {
          if ({value}.toString() == '{toRegister}')
            {_openRegister()}
          else if ({value}.toString() == '{toUserInfo}')
            {_openUserInfo()}
        });
  }

  _openUserInfo() {
    Future<void> future = showModalBottomSheet<void>(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) => UserInfo());

    future.then((void value) => {
          if ({value}.toString() == '{toLogin}') _openLogin()
        });
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
                    _openUserInfo();
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
