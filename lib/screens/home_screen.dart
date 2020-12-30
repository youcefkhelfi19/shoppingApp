import 'package:flutter/material.dart';
import 'package:pubdz_shopping/firebase_services/firebase_services.dart';
import 'package:pubdz_shopping/tabs/home_tab.dart';
import 'package:pubdz_shopping/tabs/saved_tab.dart';
import 'package:pubdz_shopping/tabs/search_tab.dart';
import 'package:pubdz_shopping/widgets/bottom_tabs.dart';
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseServices firebaseServices=FirebaseServices();
  PageController _tabsPageController;
  int _selectedTab=0;
  @override
  void initState() {
    _tabsPageController=PageController();
    super.initState();
  }
  @override
  void dispose() {
    _tabsPageController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body:Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
           child: Expanded(
             child: PageView(
               controller: _tabsPageController,
               onPageChanged: (num){
                 setState(() {
                 _selectedTab=num;
                 });
               },
               children: <Widget>[
                HomeTab(),
                 SearchTab(),
               SavedTab()
               
               ],
             ),
           ),
          ),
         BottomTabs(
         selectedTab: _selectedTab,
           tabPressed: (num){
            _tabsPageController.animateToPage(num,
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInOutCubic);
           },
         ),
        ],
      )
    );
  }
}
