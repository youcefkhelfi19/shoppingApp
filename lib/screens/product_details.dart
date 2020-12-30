import 'package:flutter/material.dart';
import 'package:pubdz_shopping/constants.dart';
import 'package:pubdz_shopping/firebase_services/firebase_services.dart';
import 'package:pubdz_shopping/widgets/custom_action_bar.dart';
import 'package:pubdz_shopping/widgets/images_swip.dart';
import 'package:pubdz_shopping/widgets/product_size.dart';

class ProductDetails extends StatefulWidget {
  final String productId;

  ProductDetails({this.productId});

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  FirebaseServices _firebaseServices=FirebaseServices();


  String _sizeSelected="0";
  Future _addToCart(){
    return _firebaseServices.userRef.doc
      (_firebaseServices.getUserId()).collection("Cart").doc(widget.productId).set({
      'size':_sizeSelected
    });
  }
  Future _save(){
    return _firebaseServices.userRef.doc
      (_firebaseServices.getUserId()).collection("Saved").doc(widget.productId).set({
      'size':_sizeSelected
    });
  }
SnackBar _snackBar=SnackBar(content: Text('Item Added successfully'),);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          FutureBuilder(
            future: _firebaseServices.productsRef.doc(widget.productId).get(),
            builder: (context,snapshot){
          if(snapshot.hasError){
            return Scaffold(
             body: Center(
             child: Text("Error${snapshot.error}"),
          ),
          );
          }
          if(snapshot.connectionState==ConnectionState.done){
            Map<String, dynamic> documentData=snapshot.data.data();
            List imagesLIst=documentData['images'];
            List productSizes=documentData['size'];
            _sizeSelected=productSizes[0];
            return ListView(
              padding: EdgeInsets.all(0),
             children: <Widget>[
              ImagesSwipe(
                imagesList: imagesLIst,
              ),
               Padding(
                 padding: const EdgeInsets.fromLTRB(
                   20,20,20,5
                 ),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: <Widget>[
                     Text('${documentData['name']}',
                       style: Constants.boldHeading,),
                     Text('${documentData['price']} DA',
                       style: TextStyle(
                           color: Theme.of(context).accentColor,
                           fontSize: 18,
                           fontWeight: FontWeight.bold
                       ),
                     ),
                   ],
                 ),
               ),


               Padding(
                 padding: const EdgeInsets.symmetric(
                     vertical: 8,
                     horizontal: 24
                 ),
                 child: Text('${documentData['description']}',
                 style: TextStyle(
                   fontSize: 16
                 ),
                 ),
               ),
               Padding(
                 padding: const EdgeInsets.symmetric(
                     vertical: 8,
                     horizontal: 24
                 ),
                 child: Text('Select Size:',
                   style: Constants.regularDarkText,
                 ),
               ),

               ProductSize(
                  productSizes: productSizes,
                 onSizeSelected: (size){
                    _sizeSelected=size;
                 },
               ),

             Padding(
               padding: const EdgeInsets.all(20.0),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.start,
                 children: <Widget>[
                   GestureDetector(
                   onTap: ()async{
                     await _save();
                     Scaffold.of(context).showSnackBar(_snackBar);
                   },
                     child: Container(
                       height: 60,
                       width: 60,
                       alignment:Alignment.center,
                       decoration: BoxDecoration(

                         borderRadius: BorderRadius.circular(8),
                         color: Color(0xffdcdcdc),
                       ),
                       child: Image(
                         image: AssetImage(
                           'assets/images/tab_saved.png',
                         ),
                         height: 25,
                       ),
                     ),
                   ),
                   Expanded(
                     child: GestureDetector(
                       onTap: ()async{
                         await _addToCart();
                         Scaffold.of(context).showSnackBar(_snackBar);
                       },
                       child: Container(
                         height:60,
                         margin: EdgeInsets.only(left: 20),
                         alignment: Alignment.center,
                         decoration: BoxDecoration(
                           color: Colors.black,
                           borderRadius: BorderRadius.circular(8)
                         ),
                         child: Text(
                           'Add to cart',
                           style: TextStyle(
                             fontWeight: FontWeight.bold,
                             fontSize: 18,
                             color: Colors.white
                           ),
                         ),
                       ),
                     ),
                   )

                 ],
               ),
             )
             ], 
            );
          }
             return Scaffold(
                 body: Center(
                   child: CircularProgressIndicator(),
          ),
          );
          },
          ),
          CustomActionBar(
            hasBackArrow: true,
            hasTitle: false,
            hasBackGround: false,
          )
        ],
      ),
    );
  }
}
