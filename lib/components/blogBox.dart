import 'package:ebook/Pages/coursePage.dart';
import 'package:ebook/const/const.dart';
import 'package:flutter/material.dart';

Widget blogBox(BuildContext context, String title, String description,
    String image, String createdat) {
  return Card(
    color: textColor,
    child: ListTile(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlogPage(
              title: title, //constructor
              description: description,
              image: image,
            ),
          ),
        );
      },
      leading: Container(
        height: 50,
        width: 70,
        child: Image.network(
          '$image',
          fit: BoxFit.cover,
        ),
      ),
      title: Text(
        '$title',
        maxLines: 2,
      ),
      subtitle: Text('$createdat'),
      trailing: Icon(
        Icons.arrow_right,
        size: 30,
      ),
    ),
  );
}
