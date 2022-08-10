import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pilatus/common/state_enum.dart';
import 'package:pilatus/main.dart';
import 'package:pilatus/presentation/pages/login.page.dart';
import 'package:pilatus/presentation/provider/auth_notifier.dart';
import 'package:pilatus/styles/colors.dart';
import 'package:pilatus/styles/text_styles.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthNotifier>(builder: (context, data, _) {
      final state = data.authState;

      if (state == AuthState.Erorr) {
        Fluttertoast.showToast(
            msg: data.message,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }

      if (state == AuthState.Authenticated) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MyApp(),
              ));
        });
      }
      return Scaffold(
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Register', style: heading3),
                const SizedBox(
                  height: 24,
                ),
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
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 14),
                      hintStyle: paragraph2.copyWith(
                          color: secondaryLightColor, fontSize: 14),
                      hintText: 'Masukan nama kamu',
                      filled: true,
                      border: const OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: secondaryDarkColor))),
                ),
                const SizedBox(
                  height: 14,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Email',
                        style: paragraph2.copyWith(
                            color: secondaryLightColor, fontSize: 14))),
                const SizedBox(
                  height: 4,
                ),
                TextFormField(
                  controller: emailController,
                  style: paragraph2,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 14),
                      hintStyle: paragraph2.copyWith(
                          color: secondaryLightColor, fontSize: 14),
                      hintText: 'Masukan email kamu',
                      filled: true,
                      border: const OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: secondaryDarkColor))),
                ),
                const SizedBox(
                  height: 14,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Password',
                        style: paragraph2.copyWith(
                            color: secondaryLightColor, fontSize: 14))),
                const SizedBox(
                  height: 4,
                ),
                TextFormField(
                  controller: passwordController,
                  style: paragraph2,
                  obscureText: true,
                  decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 14),
                      hintStyle: paragraph2.copyWith(
                          color: secondaryLightColor, fontSize: 14),
                      hintText: 'Masukan password kamu',
                      filled: true,
                      border: const OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: secondaryDarkColor))),
                ),
                const SizedBox(
                  height: 26,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(elevation: 0),
                      onPressed: () => {
                            context.read<AuthNotifier>().registerUser(
                                nameController.text,
                                emailController.text,
                                passwordController.text)
                          },
                      child: Text(
                        'Daftar',
                        style: paragraph2.copyWith(
                            color: secondaryTextColor, fontSize: 14),
                      )),
                ),
                const SizedBox(
                  height: 14,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: TextButton(
                      onPressed: () => {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginPage(),
                                ),
                                (route) => false)
                          },
                      child: Text(
                        'Sudah punya akun',
                        style: paragraph2.copyWith(
                            decoration: TextDecoration.underline,
                            color: secondaryLightColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600),
                      )),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
