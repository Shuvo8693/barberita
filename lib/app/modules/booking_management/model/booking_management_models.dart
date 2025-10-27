// Models
class BookingData {
  final String name, service, address, phone, time, rating, orderId;
  final String? imageUrl;
  final List<OrderItem> items;
  final num? serviceFee, subtotal, total;
  final List<BookingStatus> statuses;

  BookingData({required this.name, required this.service, required this.address,
    required this.phone, required this.time, required this.rating, required this.orderId,
    this.imageUrl, required this.items, this.serviceFee, this.subtotal,
    required this.total, required this.statuses});
}

class OrderItem {
  final String name;
  final num price;
  final int quantity;
  OrderItem({required this.name, required this.price, this.quantity = 0});
}

class BookingStatus {
  final String title, timestamp;
  final bool isCompleted;
  BookingStatus({required this.title, required this.timestamp, this.isCompleted = false});
}
