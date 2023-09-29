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
    // final colors = Theme.of(context).colorScheme;
    Size size = MediaQuery.of(context).size;

    loginProvider = Provider.of<LoginProvider>(context);
    userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        // color: colors.primary,
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const AppTitle('Iniciar Sesion'),
              SizedBox(height: size.height * 0.03),
              const SizedBox(height: 25),
              RoundedInputField(
                'email',
                'Correo electronico',
                controller: emailController,
                formData: formData,
                icon: Icons.email_outlined,
                validator: (value) {
                  if (value!.length < 3) {
                    return 'Correo electronico no valida.';
                  }
                  return null;
                },
              ),
              RoundedInputField(
                'password',
                'Contraseña',
                controller: passwordController,
                formData: formData,
                icon: Icons.key_outlined,
                obscureText: true,
                validator: (value) {
                  if (value!.length < 3) {
                    return 'Contraseña no valida.';
                  }
                  return null;
                },
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                width: size.width * 0.8,
                child: CheckboxListTile(
                    value: checkSaveData,
                    title: const Text('Desea guardar sus datos'),
                    onChanged: (value) {
                      setState(() {
                        checkSaveData = value!;
                      });
                    }),
              ),
              RoundedButton('Ingresar', press: formLogin),
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'register');
                  },
                  child: const Text('Registrar nueva cuenta'
                      // style: TextStyle(color: Colors.white),
                      )),
              const SizedBox(height: 35),
            ],
          ),
        ),
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
}
