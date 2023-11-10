import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:notes/controllers/notes_controllers.dart';
import 'package:notes/repository/firebase_realtime%20_db.dart';
import 'package:notes/utils/constants/assets.dart';
import 'package:notes/utils/input_field_utils.dart';
import 'package:notes/utils/routes/routes_name.dart';
import 'package:notes/view/components/card1.dart';
import 'package:notes/view/components/card3.dart';
import 'package:notes/view/components/card4.dart';
import 'package:notes/view/components/paragraph_text.dart';
import 'package:provider/provider.dart';
import '../components/card2.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseRealTimeDatabase firebaseRealTimeDatabase =
      FirebaseRealTimeDatabase();

  @override
  Widget build(BuildContext context) {
    final dynamic screenhight = MediaQuery.of(context).size.height;
    final dynamic screenwidth = MediaQuery.of(context).size.width;
    return Consumer<NotesControllers>(
      builder:
          (BuildContext context, NotesControllers notesValue, Widget? child) {
        var userId = notesValue.seassionData['uid'];

        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: screenwidth,
              height: screenhight * 0.14,
              child: Stack(
                children: [
                  Positioned(
                    top: screenwidth * 0.10,
                    left: screenwidth * 0.04,
                    child: InkWell(
                      onTap: () {
                        if (InputFielUtils
                            .scaffoldKey.currentState!.isDrawerOpen) {
                          InputFielUtils.scaffoldKey.currentState!
                              .closeDrawer();
                        } else {
                          InputFielUtils.scaffoldKey.currentState!.openDrawer();
                        }
                      },
                      child: SvgPicture.asset(
                        AssetImgLinks.hamBurgerIcon,
                        height: screenhight * 0.04,
                        width: screenwidth * 0.04,
                      ),
                    ),
                  ),
                  Positioned(
                    top: screenwidth * 0.08,
                    left: screenwidth * 0.20,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                    text: 'H',
                                    style: GoogleFonts.poppins(
                                        color: HexColor("#DE5123"),
                                        fontSize: screenwidth * 0.080,
                                        fontWeight: FontWeight.w800)),
                                TextSpan(
                                    text: 'ello',
                                    style: GoogleFonts.poppins(
                                        color: HexColor("#0D2A3C"),
                                        fontSize: screenwidth * 0.080,
                                        fontWeight: FontWeight.w800)),
                              ],
                            ),
                          ),
                          Ptext(
                            fonttext: notesValue.seassionData == null
                                ? "loading..."
                                : notesValue.seassionData['userName']
                                    .toString(),
                            size: screenwidth * 0.040,
                            weight: FontWeight.w400,
                          )
                        ]),
                  ),
                  Positioned(
                    top: screenwidth * 0.12,
                    right: screenwidth * 0.08,
                    child: InkWell(
                      onTap: () {},
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, RoutesName.searchScreen);
                        },
                        child: Container(
                            child: Icon(
                          Icons.search,
                          size: screenwidth * 0.07,
                        )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: screenhight * 0.02,
            ),
            Expanded(
                child: StreamBuilder<DatabaseEvent>(
              stream: firebaseRealTimeDatabase.getNotes(
                  context, userId == null ? "" : userId),
              builder: (BuildContext context,
                  AsyncSnapshot<DatabaseEvent> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: CircularProgressIndicator(
                    color: HexColor("#0D2A3C"),
                  ));
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  if (snapshot.hasData &&
                      snapshot.data != null &&
                      userId != null) {
                    if (snapshot.data!.snapshot.value != null) {
                      var databaseValue = snapshot.data!.snapshot.value as Map;
                      var notesIdList =
                          databaseValue.keys.map((e) => e).toList();

                      return GridView.builder(
                        gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1.0
                            ),
                        itemCount: notesIdList.length,
                        itemBuilder: (BuildContext context, int index) {
                          var notesId = notesIdList[index];
                          var data = databaseValue[notesId]['data'];
                          var noteType = databaseValue[notesId]['notesType'];

                          if (noteType == "IMAGE-FILE") {
                            return Padding(
                              padding: const EdgeInsets.all(8),
                              child: Card1(
                                discription: data['paragraph'].toString(),
                                title: data['title'].toString(),
                                index: notesId,
                                notesData: data,
                                slideToDelet: (uid) {
                                  notesValue.deletNotesControllerData(
                                      context, userId, uid);
         
                                },
                                onPressButton: (uid, notesData) {
                                    Navigator.pushNamed(
                                      context, RoutesName.imageReader,
                                      arguments: {
                                        "notesData": notesData
                                      });
                                },
                              ),
                            );
                          }
                          if (noteType == "DOCUMENT-FILE") {
                            return Padding(
                              padding: const EdgeInsets.all(8),
                              child: Card3(
                                discription: data['paragraph'].toString(),
                                title: data['title'].toString(),
                                index: notesId,
                                notesData: data,
                                slideToDelet: (uid) {
                                  notesValue.deletNotesControllerData(
                                      context, userId, uid);
                                 
                                },
                                onPressButton: (uid, notesData) {
                                    Navigator.pushNamed(
                                      context, RoutesName.fileReader,
                                      arguments: {
                                        "notesData": notesData
                                      });
                                },
                              ),
                            );
                          }

                          if (noteType == "VIDEO-FILE") {
                            return Padding(
                              padding: const EdgeInsets.all(8),
                              child: Card4(
                                discription: data['paragraph'].toString(),
                                title: data['title'].toString(),
                                index: notesId,
                                notesData: data,
                                slideToDelet: (uid) {
                                  notesValue.deletNotesControllerData(
                                      context, userId, uid);
                                },
                                onPressButton: (uid, notesData) {
                                  Navigator.pushNamed(
                                      context, RoutesName.videoReader,
                                      arguments: {
                                        "notesData": notesData
                                      });
                                },
                              ),
                            );
                          } else {
                            return Padding(
                              padding: const EdgeInsets.all(8),
                              child: Card2(
                                discription: data['paragraph'].toString(),
                                title: data['title'].toString(),
                                index: notesId,
                                notesData: data,
                                slideToDelet: (uid) {
                                  notesValue.deletNotesControllerData(
                                      context, userId, uid);
                                  // firebaseRealTimeDatabase.deletNotes(context , uid);
                                },
                                onPressButton: (uid, notesData) {
                                  Navigator.pushNamed(
                                      context, RoutesName.updateNotesScreen,
                                      arguments: {
                                        "uid": uid,
                                        "notesData": notesData
                                      });
                                },
                              ),
                            );
                          }
                        },
                      );
                    } else {
                      return const Center(child: Text('No Notes found.'));
                    }
                  } else {
                    return const Center(child: Text('No data found.'));
                  }
                }
              },
            ))
          ],
        );
      },
    );
  }
}
