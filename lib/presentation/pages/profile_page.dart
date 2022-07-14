import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pilatus/common/state_enum.dart';
import 'package:pilatus/main.dart';
import 'package:pilatus/presentation/provider/auth_notifier.dart';
import 'package:pilatus/styles/text_styles.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthNotifier>(
      builder: (context, data, child) {
        final state = data.authState;

        if (state == AuthState.Unauthenticated) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const MyApp(),
                ));
          });
        }

        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Profil',
              style: heading6.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            leading: const BackButton(),
            backgroundColor: ThemeData.light().scaffoldBackgroundColor,
            elevation: 0,
          ),
          body: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('Rizky Pratama Syahrul Ramadhan'),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  'rizkypsrr@gmail.com',
                  style: paragraph2.copyWith(),
                ),
                const SizedBox(
                  height: 80,
                ),
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                  ),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      SettingTile(
                        title: "Ubah Profil",
                        icon: FontAwesomeIcons.solidUser,
                        onTap: () {},
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SettingTile(
                        title: "Keluar",
                        icon: FontAwesomeIcons.rightFromBracket,
                        onTap: () {
                          context.read<AuthNotifier>().logoutUser();
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class SettingTile extends StatelessWidget {
  const SettingTile(
      {Key? key, required this.title, required this.icon, required this.onTap})
      : super(key: key);

  final String title;
  final IconData icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 10,
              children: [
                Container(
                  padding: const EdgeInsets.all(9),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(.20),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: FaIcon(
                    icon,
                    size: 16,
                  ),
                ),
                Text(
                  title,
                  style: heading6.copyWith(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            FaIcon(
              FontAwesomeIcons.angleRight,
              size: 16,
            )
          ],
        ),
      ),
    );
  }
}
