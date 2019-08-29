import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:lista_de_compras/src/tabs/edit_tab.dart';
import 'package:lista_de_compras/src/tabs/list_tab.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController _pageController;
  int _page = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        color: Theme.of(context).primaryColor,
        backgroundColor: Colors.grey[850],
        height: 50,
        items: <Widget>[
          Icon(Icons.format_list_bulleted),
          Icon(Icons.lightbulb_outline),
          Icon(Icons.edit),
        ],
        onTap: (page) {
          _pageController.animateToPage(page,
              duration: Duration(milliseconds: 1), curve: Curves.easeIn);
        },
        index: _page,
      ),





      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          ListTab(),
          Container(color:  Colors.grey[850]),
          EditTab(),
        ],
        onPageChanged: (indexPage) {
          setState(() {
            _page = indexPage;
          });
        },
        controller: _pageController,
      ),
    );
  }
}
