import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_spinbox/material.dart';
import 'package:pilatus/common/constants.dart';
import 'package:pilatus/common/state_enum.dart';
import 'package:pilatus/domain/entities/cart_item.dart';
import 'package:pilatus/presentation/pages/checkout_page.dart';
import 'package:pilatus/presentation/provider/cart_notifier.dart';
import 'package:pilatus/styles/colors.dart';
import 'package:pilatus/styles/text_styles.dart';
import 'package:pilatus/utils/currency_format.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<CartNotifier>(context, listen: false)..fetchCartItems());
  }

  Future<void> removeFromCart(int cartItemId) async {
    await Provider.of<CartNotifier>(context, listen: false)
        .removeProductFromCart(cartItemId);

    if (!mounted) return;
    final message =
        Provider.of<CartNotifier>(context, listen: false).removeCartMessage;

    if (message == CartNotifier.removeFromCartSuccessMessage) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    }
  }

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
              Consumer<CartNotifier>(builder: (context, data, child) {
                final state = data.cartState;

                if (state == RequestState.Loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.Loaded) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: data.cartItems.length,
                      itemBuilder: (context, index) => Slidable(
                          endActionPane: ActionPane(
                            motion: const DrawerMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (context) {
                                  removeFromCart(data.cartItems[index].id!);
                                },
                                backgroundColor: Colors.redAccent,
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                                label: 'Delete',
                              )
                            ],
                          ),
                          child: CartListItem(
                            cartItem: data.cartItems[index],
                          )),
                    ),
                  );
                } else if (state == RequestState.Error) {
                  return Expanded(child: Center(child: Text(data.message)));
                } else {
                  return const Expanded(
                      child: Center(child: Text('Keranjang kosong')));
                }
              }),
              Consumer<CartNotifier>(builder: (context, data, _) {
                final state = data.cartState;
                if (state == RequestState.Loaded) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 18),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Total'),
                            Consumer<CartNotifier>(
                                builder: (context, data, child) {
                              final state = data.cartState;

                              if (state == RequestState.Loaded) {
                                return Text(
                                  CurrencyFormat.convertToIdr(
                                      data.cartItems[0].cart!.total, 0),
                                  style: heading3.copyWith(
                                    fontSize: 16,
                                  ),
                                );
                              }

                              return const SizedBox();
                            }),
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
                                          builder: (context) => CheckoutPage(
                                            cartItems: data.cartItems,
                                          ),
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
                  );
                }
                return Container();
              })
            ],
          )),
    );
  }
}

class CartListItem extends StatelessWidget {
  const CartListItem({Key? key, required this.cartItem}) : super(key: key);

  final CartItem cartItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      height: 180,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            imageUrl: '$baseUrl/storage/products/${cartItem.product!.photo}',
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
                BlurHash(hash: cartItem.product!.blurhash!),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cartItem.product!.name!,
                  overflow: TextOverflow.ellipsis,
                  style: heading6.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  'Weight: ${cartItem.product!.weight!.toString()} gram',
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
                  CurrencyFormat.convertToIdr(cartItem.product!.price!, 0),
                  style: heading3.copyWith(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Text('x${cartItem.quantity!}')
              ],
            ),
          )
        ],
      ),
    );
  }
}
