import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pubdz_shopping/constants.dart';
import 'package:pubdz_shopping/firebase_services/firebase_services.dart';
import 'package:pubdz_shopping/screens/cart_page.dart';

class CustomActionBar extends StatefulWidget {
  final String title;
  final bool hasBackArrow;
  final bool hasTitle;
  final bool hasBackGround;

  CustomActionBar({this.hasBackGround,this.hasTitle,this.hasBackArrow, this.title});

  @override
  _CustomActionBarState createState() => _CustomActionBarState();
}

class _CustomActionBarState extends State<CustomActionBar> {
  FirebaseServices _firebaseServices=FirebaseServices();



  @override
  Widget build(BuildContext context) {
    bool _hasBackArrow=widget.hasBackArrow?? false;
    bool _hasTitle=widget.hasTitle??true;
    bool _hasBackGround=widget.hasBackGround??true;
    return Container(
      decoration: BoxDecoration(
        gradient:_hasBackGround ? LinearGradient(
          colors: [
            Colors.white,
            Colors.white.withOpacity(0)
          ],
            begin: Alignment(0,0),
          end:  Alignment(0,1)
        ):null
      ),
      padding: EdgeInsets.fromLTRB(24, 56, 24, 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          if(_hasBackArrow)
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Container(
                alignment: Alignment.center,
                height: 42,
                width: 42,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8)
                ),
                child: Image(
                  image: AssetImage(
                    'assets/images/back_arrow.png'
                  ),
                  width: 16,
                  height: 16,
                ),
              ),
            ),
          if(_hasTitle)
          Text(
           widget.title?? 'Action bar',

            style: Constants.boldHeading,
          ),
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(
                builder: (context)=>CartPage()
              ));
            },
            child: Container(
              alignment: Alignment.center,
              height: 42,
              width: 42,
              decoration: BoxDecoration(
                color:  Colors.black,
                borderRadius: BorderRadius.circular(8)
              ),
              child: StreamBuilder(
                stream: _firebaseServices.userRef.doc(_firebaseServices.getUserId()).collection('Cart').snapshots(),
                builder: (context,snapshot){
                  int _totalItems=0;
                  if(snapshot.connectionState==ConnectionState.active ){
                    List _documents=snapshot.data.docs;
                    _totalItems=_documents.length;
                  }
                  return Text(
                  '$_totalItems'??'0',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                    ),
                  );
                },
              )
            ),
          )
        ],
      ),
    );
  }
}
