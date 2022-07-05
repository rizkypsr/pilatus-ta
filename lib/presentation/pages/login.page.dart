import 'package:authentication_provider/authentication_controller.dart';
import 'package:flutter/material.dart';
import 'package:pilatus/data/models/user_model.dart';
import 'package:pilatus/styles/colors.dart';
import 'package:pilatus/styles/text_styles.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key, required this.controller}) : super(key: key);

  final AuthenticationController<UserModel> controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Login', style: heading3),
              const SizedBox(
                height: 24,
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
                style: paragraph2,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 14),
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
                style: paragraph2,
                obscureText: true,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 14),
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
                          controller.authenticate(
                              user: UserModel(
                                  id: 1, name: 'name', email: 'email'))
                        },
                    child: Text(
                      'Masuk',
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
                    onPressed: () => {},
                    child: Text(
                      'Buat Akun',
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
  }
}
