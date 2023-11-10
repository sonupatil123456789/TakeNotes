import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:notes/controllers/auth_controllers.dart';
import 'package:notes/controllers/notes_controllers.dart';
import 'package:notes/utils/constants/assets.dart';
import 'package:provider/provider.dart';

import '../utils/routes/routes_name.dart';

class SplashSCreen extends StatefulWidget {
  const SplashSCreen({super.key});

  @override
  State<SplashSCreen> createState() => _SplashSCreenState();
}

class _SplashSCreenState extends State<SplashSCreen> {

    AuthControllers authController = AuthControllers();


  @override
  void initState() {
    super.initState();
    authController = Provider.of<AuthControllers>(context, listen: false);
    authController.authanticateUser(context);



  }


 

  @override
  Widget build(BuildContext context) {
    double screenheight = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: HexColor("#F7F4FB"),
      body: Center(
        child: Container(
            width: screenwidth * 0.40,
            height: screenheight * 0.20,
            ),
      ),
    );
  }
}