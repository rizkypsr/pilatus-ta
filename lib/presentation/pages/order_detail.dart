import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pilatus/styles/colors.dart';
import 'package:pilatus/styles/text_styles.dart';
import 'package:pilatus/utils/currency_format.dart';

class OrderDetail extends StatelessWidget {
  const OrderDetail({Key? key}) : super(key: key);

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
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(elevation: 0),
              onPressed: () => {},
              child: Text(
                'Pesanan Diterima',
                style: paragraph2.copyWith(
                    color: secondaryTextColor, fontSize: 14),
              )),
        ),
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
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            'LIHAT',
                          ),
                        )
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Regular',
                        style: paragraph2.copyWith(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'JNE',
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
                        'Paket telah dikirim dari Jakarta Utara',
                        style: paragraph2.copyWith(
                          fontSize: 12,
                          color: primaryColor,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '30-06-2022 14:31',
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
                            'Weli Febrianti',
                            style: paragraph2.copyWith(
                              fontSize: 12,
                              color: secondaryColor.withOpacity(.8),
                            ),
                          ),
                          Text(
                            '+62 82 266262 22',
                            style: paragraph2.copyWith(
                              fontSize: 12,
                              color: secondaryColor.withOpacity(.8),
                            ),
                          ),
                          Text(
                            'Jalan Pancasila GG Keadilan, Ketapang, Kalimantan Barat, ID, 728822',
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
                height: 180,
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 2,
                  itemBuilder: (context, index) => const OrderListItem(),
                ),
              ),
              Container(
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
                          'Bank Transfer - BCA Virtual Account',
                          style: paragraph2.copyWith(
                            fontSize: 12,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 12,
              ),
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
                          '887726626262EDTEAS',
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
                          '28-06-222 10:13',
                          style: paragraph2.copyWith(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Waktu Pembayaran',
                          style: paragraph2.copyWith(
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          '28-06-222 10:13',
                          style: paragraph2.copyWith(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Waktu Pengiriman',
                          style: paragraph2.copyWith(
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          '28-06-222 10:13',
                          style: paragraph2.copyWith(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    )
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
  const OrderListItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const OrderDetail(),
            ));
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.white,
        child: Column(
          children: [
            Row(
              children: [
                CachedNetworkImage(
                  imageUrl:
                      'https://images.pexels.com/photos/4202325/pexels-photo-4202325.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
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
                      const BlurHash(hash: "LLKnJ7Mx_Nt8.8tRV@t7?bt8E1V?"),
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
                          'Tampilan Nama Produk',
                          style: paragraph1.copyWith(
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'x1',
                          style: paragraph2.copyWith(
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          CurrencyFormat.convertToIdr(34000, 0),
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
      ),
    );
  }
}
