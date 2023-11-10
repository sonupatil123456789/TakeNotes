import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import 'package:notes/controllers/notes_controllers.dart';
import 'package:notes/repository/firebase_realtime%20_db.dart';
import 'package:notes/utils/constants/assets.dart';
import 'package:notes/utils/constants/static_data.dart';
import 'package:notes/utils/input_field_utils.dart';
import 'package:notes/utils/routes/routes_name.dart';
import 'package:notes/utils/seassion_manager.dart';
import 'package:notes/view/components/coustom_button.dart';
import 'package:notes/view/exceptionscreen/not_user.dart';
import 'package:provider/provider.dart';

import 'view/components/paragraph_text.dart';

class App extends StatefulWidget {
  App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  NotesControllers notesController = NotesControllers();

  FirebaseRealTimeDatabase firebaseRealTimeDatabase =
      FirebaseRealTimeDatabase();

  @override
  void initState() {
    super.initState();
    notesController = Provider.of<NotesControllers>(context, listen: false);
    notesController.validateUserToken();
  }

  int ScreenIndex = 0;

  @override
  Widget build(BuildContext context) {
    final dynamic screenhight = MediaQuery.of(context).size.height;
    final dynamic screenwidth = MediaQuery.of(context).size.width;
    return Consumer<NotesControllers>(builder:
        (BuildContext context, NotesControllers notesValue, Widget? child) {
      return Scaffold(
          key: InputFielUtils.scaffoldKey,
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: HexColor("#0D2A3C"),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: screenwidth * 0.20,
                        height: screenwidth * 0.20,
                        decoration: BoxDecoration(
                          // color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Lottie.asset(
                              AssetImgLinks.profile,
                              fit: BoxFit.fill,
                            )),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        notesValue.seassionData == null
                            ? "loading..."
                            : notesValue.seassionData['userEmail'].toString(),
                        style: GoogleFonts.poppins(
                            fontSize: screenwidth * 0.040,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      )
                    ],
                  ),
                ),
                ListView.builder(
                  itemCount: StaticData.drawerDatas.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    var drawerData = StaticData.drawerDatas[index];
                    return ListTile(
                      leading: Icon(
                        drawerData.icon,
                      ),
                      title: Text(drawerData.name.toString()),
                      onTap: () {
                        setState(() {
                          ScreenIndex = index;
                          if (InputFielUtils
                              .scaffoldKey.currentState!.isDrawerOpen) {
                            InputFielUtils.scaffoldKey.currentState!
                                .closeDrawer();
                          } else {
                            InputFielUtils.scaffoldKey.currentState!
                                .openDrawer();
                          }
                        });
                      },
                    );
                  },
                ),
                SizedBox(
                  height: screenhight * 0.20,
                ),
                Center(
                  child: CommonButton(
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
                )
              ],
            ),
          ),
          body: Container(
            child: SafeArea(
              child: (notesValue.seassionData['token'].toString() == null
                  ? const NotUser()
                  : StaticData.screens[ScreenIndex]),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniEndFloat,
          floatingActionButton: FloatingActionButton(
            backgroundColor: HexColor("#0D2A3C"),
            onPressed: () {
              var userId = notesValue.seassionData['uid'];

              howCoustomBottomSheet(context, screenwidth, screenhight,
                  StaticData.bottomSheetData, userId);
            },
            child: const Icon(Icons.add),
          ));
    });
  }

  howCoustomBottomSheet(
      context, screenwidth, screenhight, bottomSheetData, userId) {
    return showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: screenhight * 0.32,
          child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: ListView.builder(
                itemCount: bottomSheetData.length,
                itemBuilder: (BuildContext context, int index) {
                  var drawerData = bottomSheetData[index];

                  return ListTile(
                    leading: Icon(
                      drawerData["icon"],
                    ),
                    title: Text(
                      drawerData["name"],
                    ),
                    onTap: () async {
                      if (drawerData["name"] == "Image") {
                        dynamic imageFile =
                            await InputFielUtils.getMyFile([], FileType.image);

                        // ignore: use_build_context_synchronously
                        await notesController.uploadFiles(context, imageFile,
                            "uploadimages", "IMAGE-FILE", userId);
                      }
                      if (drawerData["name"] == "File") {
                        dynamic imageFile = await InputFielUtils.getMyFile(
                            ['pdf', 'doc'], FileType.custom);

                        // ignore: use_build_context_synchronously
                        await notesController.uploadFiles(context, imageFile,
                            "uploadfiles", "DOCUMENT-FILE", userId);
                      }
                      if (drawerData["name"] == "Video") {
                        dynamic imageFile =
                            await InputFielUtils.getMyFile([], FileType.video);

                        // ignore: use_build_context_synchronously
                        await notesController.uploadFiles(context, imageFile,
                            "uploadvideo", "VIDEO-FILE", userId);
                      }
                      if (drawerData["name"] == "Notes") {
                        // ignore: use_build_context_synchronously
                        Navigator.pushNamed(
                            context, RoutesName.createNotesScreen);
                      }
                    },
                  );
                },
              )),
        );
      },
    );
  }
}
