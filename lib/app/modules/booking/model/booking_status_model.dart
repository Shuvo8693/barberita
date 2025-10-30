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
  final UserInfo? userInfo;
  final List<ServiceInfo>? services;
  final int? totalPrice;
  final String? bookingGroupId;

  BookingStatusData({
    this.date,
    this.time,
    this.status,
    this.address,
    this.userInfo,
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
      userInfo: json['userInfo'] != null
          ? UserInfo.fromJson(json['userInfo'])
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

class UserInfo {
  final String? userId;
  final String? name;
  final String? phone;
  final String? image;
  final String? cover;

  UserInfo({
    this.userId,
    this.name,
    this.phone,
    this.image,
    this.cover,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      userId: json['barberId'] ?? '',
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
