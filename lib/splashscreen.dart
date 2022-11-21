import 'package:flutter/material.dart';
import 'package:flutter_application_1/Homepage.dart';
import 'package:shimmer/shimmer.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  gettomainpage(context) async {
    await Future.delayed(const Duration(seconds: 2));
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Homepage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    gettomainpage(context);
    return Material(
        child: Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.black,
      child: Center(
          child: Shimmer.fromColors(
              highlightColor: Colors.white,
              baseColor: Colors.transparent,
              child: Image.asset("assets/images/logo/logo.png"))),
    ));
  }
}
