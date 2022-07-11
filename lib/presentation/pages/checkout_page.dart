import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pilatus/common/state_enum.dart';
import 'package:pilatus/domain/entities/cart_item.dart';
import 'package:pilatus/domain/entities/city.dart';
import 'package:pilatus/domain/entities/cost.dart';
import 'package:pilatus/domain/entities/province.dart';
import 'package:pilatus/domain/entities/shipping.dart';
import 'package:pilatus/presentation/provider/ongkir_notifier.dart';
import 'package:pilatus/presentation/provider/order_notifier.dart';
import 'package:pilatus/styles/colors.dart';
import 'package:pilatus/styles/text_styles.dart';
import 'package:provider/provider.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key, required this.cartItems}) : super(key: key);

  final List<CartItem> cartItems;

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  int currentStep = 0;

  List<Step> getSteps() => [
        Step(
            title: Text(
              'Pengiriman',
              style: paragraph2.copyWith(fontSize: 12),
            ),
            state: currentStep > 0 ? StepState.complete : StepState.indexed,
            isActive: currentStep >= 0,
            content: const DeliveryStep()),
        Step(
            title: Text(
              'Selesaikan Pesanan',
              style: paragraph2.copyWith(fontSize: 12),
            ),
            isActive: currentStep >= 1,
            content: const OrderStep()),
      ];

  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<OngkirNotifier>(context, listen: false)..fetchProvinces());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Checkout',
          style: heading6.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: const BackButton(),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: Stepper(
              type: StepperType.horizontal,
              steps: getSteps(),
              currentStep: currentStep,
              onStepContinue: () {
                debugPrint('dsdsdsds sd s ds ds ds ds ds ds');
                final isLastStep = currentStep == getSteps().length - 1;

                if (!isLastStep) {
                  setState(() => {currentStep += 1});
                }
              },
              onStepCancel: currentStep == 0
                  ? null
                  : () => {
                        setState(() => {currentStep -= 1})
                      },
              controlsBuilder: (
                context,
                controlDetails,
              ) {
                return Container(
                  margin: const EdgeInsets.only(top: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      if (currentStep == 0)
                        Expanded(
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(elevation: 0),
                                onPressed: () {
                                  final isLastStep =
                                      currentStep == getSteps().length - 1;

                                  var province = context
                                      .read<OngkirNotifier>()
                                      .provinceValue;
                                  var city =
                                      context.read<OngkirNotifier>().cityValue;
                                  var ongkir = context
                                      .read<OngkirNotifier>()
                                      .ongkirValue;

                                  var address = "address";
                                  var postalCode = city.postalCode;
                                  var courier = "JNE";
                                  var service = ongkir.service;
                                  var cost = ongkir.value;

                                  Shipping shipping = Shipping(
                                      address: address,
                                      province: province.provinceName,
                                      city: city.cityName,
                                      postalCode: postalCode,
                                      courier: courier,
                                      service: service,
                                      cost: cost);
                                  context.read<OrderNotifier>().checkoutProduct(
                                      shipping,
                                      widget.cartItems[0].cart!.id!,
                                      context);

                                  if (!isLastStep) {
                                    setState(() => {currentStep += 1});
                                  }
                                },
                                child: Text(
                                  'Proses Pembayaran',
                                  style: paragraph2.copyWith(
                                      color: secondaryTextColor, fontSize: 14),
                                ))),
                      if (currentStep == 1)
                        Expanded(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(elevation: 0),
                              onPressed: () {},
                              child: Text(
                                'Belanja Lagi',
                                style: paragraph2.copyWith(
                                    color: secondaryTextColor, fontSize: 14),
                              )),
                        ),
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class DeliveryStep extends StatefulWidget {
  const DeliveryStep({Key? key}) : super(key: key);

  @override
  State<DeliveryStep> createState() => _DeliveryStepState();
}

class _DeliveryStepState extends State<DeliveryStep> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Pilih Alamat Pengiriman',
            style: paragraph2.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(
          height: 14,
        ),
        Consumer<OngkirNotifier>(builder: (context, data, _) {
          final state = data.provinceState;

          if (state == RequestState.Loading) {
            return const CircularProgressIndicator();
          }

          if (state == RequestState.Loaded) {
            return DropdownButtonHideUnderline(
                child: DropdownButton(
              iconSize: 36,
              icon: const Icon(
                Icons.arrow_drop_down,
                color: Color(0xff13A89E),
              ),
              isExpanded: true,
              value: data.provinceValue,
              items: data.provinces.map((province) {
                return DropdownMenuItem(
                  value: province,
                  child: Text(province.provinceName!),
                );
              }).toList(),
              onChanged: (value) {
                data.changeProvinceValue(value as Province);
              },
            ));
          }

          if (state == RequestState.Error) {
            return Text(data.provinceMessage);
          }

          return const SizedBox();
        }),
        Consumer<OngkirNotifier>(builder: (context, data, _) {
          final state = data.cityState;

          if (state == RequestState.Loading) {
            return const CircularProgressIndicator();
          }

          if (state == RequestState.Loaded) {
            return DropdownButtonHideUnderline(
                child: DropdownButton(
              iconSize: 36,
              icon: const Icon(
                Icons.arrow_drop_down,
                color: Color(0xff13A89E),
              ),
              isExpanded: true,
              value: data.cityValue,
              items: data.cities.map((item) {
                return DropdownMenuItem(
                  value: item,
                  child: Text(
                      '${item.type} ${item.cityName} - ${item.postalCode}'),
                );
              }).toList(),
              onChanged: (value) {
                data.changeCityValue(value as City);
              },
            ));
          }

          if (state == RequestState.Error) {
            return Text(data.provinceMessage);
          }

          return const SizedBox();
        }),
        Consumer<OngkirNotifier>(builder: (context, data, _) {
          final state = data.ongkirState;

          if (state == RequestState.Loading) {
            return const CircularProgressIndicator();
          }

          if (state == RequestState.Loaded) {
            return DropdownButtonHideUnderline(
                child: DropdownButton(
              iconSize: 36,
              icon: const Icon(
                Icons.arrow_drop_down,
                color: Color(0xff13A89E),
              ),
              isExpanded: true,
              value: data.ongkirValue,
              items: data.ongkir.costs.map((item) {
                return DropdownMenuItem(
                  value: item,
                  child: Text(
                      '${item.service} - ${item.value} (${item.etd} hari)'),
                );
              }).toList(),
              onChanged: (value) {
                data.changeOngkirValue(value as Cost);
              },
            ));
          }

          if (state == RequestState.Error) {
            return Text(data.ongkirMessage);
          }

          return const SizedBox();
        })
      ],
    );
  }
}

class OrderStep extends StatelessWidget {
  const OrderStep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 260,
          child: SvgPicture.asset(
            'assets/order_confirmed.svg',
          ),
        ),
        const SizedBox(
          height: 32,
        ),
        Text(
          'Order Berhasil',
          style: heading6,
        ),
        const SizedBox(
          height: 12,
        ),
        Text(
          'Selamat! Pesanan berhasil dibuat. Silahkan melakukan pembayaran',
          textAlign: TextAlign.center,
          style: paragraph2,
        )
      ],
    );
  }
}
