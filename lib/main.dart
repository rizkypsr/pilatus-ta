import 'dart:convert';

import 'package:authentication_provider/authentication_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl_standalone.dart';
import 'package:pilatus/common/state_enum.dart';
import 'package:pilatus/data/models/user_model.dart';
import 'package:pilatus/presentation/pages/category_page.dart';
import 'package:pilatus/presentation/pages/home_page.dart';
import 'package:pilatus/presentation/pages/login.page.dart';
import 'package:pilatus/presentation/pages/order_page.dart';
import 'package:pilatus/presentation/pages/profile_page.dart';
import 'package:pilatus/presentation/provider/auth_notifier.dart';
import 'package:pilatus/presentation/provider/bottom_nav_provider.dart';
import 'package:pilatus/presentation/provider/category_notifier.dart';
import 'package:pilatus/presentation/provider/order_list_notifier.dart';
import 'package:pilatus/presentation/provider/order_notifier.dart';
import 'package:pilatus/presentation/provider/product_by_category_notifier.dart';
import 'package:pilatus/styles/colors.dart';
import 'package:pilatus/styles/text_styles.dart';
import 'package:pilatus/utils/firebase_dynamic_link_service.dart';
import 'package:provider/provider.dart';
import 'package:pilatus/injection.dart' as di;
import 'package:pilatus/presentation/provider/product_list_notifier.dart';
import 'package:pilatus/presentation/provider/cart_notifier.dart';
import 'package:pilatus/presentation/provider/ongkir_notifier.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    FirebaseDynamicLinkService.initDynamicLink(context);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.locator<ProductListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<CartNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<OngkirNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<OrderNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<OrderListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<CategoryNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<ProductByCategoryNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<AuthNotifier>()..checkAuth(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pilatus Showroom',
        theme: ThemeData()
            .copyWith(textTheme: textTheme, colorScheme: colorScheme),
        home: Consumer<AuthNotifier>(builder: (context, data, _) {
          var state = data.authState;

          if (state == AuthState.Loading) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Loading'),
              ),
              body: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state == AuthState.Erorr) {
            Fluttertoast.showToast(
                msg: data.message,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          } else if (state == AuthState.Authenticated) {
            return ChangeNotifierProvider<BottomNavigationBarProvider>(
                create: (context) => BottomNavigationBarProvider(),
                child: MainPage());
          }
          return LoginPage();
        }),
      ),
    );
  }
}

class MainPage extends StatelessWidget {
  MainPage({Key? key}) : super(key: key);

  final currentTab = [
    const HomePage(),
    const CategoryPage(),
    const OrderPage(),
    const ProfilePage()
  ];

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
