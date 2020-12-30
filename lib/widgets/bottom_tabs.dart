import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomTabs extends StatefulWidget {
  final int selectedTab;
  final Function(int) tabPressed;
  BottomTabs({this.selectedTab,this.tabPressed});
  @override
  _BottomTabsState createState() => _BottomTabsState();
}

class _BottomTabsState extends State<BottomTabs> {
  int _selectedTab=0;

  @override
  Widget build(BuildContext context) {
    _selectedTab=widget.selectedTab??0;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10)
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2.0,
                blurRadius: 20
              )
            ]

      ),
       child: Row(
         mainAxisAlignment: MainAxisAlignment.spaceAround,

         children: <Widget>[
           BottomTabsBtn(
             imagePath: 'assets/images/tab_home.png',
             selected: _selectedTab==0? true:false,
             onPressed: (){
              widget.tabPressed(0);
             },
           ),
           BottomTabsBtn(
             imagePath: 'assets/images/tab_search.png',
             selected: _selectedTab==1? true:false,
             onPressed: (){
               widget.tabPressed(1);
             },

           ),
           BottomTabsBtn(
            imagePath: 'assets/images/tab_saved.png',
             selected: _selectedTab==2? true:false,
             onPressed: (){
               widget.tabPressed(2);
             },

           ),
           BottomTabsBtn(
             imagePath: 'assets/images/tab_logout.png',
             selected: _selectedTab==3? true:false,
             onPressed: (){
              FirebaseAuth.instance.signOut();
             },

           ),
         ],
       ),
    );
  }
}
class BottomTabsBtn extends StatelessWidget {
  final String imagePath;
   final bool  selected;
   final Function onPressed;
  const BottomTabsBtn({Key key, this.imagePath,this.onPressed,this.selected}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    bool _isSelected=selected??false;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 12
        ),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color : _isSelected? Theme.of(context).accentColor: Colors.transparent
            )
          )
        ),
        child: Image(

          height: 26,
          width: 26,
          image: AssetImage(imagePath),
          color:  _isSelected? Theme.of(context).accentColor: Colors.black
        ),
      ),
    );
  }
}
