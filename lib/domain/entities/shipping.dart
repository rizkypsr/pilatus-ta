class Shipping {
  final int? id;
  final String? resi;
  final String? address;
  final String? province;
  final String? city;
  final String? postalCode;
  final String? courier;
  final String? service;
  final int? cost;
  final String? updatedAt;

  Shipping(
      {this.id,
      this.resi,
      this.address,
      this.province,
      this.city,
      this.postalCode,
      this.courier,
      this.service,
      this.cost,
      this.updatedAt});
}
