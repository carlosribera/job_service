import 'package:flutter/material.dart';
import 'package:job_service/widgets/rounded_button.dart';
import 'package:job_service/widgets/rounded_input_field.dart';
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
    'password': ''};
  RegisterProvider registerProvider = RegisterProvider();

  @override
  Widget build(BuildContext context) {
    // final colors = Theme.of(context).colorScheme;
    Size size = MediaQuery.of(context).size;

    registerProvider = Provider.of<RegisterProvider>(context);

    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        // color: colors.primary,
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const AppTitle('Registrar Usuario'),
              SizedBox(height: size.height * 0.03),
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
                'Apellido',
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
                formData: formData,
                // icon: Icons.email_outlined,
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
                // icon: Icons.key_outlined,
                obscureText: true,
                validator: (value) {
                  if (value!.length < 3) {
                    return 'Contraseña no valida.';
                  }
                  return null;
                },
              ),
              RoundedButton('Registrar', press: formRegister),
              
              const SizedBox(height: 35),
            ],
          ),
        ),
      ),
    );
  }


  formRegister() async {
    if (formKey.currentState!.validate()) {
      bool respuesta = await registerProvider.registrarUsuario(formData);
      if (respuesta) {
        // ignore: use_build_context_synchronously
        AppDialogs.showDialog1(context,'Usuario registrado con éxisto.');
      } else {
        // ignore: use_build_context_synchronously
        AppDialogs.showDialog1(context,'No se pudo registrar el usuario.');
      
      }
    } else {
        AppDialogs.showDialog1(context,'No se ha podido validar');
    }
  }
}
