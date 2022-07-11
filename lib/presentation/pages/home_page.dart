import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:pilatus/common/constants.dart';
import 'package:pilatus/common/state_enum.dart';
import 'package:pilatus/domain/entities/product.dart';
import 'package:pilatus/presentation/pages/cart_page.dart';
import 'package:pilatus/presentation/pages/product_detail_page.dart';
import 'package:pilatus/presentation/provider/product_list_notifier.dart';
import 'package:pilatus/styles/text_styles.dart';
import 'package:pilatus/utils/currency_format.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<ProductListNotifier>(context, listen: false)
          ..fetchProducts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text('Pilatus Showroom'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => CartPage()));
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Consumer<ProductListNotifier>(builder: (context, data, child) {
          final state = data.productsState;
          if (state == RequestState.Loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state == RequestState.Loaded) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 10),
              itemCount: data.products.length,
              itemBuilder: (context, index) {
                return ProductListItem(
                  product: data.products[index],
                );
              },
            );
          } else if (state == RequestState.Error) {
            return Center(child: Text(data.message));
          } else {
            return Container();
          }
        }),
      ),
    );
  }
}

class ProductListItem extends StatelessWidget {
  const ProductListItem({Key? key, required this.product}) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductDetailPage(product: product)));
      },
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Stack(
            children: [
              CachedNetworkImage(
                imageUrl: '$baseUrl/storage/products/${product.photo}',
                fadeOutDuration: const Duration(milliseconds: 0),
                fadeInDuration: const Duration(milliseconds: 0),
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) =>
                    BlurHash(hash: product.blurhash!),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name!,
                        overflow: TextOverflow.ellipsis,
                        style: paragraph2.copyWith(fontSize: 12),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        CurrencyFormat.convertToIdr(product.price!, 0),
                        style: heading6.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
              // const SizedBox(
              //   height: 12,
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 12),
              //   child: Align(
              //     alignment: Alignment.centerLeft,
              //     child: Text(
              //       CurrencyFormat.convertToIdr(product.price!, 0),
              //       style: heading6.copyWith(
              //           fontWeight: FontWeight.bold, fontSize: 15),
              //     ),
              //   ),
              // )
            ],
          )),
    );
  }
}
