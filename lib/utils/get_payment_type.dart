class GetPaymentType {
  static getStatus(String type) {
    switch (type) {
      case "bca":
        return "BCA Virtual Account";
      case "bri":
        return "BRI Virtual Account";
      case "bni":
        return "BNI Virtual Account";
      default:
    }
  }
}
