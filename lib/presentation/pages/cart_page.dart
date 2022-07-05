import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_spinbox/material.dart';
import 'package:pilatus/domain/entities/product.dart';
import 'package:pilatus/presentation/pages/checkout_page.dart';
import 'package:pilatus/styles/colors.dart';
import 'package:pilatus/styles/text_styles.dart';
import 'package:pilatus/utils/currency_format.dart';

class CartPage extends StatelessWidget {
  CartPage({Key? key}) : super(key: key);

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
        centerTitle: true,
        title: Text(
          'Keranjang',
          style: heading6.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: const BackButton(),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) => Slidable(
                      endActionPane: ActionPane(
                        motion: const DrawerMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) {},
                            backgroundColor: Colors.redAccent,
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete',
                          )
                        ],
                      ),
                      child: const CartListItem()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 18),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total'),
                        Text(
                          CurrencyFormat.convertToIdr(35900, 0),
                          style: heading3.copyWith(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(elevation: 0),
                          onPressed: () => {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CheckoutPage(),
                                    ))
                              },
                          child: Text(
                            'Checkout',
                            style: paragraph2.copyWith(
                                color: secondaryTextColor, fontSize: 14),
                          )),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}

class CartListItem extends StatelessWidget {
  const CartListItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      height: 180,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            imageUrl:
                "https://images.pexels.com/photos/4202325/pexels-photo-4202325.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
            width: 130,
            height: double.infinity,
            fadeOutDuration: const Duration(milliseconds: 0),
            fadeInDuration: const Duration(milliseconds: 0),
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
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
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Produk 1',
                style: heading6.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                'Weight: 1.2',
                style: paragraph2.copyWith(
                  color: secondaryLightColor.withOpacity(.60),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                CurrencyFormat.convertToIdr(35900, 0),
                style: heading3.copyWith(
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              SizedBox(
                height: 50,
                width: 140,
                child: SpinBox(
                  min: 1,
                  max: 100,
                  value: 1,
                  showCursor: true,
                  textAlign: TextAlign.center,
                  onChanged: (value) => print(value),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
