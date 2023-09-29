import 'package:flutter/material.dart';
import '../widgets/widgets.dart';

class ConfiguracionesScreen extends StatefulWidget {
  const ConfiguracionesScreen({super.key});

  @override
  State<ConfiguracionesScreen> createState() => _ConfiguracionesScreenState();
}

class _ConfiguracionesScreenState extends State<ConfiguracionesScreen> {
  @override
  Widget build(BuildContext context) {    
    return Scaffold(
      drawer: const AppDrawer(),
      
      appBar: AppBar(
        title: const Text('Configuraciones'),
        centerTitle: true,
        actions: const [CircleAvatar(child: Text('AR'),), SizedBox(width: 10,)],
      ),
      // body: Center(child: Text('Bienvenid@ $name a la aplicacion.')),
      body: Container()
    );
  }
}
