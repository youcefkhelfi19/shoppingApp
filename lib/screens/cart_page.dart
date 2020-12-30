import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pubdz_shopping/firebase_services/firebase_services.dart';
import 'package:pubdz_shopping/screens/product_details.dart';
import 'package:pubdz_shopping/widgets/custom_action_bar.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  FirebaseServices _firebaseServices=FirebaseServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          FutureBuilder<QuerySnapshot>(
            future: _firebaseServices.userRef.doc(_firebaseServices.getUserId()).collection('Cart').get(),
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

                    return InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(
                            builder: ((context)=>ProductDetails(productId: document.id,))
                        ));
                      },
                      child: FutureBuilder(
                        future: _firebaseServices.productsRef.doc(document.id).get(),
                        builder: (context,productSnap){
                         if(productSnap.hasError){
                           return Container(
                             child: Center(
                               child: Text("${productSnap.error}"),
                             ),
                           );
                         }
                         if(productSnap.connectionState==ConnectionState.done){
                           Map _productMap=productSnap.data.data();
                           return Padding(
                             padding: const EdgeInsets.symmetric(
                               vertical: 10.0,
                               horizontal: 20.0,
                             ),
                             child: Container(
                               decoration: BoxDecoration(
                                 color: Colors.black12,
                                 borderRadius: BorderRadius.circular(8)
                               ),
                               child: Row(
                                 mainAxisAlignment:
                                 MainAxisAlignment.start,
                                 children: [
                                   Container(
                                     width: 90,
                                     height: 90,
                                     child: ClipRRect(
                                       borderRadius:
                                       BorderRadius.circular(8.0),
                                       child: Image.network(
                                         "${_productMap['images'][0]}",
                                         fit: BoxFit.cover,
                                       ),
                                     ),
                                   ),
                                   Container(
                                     padding: EdgeInsets.only(
                                       left: 16.0,
                                     ),
                                     child: Column(
                                       mainAxisAlignment:
                                       MainAxisAlignment.start,
                                       crossAxisAlignment:
                                       CrossAxisAlignment.start,
                                       children: [
                                         Text(
                                           "${_productMap['name']}",
                                           style: TextStyle(
                                               fontSize: 18.0,
                                               color: Colors.black,
                                               fontWeight:
                                               FontWeight.bold),
                                         ),
                                         Padding(
                                           padding: const EdgeInsets
                                               .symmetric(
                                             vertical: 4.0,
                                           ),
                                           child: Text(
                                             "${_productMap['price']} DA",
                                             style: TextStyle(
                                                 fontSize: 16.0,
                                                 color: Theme.of(context)
                                                     .accentColor,
                                                 fontWeight:
                                                 FontWeight.w600),
                                           ),
                                         ),
                                         Text(
                                           "Size : ${document.data()['size']}",
                                           style: TextStyle(
                                               fontSize: 16.0,
                                               color: Colors.black,
                                               fontWeight:
                                               FontWeight.w600),
                                         ),
                                       ],
                                     ),
                                   ),
                                 ],
                               ),
                             ),
                           );

                         }
                         return Container(
                           child: Center(
                             child: CircularProgressIndicator(),
                           ),
                         ) ;
                        },
                      )
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
            hasBackArrow: true,
            title: 'Cart',
          )
        ],
      ),
    );
  }
}
