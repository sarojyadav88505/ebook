import 'dart:io';

import 'package:ebook/Pages/about-us.dart';
import 'package:ebook/const/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

void _launchURL(String url) async =>
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';

Widget myDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      children: [
        UserAccountsDrawerHeader(
          currentAccountPicture: CircleAvatar(
            child: Text(
              "CC",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey),
            ),
            backgroundColor: Colors.blue[100],
          ),
          accountName: Text("CarelessCoder"),
          accountEmail: Text("CarelessCoder.np@gmail.com"),
        ),
        ListTile(
          onTap: () {
            Navigator.pop(context);
          },
          leading: Icon(
            Icons.space_dashboard_rounded,
            color: primaryColor,
          ),
          title: Text("Dashboard"),
        ),
        Divider(),
        ListTile(
          onTap: () {
            _launchURL("https://facebook.com/enfo404");
            // print('Saroj');
          },
          leading: Icon(
            Icons.facebook_sharp,
            color: primaryColor,
          ),
          title: Text("Facebook Page"),
        ),
        Divider(),
        ListTile(
          title: Text("About us"),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AboutUsPage()));
          },
          leading: Icon(
            Icons.info_outline,
            color: primaryColor,
          ),
        ),
        Divider(),
        ListTile(
          title: Text("Exit"),
          onTap: () {
            if (Platform.isAndroid) {
              SystemNavigator.pop();
            }
          },
          leading: Icon(
            Icons.logout,
            color: primaryColor,
          ),
        ),
      ],
    ),
  );
}
