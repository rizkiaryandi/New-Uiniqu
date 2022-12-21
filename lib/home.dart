import 'package:flutter/material.dart';
import './pages/tadarus.dart';
import './pages/murojaah.dart';

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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
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
