import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:pilatus/domain/entities/product.dart';
import 'package:pilatus/styles/colors.dart';
import 'package:pilatus/styles/text_styles.dart';
import 'package:pilatus/utils/currency_format.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({Key? key, required this.product}) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: const BackButton(
            color: secondaryColor,
          ),
          elevation: 0,
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  CurrencyFormat.convertToIdr(product.price!, 0),
                  style: heading3.copyWith(
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 40,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                      ),
                      onPressed: () => {},
                      child: Text(
                        'Masukkan ke Keranjang',
                        style: paragraph2.copyWith(
                            color: secondaryTextColor, fontSize: 14),
                      )),
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 32),
            child: Column(
              children: [
                Text(
                  product.name!,
                  style: heading3.copyWith(
                    fontSize: 22,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  CurrencyFormat.convertToIdr(product.price!, 0),
                  style: heading3.copyWith(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 32),
                  child: CachedNetworkImage(
                    imageUrl: product.photo!,
                    height: 300,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    placeholder: (context, url) =>
                        const BlurHash(hash: "LLKnJ7Mx_Nt8.8tRV@t7?bt8E1V?"),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Detail Produk',
                          style: heading3.copyWith(
                            fontSize: 16,
                            color: secondaryColor,
                          ),
                        ))),
                const SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: SizedBox(
                    height: 60,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          spacing: 30,
                          children: [
                            Text(
                              'Berat Satuan',
                              style: paragraph2.copyWith(
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              product.weight!.toString(),
                              style: paragraph2.copyWith(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                          child: Center(
                            child: Container(
                              margin: const EdgeInsetsDirectional.only(
                                  start: 1.0, end: 1.0),
                              height: .9,
                              color: secondaryLightColor.withOpacity(.10),
                            ),
                          ),
                        ),
                        Wrap(
                          spacing: 30,
                          children: [
                            Text(
                              'Kategori',
                              style: paragraph2.copyWith(
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              product.categoryId.toString(),
                              style: paragraph2.copyWith(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                          child: Center(
                            child: Container(
                              margin: const EdgeInsetsDirectional.only(
                                  start: 1.0, end: 1.0),
                              height: .9,
                              color: secondaryLightColor.withOpacity(.10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Deskripsi',
                          style: heading3.copyWith(
                            fontSize: 16,
                            color: secondaryColor,
                          ),
                        ))),
                const SizedBox(
                  height: 8,
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          product.description!,
                          textAlign: TextAlign.justify,
                          style: paragraph1.copyWith(
                            fontSize: 14,
                            color: secondaryColor,
                          ),
                        ))),
              ],
            ),
          ),
        ));
  }
}
