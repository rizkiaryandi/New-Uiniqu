import 'package:flutter/material.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

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

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  _openRegister() {
    Future<void> future = showModalBottomSheet<void>(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) => Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Register(),
            ));

    future.then((void value) => {
          if ({value}.toString() == '{toLogin}') _openLogin()
        });
  }

  _openLogin() {
    Future<void> future = showModalBottomSheet<void>(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) => Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Login(),
            ));

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

  int _selectedNavbar = 0;

  void _changeSelectedNavBar(int index) {
    if (index < 3) {
      setState(() {
        _selectedNavbar = index;
      });
    } else {
      _openUserInfo();
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: Align(
              alignment: Alignment.centerLeft,
              child: BottomNavyBar(
                backgroundColor: Colors.transparent,
                selectedIndex: _selectedNavbar,
                showElevation: true, //
                onItemSelected: (index) => {
                  if (index < 3)
                    {
                      setState(() {
                        _selectedNavbar = index;
                        _tabController?.animateTo(_selectedNavbar);
                      })
                    }
                  else
                    {_openUserInfo()}
                },
                items: [
                  BottomNavyBarItem(
                    icon: Icon(Icons.book_outlined),
                    title: Text('Tadarus'),
                    activeColor: Colors.white,
                  ),
                  BottomNavyBarItem(
                    icon: Icon(Icons.lightbulb_outline),
                    title: Text('Murojaah'),
                    activeColor: Colors.white,
                  ),
                  BottomNavyBarItem(
                    icon: Icon(Icons.play_arrow),
                    title: Text('Reels'),
                    activeColor: Colors.white,
                  ),
                  BottomNavyBarItem(
                    icon: Icon(Icons.person_outline),
                    title: Text('Pengguna'),
                    activeColor: Colors.white,
                  ),
                ],
              ),
            ),
          ),
          title: Text(widget.title),

          elevation: 0,
          backgroundColor: Colors.transparent,
          // bottomOpacity: 0.0,
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            TadarusWidget(),
            MurojaahWidget(),
            Container(
              padding: EdgeInsets.all(20),
              child: Center(
                  child: Text(
                "Segera hadir reels ayat-ayat Al Quran nantikan update terbarunya hanya di UINIQU",
                textAlign: TextAlign.center,
              )),
            )
          ],
        ),
      ),
    );
  }
}
