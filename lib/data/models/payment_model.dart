import 'package:pilatus/domain/entities/payment.dart';

class PaymentModel {
  final int id;
  final int amount;
  final String provider;
  final String status;
  final String updatedAt;

  PaymentModel(
      {required this.id,
      required this.amount,
      required this.provider,
      required this.status,
      required this.updatedAt});

  factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
        id: json['id'],
        status: json['status'],
        amount: json['amount'],
        provider: json['provider'],
        updatedAt: json['updated_at'],
      );

  Payment toEntity() {
    return Payment(
        id: id,
        status: status,
        amount: amount,
        provider: provider,
        updatedAt: updatedAt);
  }
}
