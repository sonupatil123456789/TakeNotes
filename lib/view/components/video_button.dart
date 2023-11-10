import 'package:flutter/material.dart';

class controlButtons extends StatefulWidget {
  IconData buttonname;
  String buttonvalue;
  Function buttonfunction;
  controlButtons(
      {super.key,
      required this.buttonname,
      required this.buttonvalue,
      required this.buttonfunction});

  @override
  State<controlButtons> createState() => _controlButtonsState();
}

class _controlButtonsState extends State<controlButtons> {
  @override
  Widget build(BuildContext context) {
    double screenheight = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.buttonfunction();
        });
      },
      child: Container(
          width: screenwidth * 0.30,
          height: screenheight * 0.18,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white60.withOpacity(0.1),
          ),
          child: Icon(
            widget.buttonname,
            color: Colors.white60.withOpacity(0.8),
            size: screenwidth * 0.15,
          )),
    );
  }
}
