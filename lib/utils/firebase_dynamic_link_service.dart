import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:pilatus/domain/entities/order.dart';
import 'package:pilatus/presentation/pages/order_detail.dart';

class FirebaseDynamicLinkService {
  static Future<String> createDynamicLink(Orders order) async {
    String linkMessage;

    final dynamicLinkParams = DynamicLinkParameters(
      link: Uri.parse("https://pilatusshoroom.page.link/order"),
      uriPrefix: "https://pilatusshoroom.page.link/order?id=${order.id}",
      androidParameters: const AndroidParameters(packageName: "com.pilatus"),
    );

    final dynamicLink =
        await FirebaseDynamicLinks.instance.buildLink(dynamicLinkParams);

    Uri url = dynamicLink;

    linkMessage = url.toString();

    return linkMessage;
  }

  static Future<void> initDynamicLink(BuildContext context) async {
    FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
      final Uri deepLink = dynamicLinkData.link;
      var isOrder = deepLink.pathSegments.contains('order');

      if (isOrder) {
        String? id = deepLink.queryParameters['id'];

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => OrderDetail(id: id!),
            ));
      }
    }).onError((error) {
      debugPrint(error);
    });
  }
}
