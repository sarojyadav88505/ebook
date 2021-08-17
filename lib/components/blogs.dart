import 'dart:convert';

import 'package:ebook/api/api.dart';
import 'package:ebook/components/blogBox.dart';
import 'package:ebook/components/loadingeffect.dart';
import 'package:flutter/material.dart';

Future getBlogs() async {
  var response = await Api().getData('blog');
  var data = json.decode(response.body)['data'];
  return data;
}

Widget blogs() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 3),
    child: Column(
      children: [
        FutureBuilder(
          future: getBlogs(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  var mydata = snapshot.data[index];
                  return blogBox(
                      context,
                      mydata['title'],
                      mydata['description'],
                      mydata['image'],
                      mydata['created_at']);
                },
              );
            } else if (snapshot.hasError) {
              return Text('Server Error');
            } else {
              return Center(
                child: loadingEffect(),
              );
            }
          },
        ),
      ],
    ),
  );
}
