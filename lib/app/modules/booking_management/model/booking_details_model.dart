class BookingDetailsModel {
  final bool? success;
  final int? status;
  final String? message;
  final List<BookingData>? data;

  BookingDetailsModel({
    this.success,
    this.status,
    this.message,
    this.data,
  });

  factory BookingDetailsModel.fromJson(Map<String, dynamic> json) {
    return BookingDetailsModel(
      success: json['success'],
      status: json['status'],
      message: json['message'],
      data: (json['data'] as List<dynamic>?)
          ?.map((item) => BookingData.fromJson(item))
          .toList(),
    );
  }
}

class BookingData {
  final String? date;
  final String? time;
  final String? address;
  final String? status;
  final String? name;
  final String? phone;
  final String? orderId;
  final List<BookingService>? services;
  final int? totalPrice;
  final int? avgRating;

  BookingData({
    this.date,
    this.time,
    this.address,
    this.status,
    this.name,
    this.phone,
    this.orderId,
    this.services,
    this.totalPrice,
    this.avgRating,
  });

  factory BookingData.fromJson(Map<String, dynamic> json) {
    return BookingData(
      date: json['date'],
      time: json['time'],
      address: json['address'],
      status: json['status'],
      name: json['name'],
      phone: json['phone'],
      orderId: json['orderId'],
      services: (json['services'] as List<dynamic>?)
          ?.map((item) => BookingService.fromJson(item))
          .toList(),
      totalPrice: json['totalPrice'],
      avgRating: json['avgRating'],
    );
  }
}

class BookingService {
  final String? name;
  final int? price;

  BookingService({
    this.name,
    this.price,
  });

  factory BookingService.fromJson(Map<String, dynamic> json) {
    return BookingService(
      name: json['name'],
      price: json['price'],
    );
  }
}
