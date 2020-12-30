import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pubdz_shopping/firebase_services/firebase_services.dart';
import 'package:pubdz_shopping/screens/product_details.dart';
import 'package:pubdz_shopping/widgets/custom_action_bar.dart';
import 'package:pubdz_shopping/widgets/product_Card.dart';

class HomeTab extends StatefulWidget {

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  FirebaseServices _firebaseServices=FirebaseServices();



  @override
  Widget build(BuildContext context) {
    return Container(
       child: Stack(
         children: <Widget>[
         FutureBuilder<QuerySnapshot>(
           future: _firebaseServices.productsRef.get(),
           builder: (context,snapshot){
             if(snapshot.hasError){
               return Scaffold(
                 body: Center(
                   child: Text("Error${snapshot.error}"),
                 ),
               );
             }
            if(snapshot.connectionState==ConnectionState.done){
                   return ListView(
                     padding: EdgeInsets.only(
                       top: 100,
                       bottom: 12
                     ),
                     children: snapshot.data.docs.map((document) {

                       return ProductCart(
                         onPressed: (){
                           Navigator.push(context, MaterialPageRoute(
                               builder: (context)=>ProductDetails(productId: document.id,)
                           ));
                         },
                         imageUrl: document.data()["images"][0],
                         title: document.data()['name'],
                         price: '${document.data()['price']}',

                       );
                     }).toList(),
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
             hasBackArrow: false,
             hasTitle: true,
             title: 'Home',
           )
         ],
       ),
    );
  }
}

