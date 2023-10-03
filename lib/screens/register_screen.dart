import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/providers.dart';
import '../widgets/widgets.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var formKey = GlobalKey<FormState>();
  Map<String, String> formData = {
    'name': '',
    'lastname': '',
    'email': '',
    'password': ''
  };
  RegisterProvider registerProvider = RegisterProvider();

  @override
  Widget build(BuildContext context) {
    // final colors = Theme.of(context).colorScheme;

    registerProvider = Provider.of<RegisterProvider>(context);

    return Scaffold(
      body: Stack(
        children: [
          _crearFondo(context),
          _registerForm(context),
        ],
      ),
    );
  }

  formRegister() async {
    if (formKey.currentState!.validate()) {
      bool respuesta = await registerProvider.registrarUsuario(formData);
      if (respuesta) {
        // ignore: use_build_context_synchronously
        AppDialogs.showDialog1(context, 'Usuario registrado con éxisto.');
      } else {
        // ignore: use_build_context_synchronously
        AppDialogs.showDialog1(context, 'No se pudo registrar el usuario.');
      }
    } else {
      AppDialogs.showDialog1(context, 'No se ha podido validar');
    }
  }

  Widget _crearFondo(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final fondoRojo = Container(
      height: size.height,
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
          color: const Color.fromRGBO(255, 255, 255, 0.15)),
    );

    return Stack(
      children: [
        fondoRojo,
        Positioned(top: 90.0, left: 30.0, child: circulo),
        Positioned(top: -40.0, left: -30.0, child: circulo),
        Positioned(bottom: -50.0, right: -10.0, child: circulo),
        Positioned(bottom: 120.0, right: 20.0, child: circulo),
      ],
    );
  }

  Widget _registerForm(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(children: [
        SafeArea(
            child: Container(
          height: 100.0,
        )),
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
                const AppTitle('Registrar Usuario'),
                const SizedBox(height: 25),
                RoundedInputField(
                  'name',
                  'Nombre',
                  formData: formData,
                  // icon: Icons.email_outlined,
                  validator: (value) {
                    if (value!.length < 3) {
                      return 'Nombre no valido.';
                    }
                    return null;
                  },
                ),
                RoundedInputField(
                  'lastname',
                  'Apellidos',
                  formData: formData,
                  // icon: Icons.email_outlined,
                  validator: (value) {
                    if (value!.length < 3) {
                      return 'Apellido no valida.';
                    }
                    return null;
                  },
                ),
                RoundedInputField(
                  'email',
                  'Correo electronico',
                  hint: 'example@correo.com',
                  formData: formData,
                  icon: Icons.alternate_email,
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
                  icon: Icons.lock,
                  obscureText: true,
                  validator: (value) {
                    if (value!.length < 3) {
                      return 'Contraseña no valida.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 60.0),
                RoundedButton('Registrar', press: formRegister),
              ],
            ),
          ),
        ),
        TextButton.icon(
            icon: const Icon(Icons.arrow_back_rounded,color: Colors.white,),
            onPressed: () {
              Navigator.pop(context);
            },
            label: const Text(
              'Ya tengo una cuenta',
              style: TextStyle(color: Colors.white),
            ))
      ]),
    );
  }
}
