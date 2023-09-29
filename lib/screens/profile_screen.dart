import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../providers/providers.dart';
import '../widgets/widgets.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserProvider userProvider = UserProvider();
  Map<String, String> formData = {
    'localId': '',
    'name': '',
    'lastname': '',
    'email': '',
    'password': '',
    'image': ''
  };
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  XFile? image;

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<UserProvider>(context);

    nameController.text = userProvider.user.name!;
    lastNameController.text = userProvider.user.lastname!;

    if (formData['name'] == "") {
      formData['name'] = nameController.text;
      formData['lastname'] = lastNameController.text;
      formData['localId'] = userProvider.user.localId!;
      formData['image'] = userProvider.user.image!;
    }

    return Scaffold(
        appBar: getAppBar(context, 'Perfil de Usuario', userProvider.user),
        drawer: const AppDrawer(),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                GestureDetector(
                  onTap: () async {
                    final ImagePicker picker = ImagePicker();
                    // Pick an image.
                    image = await picker.pickImage(source: ImageSource.gallery);

                    if (image != null) {
                      final bytes = File(image!.path).readAsBytesSync();
                      formData['image'] = base64Encode(bytes);
                    }
                    setState(() {});
                  },
                  child: userProvider.user.image == ""
                      ? const Image(image: AssetImage('assets/profile.png'))
                      : ClipOval(
                          child: Image.memory(
                            base64Decode(formData['image']!),
                            fit: BoxFit.cover,
                            height: 400,
                            width: 400,
                          ),
                        ),
                ),
                RoundedInputField(
                  'name',
                  'Nombre',
                  controller: nameController,
                  formData: formData,
                  icon: Icons.verified_user_sharp,
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
                  controller: lastNameController,
                  formData: formData,
                  icon: Icons.verified_user_sharp,
                  validator: (value) {
                    if (value!.length < 3) {
                      return 'Apellido no valida.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                (loading == false)
                    ? RoundedButton('Actualizar', press: formUpdate)
                    : const Center(child: CircularProgressIndicator())
              ],
            ),
          ),
        ));
  }

  formUpdate() async {
    if (formKey.currentState!.validate()) {
      loading = true;
      setState(() {});
      bool respuesta = await userProvider.updateUsuario(formData);
      loading = false;
      setState(() {});
      if (respuesta) {
        // ignore: use_build_context_synchronously
        AppDialogs.showDialog1(context, 'Datos actualizados.');
      } else {
        // ignore: use_build_context_synchronously
        AppDialogs.showDialog1(context, 'No se pudo actualizar.');
      }
    } else {
      AppDialogs.showDialog1(context, 'Validacion no exitosa');
    }
  }
}
