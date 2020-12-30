import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImagesSwipe extends StatefulWidget {
  final List imagesList;
  ImagesSwipe({this.imagesList});
  @override
  _ImagesSwipeState createState() => _ImagesSwipeState();
}

class _ImagesSwipeState extends State<ImagesSwipe> {
  int _selectedPage=0;
  @override
  Widget build(BuildContext context) {
    return  Container(
        height: 400,
        child: Stack(
          children: <Widget>[
            PageView(
              onPageChanged: (num){
               setState(() {
                 _selectedPage=num;
               });
              },
              children: <Widget>[
                for(var i =0;i<widget.imagesList.length;i++)
                  Container(
                    child: Image.network(
                      "${widget.imagesList[i]}",
                      fit: BoxFit.cover,
                    ),
                  )
              ],
            ),
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  for(var i =0;i<widget.imagesList.length;i++)
                  AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOutCubic,
                    margin: EdgeInsets.symmetric(
                      horizontal: 5
                    ),
                   width: _selectedPage ==i ?18.0:8.0,
                    height:_selectedPage ==i ?8.0: 8,
                  decoration: BoxDecoration(
                    color:_selectedPage==i ? Colors.black26:Colors.white,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  )
                ],
              ),
            )
          ],
        )
    );
  }
}
