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
  final List<Review>? reviews;

  ReviewData({this.reviews});

  factory ReviewData.fromJson(Map<String, dynamic> json) {
    var reviewList = json['reviews'] as List<dynamic>?;
    List<Review> reviews = reviewList != null
        ? reviewList.map((e) => Review.fromJson(e as Map<String, dynamic>)).toList()
        : [];

    return ReviewData(
      reviews: reviews,
    );
  }
}

class Review {
  final int? totalReviews;
  final List<BarberReview>? reviews;

  Review({this.totalReviews, this.reviews});

  factory Review.fromJson(Map<String, dynamic> json) {
    var reviewList = json['reviews'] as List<dynamic>?;
    List<BarberReview> reviews = reviewList != null
        ? reviewList.map((e) => BarberReview.fromJson(e as Map<String, dynamic>)).toList()
        : [];

    return Review(
      totalReviews: json['totalReviews'] as int?,
      reviews: reviews,
    );
  }
}

class BarberReview {
  final String? id;
  final String? barberId;
  final int? rating;
  final String? comment;
  final String? createdAt;
  final String? name;
  final String? image;

  BarberReview({
    this.id,
    this.barberId,
    this.rating,
    this.comment,
    this.createdAt,
    this.name,
    this.image,
  });

  factory BarberReview.fromJson(Map<String, dynamic> json) {
    return BarberReview(
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
