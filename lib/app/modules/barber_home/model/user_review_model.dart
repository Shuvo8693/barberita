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
      success: json['success'] ?? false,
      status: json['status'] ?? 0,
      message: json['message'] ?? '',
      data: json['data'] != null ? UserReviewData.fromJson(json['data']) : null,
    );
  }
}

class UserReviewData {
  final List<ReviewGroup>? reviews;

  UserReviewData({this.reviews});

  factory UserReviewData.fromJson(Map<String, dynamic> json) {
    return UserReviewData(
      reviews: (json['reviews'] as List<dynamic>?)
          ?.map((item) => ReviewGroup.fromJson(item))
          .toList() ??
          [],
    );
  }
}

class ReviewGroup {
  final int? totalReviews;
  final List<UserReview>? reviews;

  ReviewGroup({this.totalReviews, this.reviews});

  factory ReviewGroup.fromJson(Map<String, dynamic> json) {
    return ReviewGroup(
      totalReviews: json['totalReviews'] ?? 0,
      reviews: (json['reviews'] as List<dynamic>?)
          ?.map((item) => UserReview.fromJson(item)).toList() ?? [],
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
      id: json['_id'] ?? '',
      barberId: json['barberId'] ?? '',
      rating: json['rating'] ?? 0,
      comment: json['comment'] ?? '',
      createdAt: json['createdAt'] ?? '',
      name: json['name'] ?? '',
      image: json['image'] ?? '',
    );
  }
}
