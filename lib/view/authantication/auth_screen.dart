import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:notes/controllers/auth_controllers.dart';
import 'package:notes/utils/routes/routes_name.dart';
import 'package:notes/view/components/social_button.dart';
import 'package:provider/provider.dart';
import '../../utils/constants/assets.dart';
import '../../utils/constants/colorpallets.dart';
import 'login_screen.dart';
import 'signeup_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  ValueNotifier<bool> checkAuthScreen = ValueNotifier<bool>(true);

  bool isLoginScreen = false;

  @override
  Widget build(BuildContext context) {
    double screenheight = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: HexColor("#F7F4FB"),
      body: SafeArea(
          child: SingleChildScrollView(
        child: ValueListenableBuilder(
          builder: (BuildContext context, value, Widget? child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: screenheight * 0.02,
                ),
                SizedBox(
                  width: screenwidth * 0.80,
                  height: screenheight * 0.20,
                  child: SvgPicture.asset(
                    AssetImgLinks.blueLoginAsset,
                    width: screenwidth * 0.80,
                    height: screenheight * 0.20,
                  ),
                ),
                SizedBox(
                  height: screenheight * 0.06,
                ),
                ValueListenableBuilder(
                  builder: (BuildContext context, value, Widget? child) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            checkAuthScreen.value = true;
                          },
                          child: Container(
                            width: screenwidth * 0.38,
                            height: screenheight * 0.04,
                            decoration: BoxDecoration(
                                color: checkAuthScreen.value == true
                                    ? TheamColors.primaryColor
                                    : Colors.transparent,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "LogIn",
                                  style: GoogleFonts.poppins(
                                      color: checkAuthScreen.value == true
                                          ? TheamColors.backgroundColor
                                          : HexColor("#0D2A3C"),
                                      fontSize: screenwidth * 0.032,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: screenheight * 0.02,
                        ),
                        InkWell(
                          onTap: () {
                            checkAuthScreen.value = false;
                          },
                          child: Container(
                            width: screenwidth * 0.38,
                            height: screenheight * 0.04,
                            decoration: BoxDecoration(
                                color: checkAuthScreen.value == false
                                    ? TheamColors.primaryColor
                                    : Colors.transparent,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "SigneUp",
                                  style: GoogleFonts.poppins(
                                      color: checkAuthScreen.value == false
                                          ? TheamColors.backgroundColor
                                          : HexColor("#0D2A3C"),
                                      fontSize: screenwidth * 0.032,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    );
                  },
                  valueListenable: checkAuthScreen,
                ),
                SizedBox(
                  height: screenheight * 0.01,
                ),
                Container(
                  // color: Colors.amber,
                  height: screenheight * 0.42,
                  alignment: Alignment.center,
                  child: ValueListenableBuilder(
                    valueListenable: checkAuthScreen,
                    builder: (BuildContext context, value, Widget? child) {
                      return checkAuthScreen.value == false
                          ? SigneupScreen()
                          : loginScreen();
                    },
                  ),
                ),
                SizedBox(
                  height: screenheight * 0.06,
                  width: screenwidth * 0.80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: screenwidth * 0.25,
                        height: 20,
                        child: const Divider(
                          height: 10,
                          color: Color.fromARGB(255, 148, 148, 148),
                          // indent: 20,
                          thickness: 1,
                          endIndent: 20,
                        ),
                      ),
                      Text(
                        "OR Continue With",
                        style: GoogleFonts.notoSans(
                            fontSize: screenwidth * 0.030,
                            fontStyle: FontStyle.italic,
                            color: const Color.fromARGB(255, 148, 148, 148),
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        width: screenwidth * 0.25,
                        height: 20,
                        child: const Divider(
                          height: 10,
                          color: Color.fromARGB(255, 148, 148, 148),
                          indent: 20,
                          thickness: 1,
                          // endIndent: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: screenheight * 0.06,
                ),
                Consumer<AuthControllers>(
                  builder: (BuildContext context, AuthControllers authValue,
                      Widget? child) {
                    if (checkAuthScreen.value == false) {
                      return SocialButton(
                        width: screenwidth * 0.80,
                        height: screenheight * 0.06,
                        btnTitle: "SigneUp With Google",
                        btnColor: Colors.redAccent,
                        onTapHandler: () async {
                          await authValue.signUpwithGoogle(context);
                        },
                        iconImage: AssetImgLinks.google,
                        btnTextColor: TheamColors.backgroundColor,
                      );
                    } else {
                      return SocialButton(
                        width: screenwidth * 0.80,
                        height: screenheight * 0.06,
                        btnTitle: "LogIn With Google",
                        btnColor: Colors.redAccent,
                        onTapHandler: () async {
                          await authValue.signInwithGoogle(context);
                        },
                        iconImage: AssetImgLinks.google,
                        btnTextColor: TheamColors.backgroundColor,
                      );
                    }
                  },
                ),
              ],
            );
          },
          valueListenable: checkAuthScreen,
        ),
      )),
    );

  }

}
