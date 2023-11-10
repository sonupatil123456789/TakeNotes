import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SocialButton extends StatelessWidget {
  double width;
  double height;
  String btnTitle;
  Color btnColor;
  Color btnTextColor;
  Function onTapHandler;
  dynamic iconImage;
  SocialButton(
      {super.key,
      required this.width,
      required this.height,
      required this.btnTitle,
      required this.btnColor,
      required this.btnTextColor,
      required this.onTapHandler,
      required this.iconImage});

  @override
  Widget build(BuildContext context) {
    final dynamic screenhight = MediaQuery.of(context).size.height;
    final dynamic screenwidth = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        onTapHandler();
      },
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: btnColor,

            ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(iconImage,
                width: 36, height: 36, semanticsLabel: 'Cart'),
            const SizedBox(
              width: 18,
            ),
            Text(
              btnTitle,
              style: GoogleFonts.poppins(
                  color: btnTextColor,
                  fontSize: screenwidth * 0.034,
                  fontWeight: FontWeight.w500),
            )
          ],
        ),
      ),
    );
  }
}
