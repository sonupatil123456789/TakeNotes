import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:notes/utils/routes/routes_name.dart';
import 'package:notes/view/components/coustom_button.dart';

import '../../utils/seassion_manager.dart';

class NotUser extends StatelessWidget {
  const NotUser({super.key});

  @override
  Widget build(BuildContext context) {
    final dynamic screenhight = MediaQuery.of(context).size.height;
    final dynamic screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error,
              size: 40,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text("Please login"),
            const SizedBox(
              height: 10,
            ),
            CommonButton(
                width: screenwidth * 0.50,
                height: screenhight * 0.05,
                btnTitle: "Login Out",
                btnColor: HexColor("#0D2A3C"),
                onTapHandler: () async {
                  await SeassionManager.removeObjectFromSharedPreferences(
                      "User");
                  Navigator.popUntil(context, (route) => route.isFirst);
                  Navigator.pushNamed(context, RoutesName.authantication);
                }),
          ],
        ),
      ),
    );
  }
}
