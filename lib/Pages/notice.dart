import 'dart:convert';

import 'package:ebook/Pages/notice-details-Page.dart';
import 'package:ebook/api/api.dart';
import 'package:ebook/components/loadingeffect.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class notice extends StatefulWidget {
  @override
  _noticeState createState() => _noticeState();
}

// ignore: camel_case_types
class _noticeState extends State<notice> {
  Future getNotice() async {
    var response = await Api().getData('notice');
    var data = json.decode(response.body)['data'];
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notices'),
      ),
      body: FutureBuilder(
        future: getNotice(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return snapshot.data == null
              ? Center(
                  child: loadingEffect(),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    var mydata = snapshot.data[index];
                    return SingleChildScrollView(
                        child: Column(
                      children: [
                        Card(
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NoticePage(
                                    title: mydata['title'], //constructor
                                    description: mydata['description'],
                                    image: mydata['image'],
                                  ),
                                ),
                              );
                            },
                            title: Text(mydata['title']),
                            subtitle: Text(mydata['created_at']),
                            trailing: Icon(
                              Icons.arrow_right,
                              size: 30,
                            ),
                          ),
                        ),
                      ],
                    ));
                  },
                );
        },
      ),
    );
  }
}
