import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:ebook/Pages/notice.dart';
import 'package:ebook/components/blogs.dart';
import 'package:ebook/components/carousel.dart';
import 'package:ebook/components/drawer.dart';
import 'package:ebook/const/const.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_awesome_buttons/flutter_awesome_buttons.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Future refresh() async {
    await Future.delayed(
        Duration(
          seconds: 2,
        ), () {
      carousel(context);

      blogs();

      setState(() {});
    });
  }

  late FirebaseMessaging push;
  firebase() {
    push = FirebaseMessaging.instance;
    push.getToken().then((value) {
      print(value);
    });
    FirebaseMessaging.onMessage.listen((event) {
      print(event.data.toString());
    });

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      print(event.data.toString());
    });
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
  }

  // void _launchURL(String url) async =>
  //     await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';

  @override
  Widget build(BuildContext context) {
    DateTime? lastPressed; // LastPressed Variable For Double Tap to Close
    return Scaffold(
        // Start Bottom NavigationBar is Used For Company Highlight
        floatingActionButton: FloatingIconButton(
          onPressed: () {},
          icon: Icons.feedback_sharp,
          buttonColor: primaryColor,
        ),

        // Bottom NAvigationBar End
        drawer: myDrawer(context), //mydrawer widget is in component folder
        appBar: AppBar(
          title: AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              ColorizeAnimatedText(
                'E-Book',
                textStyle: colorizeTextStyle,
                colors: colorizeColors,
              ),
            ],
            isRepeatingAnimation: true,
            onTap: () {
              print("Tap Event");
            },
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => notice(),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.circle_notifications,
                    size: 40,
                  )),
            )
          ],
        ),
        body: RefreshIndicator(
          onRefresh: refresh,
          child: WillPopScope(
            onWillPop: () async {
              final now = DateTime.now();
              final maxDuration = Duration(seconds: 2);
              final isWarning = lastPressed == null ||
                  now.difference(lastPressed!) > maxDuration;
              if (isWarning) {
                lastPressed = DateTime.now();

                final snackBar = SnackBar(
                  content: Text('Double Tap To Close App'),
                  duration: maxDuration,
                );

                ScaffoldMessenger.of(context)
                  ..removeCurrentSnackBar()
                  ..showSnackBar(snackBar);
                return false;
              } else {
                return true;
              }
            },
            // Code end Here of DOuble tap
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Slider Component
                  carousel(context),
                  // Course Type Components

                  // blog
                  blogs(),
                ],
              ),
            ),
          ),
        ));
  }
}
