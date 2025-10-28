class BookingDetailsModel {
  final bool? success;
  final int? status;
  final String? message;
  final List<BookingDetailsData>? data;

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
      data: (json['data'] as List<dynamic>?)?.map((item) => BookingDetailsData.fromJson(item)).toList(),
    );
  }
}

class BookingDetailsData {
  final String? date;
  final String? time;
  final String? address;
  final String? status;
  final String? name;
  final String? phone;
  final String? orderId;
  final List<BookingServiceDetails>? services;
  final num? totalPrice;
  final num? avgRating;

  BookingDetailsData({
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

  factory BookingDetailsData.fromJson(Map<String, dynamic> json) {
    return BookingDetailsData(
      date: json['date'],
      time: json['time'],
      address: json['address'],
      status: json['status'],
      name: json['name'],
      phone: json['phone'],
      orderId: json['orderId'],
      services: (json['services'] as List<dynamic>?)
          ?.map((item) => BookingServiceDetails.fromJson(item))
          .toList(),
      totalPrice: json['totalPrice'],
      avgRating: json['avgRating'],
    );
  }
}

class BookingServiceDetails {
  final String? name;
  final num? price;

  BookingServiceDetails({
    this.name,
    this.price,
  });

  factory BookingServiceDetails.fromJson(Map<String, dynamic> json) {
    return BookingServiceDetails(
      name: json['name'],
      price: json['price'],
    );
  }
}
