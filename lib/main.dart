import 'dart:convert';

import 'package:authentication_provider/authentication_provider.dart';
import 'package:flutter/material.dart';
import 'package:pilatus/data/models/user_model.dart';
import 'package:pilatus/presentation/pages/category_page.dart';
import 'package:pilatus/presentation/pages/home_page.dart';
import 'package:pilatus/presentation/pages/login.page.dart';
import 'package:pilatus/presentation/pages/order_page.dart';
import 'package:pilatus/presentation/pages/profile_page.dart';
import 'package:pilatus/presentation/provider/bottom_nav_provider.dart';
import 'package:pilatus/styles/colors.dart';
import 'package:pilatus/styles/text_styles.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AuthenticationController<UserModel> controller;
  late SharedPreferences _preferences;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  void _initialize() async {
    controller = AuthenticationController<UserModel>(context);
    _preferences = await SharedPreferences.getInstance();

    checkAuthentication();
  }

  void checkAuthentication() async {
    final String? userPref = _preferences.getString('user');
    var user =
        userPref != null ? UserModel.fromJson(jsonDecode(userPref)) : null;
    controller.checkAuth(user: user);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pilatus Showroom',
        theme: ThemeData()
            .copyWith(textTheme: textTheme, colorScheme: colorScheme),
        home: ChangeNotifierProvider<BottomNavigationBarProvider>(
            create: (context) => BottomNavigationBarProvider(),
            child: AuthenticationProvider<UserModel>(
                controller: controller,
                builder: (context) {
                  var state =
                      AuthenticationProvider.of<UserModel>(context)!.state;
                  if (state is Loading) {
                    return Scaffold(
                      appBar: AppBar(
                        title: const Text('Loading'),
                      ),
                      body: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else if (state is Unauthenticated) {
                    return LoginPage(
                      controller: controller,
                    );
                  } else if (state is Authenticated<UserModel>) {
                    return MainPage();
                  }
                  Future.delayed(const Duration(seconds: 1), () {
                    controller.initialize();
                  });
                  return Scaffold(
                    appBar: AppBar(
                      title: const Text('Uninitialized'),
                    ),
                    body: const Center(
                      child: Text(''),
                    ),
                  );
                })));
  }
}

class MainPage extends StatelessWidget {
  MainPage({Key? key}) : super(key: key);

  final currentTab = [HomePage(), CategoryPage(), OrderPage(), ProfilePage()];

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<BottomNavigationBarProvider>(context);

    return Scaffold(
      body: currentTab[provider.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        currentIndex: provider.currentIndex,
        selectedItemColor: primaryColor.withOpacity(.60),
        unselectedItemColor: secondaryLightColor.withOpacity(.80),
        selectedLabelStyle: paragraph2.copyWith(fontSize: 12),
        unselectedLabelStyle:
            paragraph2.copyWith(fontSize: 12, color: secondaryColor),
        elevation: 0,
        onTap: (index) {
          provider.currentIndex = index;
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.category,
            ),
            label: 'Kategori',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_bag,
            ),
            label: 'Transaksi',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            label: 'Profil',
          )
        ],
      ),
    );
  }
}
