import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/providers.dart';
import '../widgets/widgets.dart';

class AcercaScreen extends StatefulWidget {
  const AcercaScreen({super.key});

  @override
  State<AcercaScreen> createState() => _AcercaScreenState();
}

class _AcercaScreenState extends State<AcercaScreen> {
  UserProvider userProvider = UserProvider();
  @override
  Widget build(BuildContext context) {   
    userProvider = Provider.of<UserProvider>(context);  
    return Scaffold(
      drawer: const AppDrawer(),
      
      appBar: getAppBar(context, 'Acerca de...', userProvider.user),
      // body: Center(child: Text('Bienvenid@ $name a la aplicacion.')),
      body: ListView(
        padding: const EdgeInsets.all(10.0),
        children: const [
          Text('App v1.0.0'),
        ],
      ),
    );
  }
}
