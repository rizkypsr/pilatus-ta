import 'package:flutter/material.dart';
import 'package:pilatus/common/state_enum.dart';
import 'package:pilatus/presentation/provider/user_notifier.dart';
import 'package:pilatus/styles/colors.dart';
import 'package:pilatus/styles/text_styles.dart';
import 'package:provider/provider.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key, required this.name}) : super(key: key);

  final String name;

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController nameController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    nameController.text = widget.name;

    return Consumer<UserNotifier>(builder: (context, data, _) {
      final state = data.changeUserState;

      if (state == RequestState.Loaded) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          Navigator.pop(context);
        });
      }

      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Edit Profil',
            style: heading6.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          leading: const BackButton(),
          backgroundColor: ThemeData.light().scaffoldBackgroundColor,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Nama',
                      style: paragraph2.copyWith(
                          color: secondaryLightColor, fontSize: 14))),
              const SizedBox(
                height: 4,
              ),
              TextFormField(
                controller: nameController,
                style: paragraph2,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 14),
                    hintStyle: paragraph2.copyWith(
                        color: secondaryLightColor, fontSize: 14),
                    hintText: 'Masukan nama kamu',
                    filled: true,
                    border: const OutlineInputBorder(),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: secondaryDarkColor))),
              ),
              const SizedBox(
                height: 18,
              ),
              SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(elevation: 0),
                    onPressed: () => {
                          context
                              .read<UserNotifier>()
                              .changeUserName(nameController.text)
                        },
                    child: Text(
                      'Ganti Nama',
                      style: paragraph2.copyWith(
                          color: secondaryTextColor, fontSize: 14),
                    )),
              ),
            ],
          ),
        ),
      );
    });
  }
}
