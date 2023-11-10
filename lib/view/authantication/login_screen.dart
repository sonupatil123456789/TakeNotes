import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:notes/controllers/auth_controllers.dart';
import 'package:provider/provider.dart';
import '../../utils/input_field_utils.dart';
import '../components/coustom_button.dart';
import '../components/coustom_textfield.dart';
// import 'package:mystore/view/screens/signeup_screen.dart';

class loginScreen extends StatefulWidget {
  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  final formkey = GlobalKey<FormState>();

  late Map inputFieldData;

  @override
  Widget build(BuildContext context) {
    double screenheight = MediaQuery.of(context).size.height;
    double screenwidth = MediaQuery.of(context).size.width;
    return Form(
      key: formkey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CoustomTextfield(
              controller: InputFielUtils.emailController,
              isPasswordTextField: false,
              labelText: 'Email',
              maxline: 1,
              placeholder: 'Enter your email',
              width: screenwidth * 0.80,
              FocusNodeNames: InputFielUtils.emailFocusNode,
              changeFocusNode: InputFielUtils.passwordFocusNode,
              iconName: Icons.email,
            ),
            CoustomTextfield(
              controller: InputFielUtils.passowrdController,
              isPasswordTextField: true,
              labelText: 'Password',
              maxline: 1,
              placeholder: 'Enter your password',
              width: screenwidth * 0.80,
              FocusNodeNames: InputFielUtils.passwordFocusNode,
              changeFocusNode: InputFielUtils.passwordFocusNode,
              iconName: Icons.lock,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(screenwidth * 0.52, 0, 0, 0),
              child: GestureDetector(
                onTap: () {},
                child: Text(
                  "Forgot password",
                  style: GoogleFonts.notoSans(
                      fontSize: screenwidth * 0.032,
                      color: Color.fromARGB(255, 148, 148, 148),
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),


        
            SizedBox(
              height: screenheight * 0.02,
            ),

                Consumer<AuthControllers>(
              builder: (BuildContext context, AuthControllers authValue,
                  Widget? child) {


                if (authValue.loading== true ) {
                   return   Container(
                    width: screenwidth * 0.80,
                    height: screenheight*0.08,
                    child: Center(child: CircularProgressIndicator(color: HexColor("#DE5123")))   
                    )
                    ;
                }

                return CommonButton(
                    width: screenwidth * 0.80,
                    height: screenheight * 0.056,
                    btnTitle: "Login In",
                    btnColor: HexColor("#0D2A3C"),
                    onTapHandler: () async{
                      await authValue.signInwithEmailPassword(
                          context,
                          InputFielUtils.emailController.text.toString(),
                          InputFielUtils.passowrdController.text.toString(),
                          );

                      // Navigator.pushNamed(context, RoutesName.app);
                    });
              },
            ),
        

          ]),
    );
  }
}
