class GetStatusOrder {
  static getStatus(String status) {
    switch (status) {
      case "PENDING":
        return "Belum Dibayar";
      case "SUCCESS":
        return "Berhasil";
      default:
    }
  }
}
