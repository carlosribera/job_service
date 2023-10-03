import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../providers/providers.dart';
import '../widgets/widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var formKey = GlobalKey<FormState>();
  Map<String, String> formData = {'email': '', 'password': ''};
  LoginProvider loginProvider = LoginProvider();
  UserProvider userProvider = UserProvider();
  bool checkSaveData = false;
  SharedPreferences? pref;
  // controllers
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    loadSharedPreferences();
    super.initState();
  }

  loadSharedPreferences() async {
    pref = await SharedPreferences.getInstance();

    if (pref != null) {
      emailController.text = pref!.getString("email").toString();
      passwordController.text = pref!.getString("password").toString();
      formData['email'] = emailController.text;
      formData['password'] = passwordController.text;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {

    loginProvider = Provider.of<LoginProvider>(context);
    userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      body: Stack(
        children: [
          _crearFondo(context),
          _loginForm(context),
        
        ],
      ),
    );
  }

  formLogin() async {
    if (formKey.currentState!.validate()) {
      var usuario = await loginProvider.loginUsuario(formData);
      if (usuario != null) {
        userProvider.setUser(usuario);

        if (checkSaveData && pref != null) {
          pref!.setString("email", usuario.email!);
          pref!.setString("password", formData['password']!);
        }
        // ignore: use_build_context_synchronously
        Navigator.popAndPushNamed(context, 'home');
      } else {
        // ignore: use_build_context_synchronously
        AppDialogs.showDialog1(context, 'No se pudo iniciar sesion.');
      }
    } else {
      AppDialogs.showDialog1(context, 'No se ha podido validar');
    }
  }

  Widget _crearFondo(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final fondoRojo = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: <Color>[
        Color.fromRGBO(207, 1, 52, 1.0),
        Color.fromRGBO(207, 5, 52, 1.0),
      ])),
    );

    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: const Color.fromRGBO(255, 255, 255, 0.05)),
    );

    return Stack(
      children: [
        fondoRojo,
        Positioned(top: 90.0, left: 30.0, child: circulo),
        Positioned(top: -40.0, left: -30.0, child: circulo),
        Positioned(bottom: -50.0, right: -10.0, child: circulo),
        Positioned(bottom: 120.0, right: 20.0, child: circulo),
        Container(
          padding: const EdgeInsets.only(top: 90.0),
          child: const Column(
            children: [
              Icon(
                Icons.person_pin_circle,
                color: Colors.white,
                size: 100.0,
              ),
              SizedBox(
                height: 10.0,
                width: double.infinity,
              ),
              Text(
                'Job Service',
                style: TextStyle(color: Colors.white, fontSize: 25.0),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget _loginForm(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(children: [
        SafeArea(
            child: Container(
          height: 180.0,
        )),
        const SizedBox(
          height: 20.0,
        ),
        Container(
          width: size.width * 0.85,
          margin: const EdgeInsets.symmetric(vertical: 30.0),
          padding: const EdgeInsets.symmetric(vertical: 50.0),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5.0),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 3.0,
                  offset: Offset(0.0, 0.5),
                  spreadRadius: 3.0,
                )
              ]),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const AppTitle('Iniciar Sesion'),
                const SizedBox(height: 40.0),
                RoundedInputField(
                  'email',
                  'Correo electronico',
                  controller: emailController,
                  formData: formData,
                  icon: Icons.alternate_email,
                  validator: (value) {
                    if (value!.length < 3) {
                      return 'Correo electronico no valida.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30.0),
                RoundedInputField(
                  'password',
                  'Contraseña',
                  controller: passwordController,
                  formData: formData,
                  icon: Icons.lock,
                  obscureText: true,
                  validator: (value) {
                    if (value!.length < 3) {
                      return 'Contraseña no valida.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30.0),
                RoundedButton('Ingresar', press: formLogin),
                TextButton(onPressed: () {
                  Navigator.pushNamed(context, 'register');
                }, child: const Text('Registrar nueva cuenta'))
              ],
            ),
          ),
        ),
        const Text('¿Olvido su contraseña?'),
        const SizedBox(height: 100.0,)
      ]),
    );
  }
}
