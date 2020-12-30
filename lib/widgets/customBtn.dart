import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Color color;
 final bool outlines;
  final String text;
  final Function onPressed;
  final bool isLoading;
  const CustomButton({Key key,this.outlines, this.color, this.text,this.onPressed,this.isLoading}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    bool _outlinesBtn=outlines?? true;
    bool _isLoading=isLoading??false;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 65,
        decoration: BoxDecoration(
          color: _outlinesBtn ?Colors.transparent: Colors.black,
          border: Border.all(
            width: 2.0,
            color: Colors.black
          ),
              borderRadius: BorderRadius.circular(12),

        ),
        margin: EdgeInsets.symmetric(horizontal: 24,vertical: 8),
        child: Stack(
          children: <Widget>[
            Visibility(
              visible: _isLoading ? false:true,
              child:  Center(
                child: Text(text??'Text',style:
                TextStyle(fontWeight: FontWeight.bold,color: _outlinesBtn? Colors.black:Colors.white,fontSize: 16),),
              ),
            ),

            Visibility(
              visible: _isLoading,
              child: Center(
                child: SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(),
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
