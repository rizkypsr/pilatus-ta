import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pilatus/main.dart';
import 'package:pilatus/presentation/provider/bottom_nav_provider.dart';
import 'package:provider/provider.dart';

class FirebaseDynamicLinkService {
  static Future<String> createDynamicLink() async {
    String linkMessage;

    final dynamicLinkParams = DynamicLinkParameters(
      link: Uri.parse("https://pilatus.page.link/order"),
      uriPrefix: "https://pilatus.page.link",
      androidParameters: const AndroidParameters(packageName: "com.pilatus"),
    );

    final dynamicLink =
        await FirebaseDynamicLinks.instance.buildShortLink(dynamicLinkParams);

    Uri url = dynamicLink.shortUrl;

    linkMessage = url.toString();

    return linkMessage;
  }

  static Future<void> initDynamicLink(BuildContext context) async {
    FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
      final Uri deepLink = dynamicLinkData.link;
      var isOrder = deepLink.pathSegments.contains('order');

      if (isOrder) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainPage()),
        );
      }
    }).onError((error) {
      debugPrint(error);
    });
  }
}
