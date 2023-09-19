import 'package:flutter/material.dart';
import 'package:job_service/app_config.dart';
import 'package:provider/provider.dart';

import 'providers/providers.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
      ChangeNotifierProvider(create: (_)=>LoginProvider()),
      ChangeNotifierProvider(create: (_)=>RegisterProvider()),
      ChangeNotifierProvider(create: (_)=>UserProvider()),
    ],
      child: const MyApp());
  }
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      theme: AppTheme(selectedColor: 0).theme(),
      initialRoute: AppConfig.initialRoute,
      routes: AppConfig.routes(),
    );
  }
}
