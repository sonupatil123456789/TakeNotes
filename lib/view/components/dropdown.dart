import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../utils/constants/assets.dart';
import '../../utils/constants/colorpallets.dart';

class DropdownBtn extends StatefulWidget {
  const DropdownBtn({super.key});

  @override
  State<DropdownBtn> createState() => _DropdownBtnState();
}

class _DropdownBtnState extends State<DropdownBtn> {
  var dropdownValue = "Avalable | Hey Let Us Connect";

  var list = <String>[
    "Avalable | Hey Let Us Connect",
    "Away | Stay Discreat And Watch",
    "Busy | Do Not Disturb | We Will Catch Up Later",
    "SOS | Emergancy ! Need Assistance ! HELP ",
  ];

  @override
  Widget build(BuildContext context) {
    final dynamic screenhight = MediaQuery.of(context).size.height;
    final dynamic screenwidth = MediaQuery.of(context).size.width;
    return DropdownButton<String>(
      value: dropdownValue,
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 0,
        color: TheamColors.backgroundColor,
      ),
      onChanged: (String? value) {
        setState(() {
          dropdownValue = value!;
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: GoogleFonts.notoSans(
                fontWeight: FontWeight.w400,
                fontSize: screenwidth * 0.034,
                color: HexColor('#133C58')),
          ),
        );
      }).toList(),
    );
  }
}
