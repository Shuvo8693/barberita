class BarberReviewModel {
  final bool? success;
  final int? status;
  final String? message;
  final ReviewData? data;

  BarberReviewModel({this.success, this.status, this.message, this.data});

  factory BarberReviewModel.fromJson(Map<String, dynamic> json) {
    return BarberReviewModel(
      success: json['success'] as bool?,
      status: json['status'] as int?,
      message: json['message'] as String?,
      data: json['data'] != null ? ReviewData.fromJson(json['data']) : null,
    );
  }
}

class ReviewData {
  final List<BarberReview>? reviews;

  ReviewData({this.reviews});

  factory ReviewData.fromJson(Map<String, dynamic> json) {
    return ReviewData(
      reviews: (json['reviews'] as List<dynamic>?)
          ?.map((e) => BarberReview.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class BarberReview {
  final String? id;
  final String? barberId;
  final String? customerId;
  final String? serviceId;
  final String? reviewFor;
  final int? rating;
  final String? comment;
  final String? createdAt;
  final String? updatedAt;
  final int? v;

  BarberReview({
    this.id,
    this.barberId,
    this.customerId,
    this.serviceId,
    this.reviewFor,
    this.rating,
    this.comment,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory BarberReview.fromJson(Map<String, dynamic> json) {
    return BarberReview(
      id: json['_id'] as String?,
      barberId: json['barberId'] as String?,
      customerId: json['customerId'] as String?,
      serviceId: json['serviceId'] as String?,
      reviewFor: json['reviewFor'] as String?,
      rating: json['rating'] as int?,
      comment: json['comment'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      v: json['__v'] as int?,
    );
  }
}
