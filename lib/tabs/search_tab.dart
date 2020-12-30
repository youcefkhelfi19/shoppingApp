import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pubdz_shopping/constants.dart';
import 'package:pubdz_shopping/firebase_services/firebase_services.dart';
import 'package:pubdz_shopping/screens/product_details.dart';
import 'package:pubdz_shopping/widgets/custom_input.dart';
import 'package:pubdz_shopping/widgets/product_Card.dart';

class SearchTab extends StatefulWidget {
  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
   FirebaseServices _firebaseServices=FirebaseServices();

    String _searchString = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
            if(_searchString.isEmpty)
              Center(
                child: Text("Search result", style: Constants.regularDarkText,),
              )
            else
          FutureBuilder<QuerySnapshot>(
            future: _firebaseServices.productsRef.orderBy("name").startAt([_searchString]).endAt(["$_searchString\uf8ff"]).get(),
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
                      top: 120,
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
          Padding(
            padding: const EdgeInsets.only(top: 45),
            child: CustomInput(
              hintText: 'Search ..',
              onSubmitted: (value){

                setState(() {
                  _searchString=value;
                });

              },
            ),
          ),


        ],
      )
    );
  }
}