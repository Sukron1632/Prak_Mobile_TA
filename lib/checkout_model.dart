// checkout_model.dart
class CheckoutSession {
  final int id;
  final DateTime checkoutTime;
  final List<String> productNames;
  final double totalPrice;
  final String status;

  CheckoutSession({
    required this.id,
    required this.checkoutTime,
    required this.productNames,
    required this.totalPrice,
    this.status = ' Dalam Proses',
  });
}