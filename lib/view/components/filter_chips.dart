import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class FilterChips extends StatefulWidget {
  FilterChips({super.key});

  @override
  State<FilterChips> createState() => _FilterChipsState();
}

class _FilterChipsState extends State<FilterChips> {
  List catogarys = [
    "Coffee",
    "Buisness",
    "Dinner",
    "Friendship",
    "Dating",
    "Movies",
    "Marry"
  ];

  bool favorite = false;
  final List<String> _filters = <String>[];
  late bool textColor = false;

  @override
  Widget build(BuildContext context) {
    final dynamic screenhight = MediaQuery.of(context).size.height;
    final dynamic screenwidth = MediaQuery.of(context).size.width;
    return Wrap(
      spacing: 5.0,
      children: catogarys.map((catogary) {
        print(catogary);
        return FilterChip(
          selectedColor: HexColor("#0D2A3C"),
          labelStyle: GoogleFonts.notoSans(
              fontWeight: FontWeight.w400,
              fontSize: screenwidth * 0.032,
              color: _filters.contains(catogary) == true
                  ? Colors.white
                  : HexColor('#133C58')),
          backgroundColor: Colors.white,
          label: Text(
            catogary,
          ),
          selected: _filters.contains(catogary),

          shape: StadiumBorder(side: BorderSide()),
          checkmarkColor: Colors.white,
          onSelected: (bool value) {
            setState(() {
              textColor = value;
              if (value) {
                if (!_filters.contains(catogary)) {
                  _filters.add(catogary);
                }
              } else {
                _filters.removeWhere((String name) {
                  return name == catogary;
                });
              }
            });
          },
        );
      }).toList(),
    );
  }
}
