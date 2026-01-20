class FeedbackResponseModel {
  bool? success;
  int? status;
  String? message;
  FeedbackData? data;

  FeedbackResponseModel({this.success, this.status, this.message, this.data});

  factory FeedbackResponseModel.fromMap(Map<String, dynamic> map) {
    return FeedbackResponseModel(
      success: map['success'],
      status: map['status'],
      message: map['message'],
      data: map['data'] != null ? FeedbackData.fromMap(map['data']) : null,
    );
  }
}

class FeedbackData {
  ReviewInfo? reviewInfo;
  CustomerInfo? customerInfo;
  BarberInfo? barberInfo;

  FeedbackData({this.reviewInfo, this.customerInfo, this.barberInfo});

  factory FeedbackData.fromMap(Map<String, dynamic> map) {
    return FeedbackData(
      reviewInfo: map['reviewInfo'] != null ? ReviewInfo.fromMap(map['reviewInfo']) : null,
      customerInfo: map['customerInfo'] != null ? CustomerInfo.fromMap(map['customerInfo']) : null,
      barberInfo: map['barberInfo'] != null ? BarberInfo.fromMap(map['barberInfo']) : null,
    );
  }
}

class ReviewInfo {
  String? barberId;
  String? customerId;
  String? bookingGroupId;
  String? reviewFor;
  int? rating;
  String? comment;
  String? createdAt;
  String? updatedAt;

  ReviewInfo({
    this.barberId,
    this.customerId,
    this.bookingGroupId,
    this.reviewFor,
    this.rating,
    this.comment,
    this.createdAt,
    this.updatedAt,
  });

  factory ReviewInfo.fromMap(Map<String, dynamic> map) {
    return ReviewInfo(
      barberId: map['barberId'],
      customerId: map['customerId'],
      bookingGroupId: map['bookingGroupId'],
      reviewFor: map['reviewFor'],
      rating: map['rating'],
      comment: map['comment'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
    );
  }
}

class CustomerInfo {
  String? name;
  String? image;
  String? phone;

  CustomerInfo({this.name, this.image, this.phone});

  factory CustomerInfo.fromMap(Map<String, dynamic> map) {
    return CustomerInfo(
      name: map['name'],
      image: map['image'],
      phone: map['phone'],
    );
  }
}

class BarberInfo {
  String? name;
  String? image;
  String? phone;

  BarberInfo({this.name, this.image, this.phone});

  factory BarberInfo.fromMap(Map<String, dynamic> map) {
    return BarberInfo(
      name: map['name'],
      image: map['image'],
      phone: map['phone'],
    );
  }
}
