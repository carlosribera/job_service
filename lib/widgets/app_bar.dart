import 'package:flutter/material.dart';
import 'package:job_service/models/user.dart';

getAppBar(BuildContext context,String title, User user) {
  String initials = user.name!.substring(0,1) + user.lastname!.substring(0,1);
  return AppBar(
    title: Text(title),
    centerTitle: true,
    actions: [
      GestureDetector(
        onTap: () {
          Navigator.pushReplacementNamed(context, 'profile');
        },
        child: CircleAvatar(
          backgroundColor: Colors.red,
          child: Text(initials),
        ),
      ),
      const SizedBox(width: 5),
    ],
  );
}
