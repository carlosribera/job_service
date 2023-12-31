import 'package:flutter/material.dart';
import 'package:job_service/screens/config_screen.dart';

import 'screens/screens.dart';

class AppConfig{
  static String initialRoute = 'login';

  static routes() {
    return{
      'login':(context) =>const LoginScreen(),
      'register':(context) =>const RegisterScreen(),
      'home':(context) =>const HomeScreen(),
      'profile':(context) =>const ProfileScreen(),
      'mapa':(context) =>const MapaScreen(),
      'config':(context) =>const ConfiguracionesScreen(),
      'acerca':(context) =>const AcercaScreen(),
    };
  }
}

// const Color _customColor = Color(0xFF49149F);
const Color _customColor = Color(0x00e23722);
const List<Color> _colorThemes = [
  _customColor,
  Colors.red,
  Colors.blue,
  Colors.teal,
  Colors.green,
  Colors.yellow,
  Colors.orange,
];

class AppTheme {
  final int selectedColor;

  AppTheme({this.selectedColor = 0})
      : assert(selectedColor >= 0 && selectedColor <= _colorThemes.length - 1,
            'Colors must be between 0 and ${_colorThemes.length}');

  ThemeData theme() {
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: _colorThemes[selectedColor],
      // brightness: Brightness.dark,
    );
  }
}