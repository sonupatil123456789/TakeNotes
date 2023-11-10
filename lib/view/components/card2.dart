import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class Card2 extends StatefulWidget {
  String title;
  String discription;
  dynamic index;
  dynamic notesData ;
  Function slideToDelet;
  Function onPressButton;
  

  Card2({
    super.key,
    required this.title,
    required this.discription,
    required this.index,
    required this.slideToDelet,
    required this.onPressButton,
    required this.notesData,
  });

  @override
  State<Card2> createState() => _Card2State();
}

class _Card2State extends State<Card2> {
  Widget build(BuildContext context) {
    final dynamic screenhight = MediaQuery.of(context).size.height;
    final dynamic screenwidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
      widget.onPressButton(widget.index ,widget.notesData);
      },
      child: Dismissible(
        key: Key(widget.index.toString()),
        onDismissed: (direction) {
          widget.slideToDelet(widget.index);
        },
        child: Container(
          width: screenwidth * 0.46,
          height: screenhight * 0.24,
          padding: EdgeInsets.symmetric(
              horizontal: screenwidth * 0.03, vertical: screenwidth * 0.03),
          decoration: BoxDecoration(
            color: HexColor('#FFFFFF'),
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Color(0x337c99b3),
                blurRadius: 30,
                offset: Offset(6, 6),
              ),
              BoxShadow(
                color: Color(0x1c5690c5),
                blurRadius: 4,
                offset: Offset(2, 2),
              ),
            ],
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  child: Text(
                    widget.title ?? "",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: screenwidth * 0.038,
                        color: HexColor('#123D5B')),
                  ),
                ),
                const SizedBox(
                  height: 2,
                ),
                Expanded(
                  child: SizedBox(
                    child: Text(
                      widget.discription ?? "",
                      overflow: TextOverflow.fade,
                      style: GoogleFonts.notoSans(
                          fontWeight: FontWeight.w400,
                          fontSize: screenwidth * 0.032,
                          color: HexColor('#455F70')),
                    ),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
