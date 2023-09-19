import 'package:flutter/material.dart';
import 'package:job_service/widgets/rounded_button.dart';
import 'package:job_service/widgets/rounded_input_field.dart';
import 'package:provider/provider.dart';

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
              RoundedButton('Ingresar', press: formLogin),
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, 'register');
                  },
                  child: const Text(
                    'Registrar nueva cuenta',
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
        // ignore: use_build_context_synchronously
        AppDialogs.showDialog2(context, 'Usuario Autenticado!', [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, 'home');
              },
              child: const Text('Ok'))
        ]);
      } else {
        // ignore: use_build_context_synchronously
        AppDialogs.showDialog1(context, 'No se pudo iniciar sesion.');
      }
    } else {
      AppDialogs.showDialog1(context, 'No se ha podido validar');
    }
  }
}
