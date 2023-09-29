import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(child: Column(
            children: [
              Icon(Icons.person, size: 100,)
            ],
          )),
          ListTile(
            title: const Text('Home'),
            onTap: (){
              Navigator.pushReplacementNamed(context, 'home');
            },
            selected: true,
          ),
          ListTile(
            title: const Text('Mapa'),
            onTap: (){
              Navigator.pushReplacementNamed(context, 'mapa');
              },
          ),
          ListTile(
            title: const Text('Perfil'),
            onTap: (){
              Navigator.pushReplacementNamed(context, 'profile');
            },
          ),
          ListTile(
            title: const Text('Configuraciones'),
            onTap: (){
              Navigator.pushReplacementNamed(context, 'config');
            },
          ),
          ListTile(
            title: const Text('Acerca'),
            onTap: (){
              Navigator.pushReplacementNamed(context, 'acerca');

            },
          ),
          ],
      ),
      
    );
  }
}