import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quotes_app/screens/main_page.dart';
import 'package:quotes_app/services/icons_provider.dart';
import 'package:quotes_app/services/quote_provider.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder:
              (context) => MultiProvider(
                providers: [
                  ChangeNotifierProvider(create: (context) => QuoteProvider()),
                  ChangeNotifierProvider(create: (context) => IconsProvider()),
                ],
                child: MainPage(),
              ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        child: Image(
          image: AssetImage('assets/images/quotes_app.png'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
