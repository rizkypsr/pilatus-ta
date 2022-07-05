import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:pilatus/domain/entities/product.dart';
import 'package:pilatus/presentation/pages/cart_page.dart';
import 'package:pilatus/presentation/pages/category_detail_page.dart';
import 'package:pilatus/presentation/pages/product_detail_page.dart';
import 'package:pilatus/styles/colors.dart';
import 'package:pilatus/styles/text_styles.dart';
import 'package:pilatus/utils/currency_format.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final products = [
    Product(
        id: 1,
        name: 'Produk 1',
        photo:
            "https://images.pexels.com/photos/3270223/pexels-photo-3270223.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. ',
        categoryId: 1,
        inventoryId: 1,
        price: 30000,
        weight: 0.5,
        updatedAt: DateTime.now()),
    Product(
        id: 1,
        name: 'Produk 1',
        photo:
            "https://images.pexels.com/photos/4202325/pexels-photo-4202325.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. ',
        categoryId: 1,
        inventoryId: 1,
        price: 30000,
        weight: 0.5,
        updatedAt: DateTime.now()),
    Product(
        id: 1,
        name: 'Produk 1',
        photo:
            "https://images.pexels.com/photos/3270223/pexels-photo-3270223.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. ',
        categoryId: 1,
        inventoryId: 1,
        price: 30000,
        weight: 0.5,
        updatedAt: DateTime.now()),
    Product(
        id: 1,
        name: 'Produk 1',
        photo:
            "https://images.pexels.com/photos/3270223/pexels-photo-3270223.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. ',
        categoryId: 1,
        inventoryId: 1,
        price: 30000,
        weight: 0.5,
        updatedAt: DateTime.now()),
    Product(
        id: 1,
        name: 'Produk 1',
        photo:
            "https://images.pexels.com/photos/3270223/pexels-photo-3270223.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. ',
        categoryId: 1,
        inventoryId: 1,
        price: 30000,
        weight: 0.5,
        updatedAt: DateTime.now()),
  ];

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Kategori 1',
                    style: heading6,
                  ),
                  OutlinedButton(
                      onPressed: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CategoryDetailPage(),
                                ))
                          },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text(
                            'Lihat',
                            style: TextStyle(color: secondaryLightColor),
                          ),
                          Icon(
                            Icons.keyboard_arrow_right_outlined,
                            color: secondaryLightColor,
                          )
                        ],
                      )),
                ],
              ),
              SizedBox(
                height: 190,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return ProductListItem(
                      product: products[index],
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Kategori 2',
                    style: heading6,
                  ),
                  OutlinedButton(
                      onPressed: () => {},
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text(
                            'Lihat',
                            style: TextStyle(color: secondaryLightColor),
                          ),
                          Icon(
                            Icons.keyboard_arrow_right_outlined,
                            color: secondaryLightColor,
                          )
                        ],
                      )),
                ],
              ),
              SizedBox(
                height: 190,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return ProductListItem(
                      product: products[index],
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Kategori 1',
                    style: heading6,
                  ),
                  OutlinedButton(
                      onPressed: () => {},
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text(
                            'Lihat',
                            style: TextStyle(color: secondaryLightColor),
                          ),
                          Icon(
                            Icons.keyboard_arrow_right_outlined,
                            color: secondaryLightColor,
                          )
                        ],
                      )),
                ],
              ),
              SizedBox(
                height: 190,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return ProductListItem(
                      product: products[index],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
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
      onTap: () => {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductDetailPage(product: product)))
      },
      child: SizedBox(
        width: 140,
        child: Card(
            child: Column(
          children: [
            CachedNetworkImage(
              imageUrl: product.photo!,
              height: 100,
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
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  product.name!,
                  style: heading6.copyWith(
                      fontWeight: FontWeight.w700, fontSize: 14),
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  CurrencyFormat.convertToIdr(product.price!, 0),
                  style: heading6.copyWith(
                      fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}
