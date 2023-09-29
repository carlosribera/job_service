import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';

import '../providers/providers.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserProvider userProvider = UserProvider();
  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<UserProvider>(context);
    // String name = userProvider.user.name!;

    
    return Scaffold(
      drawer: const AppDrawer(),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        children:[
          SpeedDialChild(
            label: 'Mail',
            child: const Icon(Icons.mail),
          ),
          SpeedDialChild(
            label: 'Copy',
            child: const Icon(Icons.copy),
          ),
        ]
      ),
      appBar: getAppBar(context, 'JobService', userProvider.user),
      // body: Center(child: Text('Bienvenid@ $name a la aplicacion.')),
      body: ListView(
        padding: const EdgeInsets.all(10.0),
        children: const [
          Text('Hello'),
        ],
      ),
    );
  }
}
