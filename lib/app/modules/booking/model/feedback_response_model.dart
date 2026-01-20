class FeedbackResponseModel {
  final bool? success;
  final int? status;
  final String? message;
  final FeedbackData? data;

  FeedbackResponseModel({
    this.success,
    this.status,
    this.message,
    this.data,
  });

  factory FeedbackResponseModel.fromJson(Map<String, dynamic> json) {
    return FeedbackResponseModel(
      success: json['success'] as bool?,
      status: json['status'] as int?,
      message: json['message'] as String?,
      data: json['data'] != null
          ? FeedbackData.fromJson(json['data'])
          : null,
    );
  }
}

class FeedbackData {
  final String? id;
  final String? barberId;
  final String? customerId;
  final String? bookingGroupId;
  final String? reviewFor;
  final int? rating;
  final String? comment;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? version;

  FeedbackData({
    this.id,
    this.barberId,
    this.customerId,
    this.bookingGroupId,
    this.reviewFor,
    this.rating,
    this.comment,
    this.createdAt,
    this.updatedAt,
    this.version,
  });

  factory FeedbackData.fromJson(Map<String, dynamic> json) {
    return FeedbackData(
      id: json['_id'] as String?,
      barberId: json['barberId'] as String?,
      customerId: json['customerId'] as String?,
      bookingGroupId: json['bookingGroupId'] as String?,
      reviewFor: json['reviewFor'] as String?,
      rating: json['rating'] as int?,
      comment: json['comment'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'])
          : null,
      version: json['__v'] as int?,
    );
  }
}
