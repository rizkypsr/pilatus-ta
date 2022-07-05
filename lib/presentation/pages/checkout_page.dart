import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pilatus/styles/colors.dart';
import 'package:pilatus/styles/text_styles.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);

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
                              onPressed: controlDetails.onStepContinue,
                              child: Text(
                                'Proses Pembayaran',
                                style: paragraph2.copyWith(
                                    color: secondaryTextColor, fontSize: 14),
                              )),
                        ),
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

class DeliveryStep extends StatelessWidget {
  const DeliveryStep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
        SizedBox(
          width: double.infinity,
          height: 40,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                side: const BorderSide(color: Colors.grey, width: .5),
                primary: Colors.white,
              ),
              onPressed: () => {},
              child: Text(
                'Ubah Alamat',
                style: paragraph2.copyWith(color: secondaryColor, fontSize: 14),
              )),
        ),
        const SizedBox(
          height: 24,
        ),
        Container(
          height: 100,
          padding: const EdgeInsets.all(14),
          width: double.infinity,
          decoration: BoxDecoration(
            color: primaryColor.withOpacity(.1),
            border: Border.all(
              color: primaryColor,
              width: .7,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Weli Febrianti',
                style: paragraph2.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '+62 8988 8822 22',
                style: paragraph2.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                'Kalimantan Barat, Ketapang - Jalan Pancasila Gang Keadalian No 5 - RT 05, RW 005',
                style: paragraph2.copyWith(
                  fontSize: 12,
                  color: secondaryLightColor,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        )
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
          'Selamat! Pesanan kamu telah berhasil',
          style: paragraph2,
        )
      ],
    );
  }
}
