import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:pilatus/common/constants.dart';
import 'package:pilatus/common/state_enum.dart';
import 'package:pilatus/domain/entities/order.dart';
import 'package:pilatus/presentation/pages/order_detail.dart';
import 'package:pilatus/presentation/provider/order_list_notifier.dart';
import 'package:pilatus/styles/colors.dart';
import 'package:pilatus/styles/text_styles.dart';
import 'package:pilatus/utils/currency_format.dart';
import 'package:pilatus/utils/get_status_order.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> with TickerProviderStateMixin {
  late TabController _tabController;

  final List<Tab> _tabs = [
    Tab(
        child: Text(
      'Belum Dibayar',
      style: paragraph2,
    )),
    Tab(
        child: Text(
      'Diproses',
      style: paragraph2,
    )),
    Tab(
        child: Text(
      'Selesai',
      style: paragraph2,
    )),
  ];

  static const List<Widget> _views = [
    UnpaidTabView(),
    ProccessTabView(),
    CancelledTabView()
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.animateTo(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Pesanan',
          style: heading6.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          tabs: _tabs,
          isScrollable: true,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        physics: const BouncingScrollPhysics(),
        dragStartBehavior: DragStartBehavior.down,
        children: _views,
      ),
    );
  }
}

class UnpaidTabView extends StatefulWidget {
  const UnpaidTabView({Key? key}) : super(key: key);

  @override
  State<UnpaidTabView> createState() => _UnpaidTabViewState();
}

class _UnpaidTabViewState extends State<UnpaidTabView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<OrderListNotifier>(context, listen: false)
          ..fetchOrders("PENDING"));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Consumer<OrderListNotifier>(builder: (context, data, _) {
        final state = data.ordersState;

        if (state == RequestState.Loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state == RequestState.Loaded) {
          return ListView.builder(
            itemCount: data.orders.length,
            itemBuilder: (context, index) => OrderListItem(
              order: data.orders[index],
            ),
          );
        }

        return const SizedBox();
      }),
    );
  }
}

class ProccessTabView extends StatefulWidget {
  const ProccessTabView({Key? key}) : super(key: key);

  @override
  State<ProccessTabView> createState() => _ProccessTabViewState();
}

class _ProccessTabViewState extends State<ProccessTabView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<OrderListNotifier>(context, listen: false)
          ..fetchOrders("SUCCESS"));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Consumer<OrderListNotifier>(builder: (context, data, _) {
        final state = data.ordersState;

        if (state == RequestState.Loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state == RequestState.Loaded) {
          return ListView.builder(
            itemCount: data.orders.length,
            itemBuilder: (context, index) => OrderListItem(
              order: data.orders[index],
            ),
          );
        }

        return const SizedBox();
      }),
    );
  }
}

class CancelledTabView extends StatefulWidget {
  const CancelledTabView({Key? key}) : super(key: key);

  @override
  State<CancelledTabView> createState() => _CancelledTabViewState();
}

class _CancelledTabViewState extends State<CancelledTabView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<OrderListNotifier>(context, listen: false)
          ..fetchOrders("CANCELLED"));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Consumer<OrderListNotifier>(builder: (context, data, _) {
        final state = data.ordersState;

        if (state == RequestState.Loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state == RequestState.Loaded) {
          return ListView.builder(
            itemCount: data.orders.length,
            itemBuilder: (context, index) => OrderListItem(
              order: data.orders[index],
            ),
          );
        }

        return const SizedBox();
      }),
    );
  }
}

class OrderListItem extends StatelessWidget {
  const OrderListItem({Key? key, required this.order}) : super(key: key);

  final Orders order;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OrderDetail(order: order),
            ));
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(bottom: 12),
        color: Colors.white,
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                GetStatusOrder.getStatus(order.status!),
                style: paragraph2.copyWith(
                  fontSize: 12,
                  color: primaryColor,
                ),
              ),
            ),
            Row(
              children: [
                CachedNetworkImage(
                  imageUrl:
                      '$baseUrl/storage/products/${order.orderItem![0].product!.photo}',
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
                      BlurHash(hash: order.orderItem![0].product!.blurhash!),
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
                          order.orderItem![0].product!.name!,
                          style: paragraph1.copyWith(
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'x${order.orderItem![0].quantity.toString()}',
                          style: paragraph2.copyWith(
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          CurrencyFormat.convertToIdr(
                              order.orderItem![0].product!.price, 0),
                          style: heading6.copyWith(
                              fontWeight: FontWeight.bold, fontSize: 15),
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
                )
              ],
            ),
            order.orderItem!.length > 1 ? const Divider() : const SizedBox(),
            order.orderItem!.length > 1
                ? Text(
                    'Tampilkan ${order.orderItem!.length - 1} produk lagi',
                    style: paragraph2.copyWith(fontSize: 12),
                  )
                : const SizedBox(),
            order.orderItem!.length > 1 ? const Divider() : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
