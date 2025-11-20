class UserReviewModel {
  final bool? success;
  final int? status;
  final String? message;
  final UserReviewData? data;

  UserReviewModel({
    this.success,
    this.status,
    this.message,
    this.data,
  });

  factory UserReviewModel.fromJson(Map<String, dynamic> json) {
    return UserReviewModel(
      success: json['success'] as bool?,
      status: json['status'] as int?,
      message: json['message'] as String?,
      data: json['data'] != null
          ? UserReviewData.fromJson(json['data'])
          : null,
    );
  }
}

class UserReviewData {
  final int? totalReviews;
  final String? barberId;
  final List<UserReview>? reviews;

  UserReviewData({
    this.totalReviews,
    this.barberId,
    this.reviews,
  });

  factory UserReviewData.fromJson(Map<String, dynamic> json) {
    return UserReviewData(
      totalReviews: json['totalReviews'] as int?,
      barberId: json['barberId'] as String?,
      reviews: (json['reviews'] as List<dynamic>?)
          ?.map((e) => UserReview.fromJson(e))
          .toList()
          ?? [],
    );
  }
}

class UserReview {
  final String? id;
  final String? barberId;
  final int? rating;
  final String? comment;
  final String? createdAt;
  final String? name;
  final String? image;

  UserReview({
    this.id,
    this.barberId,
    this.rating,
    this.comment,
    this.createdAt,
    this.name,
    this.image,
  });

  factory UserReview.fromJson(Map<String, dynamic> json) {
    return UserReview(
      id: json['_id'] as String?,
      barberId: json['barberId'] as String?,
      rating: json['rating'] as int?,
      comment: json['comment'] as String?,
      createdAt: json['createdAt'] as String?,
      name: json['name'] as String?,
      image: json['image'] as String?,
    );
  }
}
