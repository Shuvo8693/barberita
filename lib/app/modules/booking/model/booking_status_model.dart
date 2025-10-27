class BookingsStatusModel {
  final bool? success;
  final int? status;
  final String? message;
  final List<BookingStatusData>? data;

  BookingsStatusModel({
    this.success,
    this.status,
    this.message,
    this.data,
  });

  factory BookingsStatusModel.fromJson(Map<String, dynamic> json) {
    return BookingsStatusModel(
      success: json['success'] ?? false,
      status: json['status'] ?? 0,
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>?)?.map((item) => BookingStatusData.fromJson(item)).toList() ?? [],
    );
  }
}

class BookingStatusData {
  final String? date;
  final String? time;
  final String? status;
  final String? address;
  final BarberInfo? barberInfo;
  final List<ServiceInfo>? services;
  final int? totalPrice;
  final String? bookingGroupId;

  BookingStatusData({
    this.date,
    this.time,
    this.status,
    this.address,
    this.barberInfo,
    this.services,
    this.totalPrice,
    this.bookingGroupId,
  });

  factory BookingStatusData.fromJson(Map<String, dynamic> json) {
    return BookingStatusData(
      date: json['date'] ?? '',
      time: json['time'] ?? '',
      status: json['status'] ?? '',
      address: json['address'] ?? '',
      barberInfo: json['barberInfo'] != null
          ? BarberInfo.fromJson(json['barberInfo'])
          : null,
      services: (json['services'] as List<dynamic>?)
          ?.map((item) => ServiceInfo.fromJson(item))
          .toList() ??
          [],
      totalPrice: json['totalPrice'] ?? 0,
      bookingGroupId: json['bookingGroupId'] ?? '',
    );
  }
}

class BarberInfo {
  final String? barberId;
  final String? name;
  final String? phone;
  final String? image;
  final String? cover;

  BarberInfo({
    this.barberId,
    this.name,
    this.phone,
    this.image,
    this.cover,
  });

  factory BarberInfo.fromJson(Map<String, dynamic> json) {
    return BarberInfo(
      barberId: json['barberId'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      image: json['image'] ?? '',
      cover: json['cover'] ?? '',
    );
  }
}

class ServiceInfo {
  final String? id;
  final String? name;
  final int? price;
  final String? image;

  ServiceInfo({
    this.id,
    this.name,
    this.price,
    this.image,
  });

  factory ServiceInfo.fromJson(Map<String, dynamic> json) {
    return ServiceInfo(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      price: json['price'] ?? 0,
      image: json['image'] ?? '',
    );
  }
}
