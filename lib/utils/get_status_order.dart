class GetStatusOrder {
  static getStatus(String status) {
    switch (status) {
      case "PENDING":
        return "Belum Dibayar";
      case "PROCCESSED":
        return "Sedang Diproses";
      case "DELIVERED":
        return "Sedang Dikirim";
      case "SUCCESS":
        return "Berhasil";
      default:
    }
  }
}
