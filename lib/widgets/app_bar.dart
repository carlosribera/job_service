import 'package:flutter/material.dart';
import 'package:job_service/models/user.dart';

getAppBar(BuildContext context,String title, User user) {
  
    final colors = Theme.of(context).colorScheme;
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
          backgroundColor: colors.primary,
          
          child: Text(initials,style: const TextStyle(color: Colors.white)),
        ),
      ),
      const SizedBox(width: 5),
    ],
  );
}
