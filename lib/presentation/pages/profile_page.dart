import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pilatus/common/state_enum.dart';
import 'package:pilatus/main.dart';
import 'package:pilatus/presentation/pages/edit_profile_page.dart';
import 'package:pilatus/presentation/provider/auth_notifier.dart';
import 'package:pilatus/presentation/provider/user_notifier.dart';
import 'package:pilatus/styles/text_styles.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserNotifier>(context, listen: false).fetchUser();
    });
  }

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
            child: Consumer<UserNotifier>(builder: (context, data, _) {
              final state = data.userState;

              if (state == RequestState.Loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state == RequestState.Loaded) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(data.user.name!),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      data.user.email!,
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
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        EditProfilePage(name: data.user.name!),
                                  ));
                            },
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
                );
              }
              return const SizedBox();
            }),
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
            const FaIcon(
              FontAwesomeIcons.angleRight,
              size: 16,
            )
          ],
        ),
      ),
    );
  }
}
