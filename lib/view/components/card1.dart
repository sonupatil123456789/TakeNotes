import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Card1 extends StatefulWidget {
  String title;
  String discription;
  dynamic index;
  dynamic notesData;
  Function slideToDelet;
  Function onPressButton;

  Card1({
    super.key,
    required this.title,
    required this.discription,
    required this.index,
    required this.slideToDelet,
    required this.onPressButton,
    required this.notesData,
  });

  @override
  State<Card1> createState() => _Card1State();
}

class _Card1State extends State<Card1> {
  Widget build(BuildContext context) {
    final dynamic screenhight = MediaQuery.of(context).size.height;
    final dynamic screenwidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        widget.onPressButton(widget.index, widget.notesData);
      },
      child: Dismissible(
        key: Key(widget.index.toString()),
        onDismissed: (direction) {
          widget.slideToDelet(widget.index);
        },
        child: Container(
            width: screenwidth * 0.46,
            height: screenwidth * 0.46,
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
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: Image.network(
                  widget.discription,
                  fit: BoxFit.contain,
                ))
                ),
      ),
    );
  }
}
