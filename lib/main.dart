import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pubdz_shopping/screens/landing_page.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        backgroundColor: Colors.white,
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme
        ),
        accentColor: Color(0xffff1e00)
      ),
      debugShowCheckedModeBanner: false,
      home: LandingPage()
    );
  }
}

