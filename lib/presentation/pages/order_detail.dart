import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pilatus/common/constants.dart';
import 'package:pilatus/domain/entities/order.dart';
import 'package:pilatus/domain/entities/order_item.dart';
import 'package:pilatus/styles/colors.dart';
import 'package:pilatus/styles/text_styles.dart';
import 'package:pilatus/utils/currency_format.dart';
import 'package:pilatus/utils/get_payment_type.dart';
import 'package:pilatus/utils/url_launch.dart';

class OrderDetail extends StatelessWidget {
  const OrderDetail({Key? key, required this.order}) : super(key: key);

  final Orders order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Rincian Pesanan',
          style: heading6.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(12),
        child: SizedBox(
            width: double.infinity,
            height: 40,
            child: order.status == "PENDING"
                ? ElevatedButton(
                    style: ElevatedButton.styleFrom(elevation: 0),
                    onPressed: () => {UrlLaunch.launchURL(order.paymentUrl!)},
                    child: Text(
                      'Bayar Pesanan',
                      style: paragraph2.copyWith(
                          color: secondaryTextColor, fontSize: 14),
                    ))
                : const SizedBox()),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(18),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 10,
                      alignment: WrapAlignment.center,
                      children: [
                        const Icon(FontAwesomeIcons.truckFast, size: 16),
                        Text(
                          'Informasi Pengiriman',
                          style: heading6.copyWith(fontSize: 14),
                        )
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        order.shipping!.service!,
                        style: paragraph2.copyWith(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        order.shipping!.courier!,
                        style: paragraph2.copyWith(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        order.shipping!.resi ?? 'Belum Dikirim',
                        style: paragraph2.copyWith(
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      FontAwesomeIcons.locationDot,
                      size: 16,
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Alamat Pengiriman',
                            style: heading6.copyWith(
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            order.user!.name!,
                            style: paragraph2.copyWith(
                              fontSize: 12,
                              color: secondaryColor.withOpacity(.8),
                            ),
                          ),
                          Text(
                            '${order.shipping!.address!}, ${order.shipping!.city}, ${order.shipping!.province}, ID, ${order.shipping!.postalCode}',
                            style: paragraph2.copyWith(
                              fontSize: 12,
                              color: secondaryColor.withOpacity(.8),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: order.orderItem!.length,
                  itemBuilder: (context, index) => OrderListItem(
                    orderItem: order.orderItem![index],
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Ongkir: ${CurrencyFormat.convertToIdr(order.shipping!.cost, 0)}',
                      style: paragraph2.copyWith(
                        fontSize: 12,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Total: ${CurrencyFormat.convertToIdr(order.total, 0)}',
                        style: heading6.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              order.payment != null
                  ? Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            FontAwesomeIcons.creditCard,
                            size: 16,
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Metode Pembayaran',
                                style: heading6.copyWith(
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                'Bank Transfer - ${GetPaymentType.getStatus(order.payment!.provider!)}',
                                style: paragraph2.copyWith(
                                  fontSize: 12,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    )
                  : const SizedBox(),
              order.payment != null
                  ? const SizedBox(
                      height: 12,
                    )
                  : const SizedBox(),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'No. Pesanan',
                          style: heading6.copyWith(
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          order.id!,
                          style: heading6.copyWith(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Waktu Pemesanan',
                          style: paragraph2.copyWith(
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          DateFormat.yMd()
                              .add_jm()
                              .format(
                                  DateTime.parse(order.updatedAt.toString()))
                              .toString(),
                          style: paragraph2.copyWith(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    order.payment != null
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Waktu Pembayaran',
                                style: paragraph2.copyWith(
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                DateFormat.yMd()
                                    .add_jm()
                                    .format(DateTime.parse(
                                        order.payment!.updatedAt.toString()))
                                    .toString(),
                                style: paragraph2.copyWith(
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          )
                        : const SizedBox(),
                    order.shipping!.resi != null
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Waktu Pengiriman',
                                style: paragraph2.copyWith(
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                order.shipping!.updatedAt!,
                                style: paragraph2.copyWith(
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          )
                        : const SizedBox()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class OrderListItem extends StatelessWidget {
  const OrderListItem({Key? key, required this.orderItem}) : super(key: key);

  final OrderItem orderItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children: [
              CachedNetworkImage(
                imageUrl:
                    '$baseUrl/storage/products/${orderItem.product!.photo}',
                width: 50,
                height: 50,
                fadeOutDuration: const Duration(milliseconds: 0),
                fadeInDuration: const Duration(milliseconds: 0),
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) =>
                    BlurHash(hash: orderItem.product!.blurhash!),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        orderItem.product!.name!,
                        style: paragraph1.copyWith(
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'x${orderItem.quantity.toString()}',
                        style: paragraph2.copyWith(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        CurrencyFormat.convertToIdr(
                            orderItem.product!.price, 0),
                        style: heading6.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
