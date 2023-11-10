import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:notes/controllers/auth_controllers.dart';
import 'package:provider/provider.dart';
import '../../utils/input_field_utils.dart';
import '../components/coustom_button.dart';
import '../components/coustom_textfield.dart';

class SigneupScreen extends StatefulWidget {
  @override
  State<SigneupScreen> createState() => _SigneupScreenState();
}

class _SigneupScreenState extends State<SigneupScreen> {
  final formkey = GlobalKey<FormState>();

  late Map inputFieldData = {};

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
              controller: InputFielUtils.nameController,
              isPasswordTextField: false,
              labelText: 'Name',
              maxline: 1,
              placeholder: 'Enter your name',
              width: screenwidth * 0.80,
              FocusNodeNames: InputFielUtils.nameFocusNode,
              changeFocusNode: InputFielUtils.emailFocusNode,
              iconName: Icons.email,
            ),
            CoustomTextfield(
              controller: InputFielUtils.emailController,
              isPasswordTextField: false,
              labelText: 'Email',
              maxline: 1,
              placeholder: 'Enter your email',
              width: screenwidth * 0.80,
              FocusNodeNames: InputFielUtils.emailFocusNode,
              changeFocusNode: InputFielUtils.nameFocusNode,
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
                    btnTitle: "Signe Up",
                    btnColor: HexColor("#0D2A3C"),
                    onTapHandler: () async {
                      await authValue.signUpwithEmailPassword(
                          context,
                          InputFielUtils.emailController.text.toString(),
                          InputFielUtils.passowrdController.text.toString(),
                          InputFielUtils.nameController.text.toString());

                      // Navigator.pushNamed(context, RoutesName.app);
                    });
              },
            ),
          ]),
    );
  }
}
