class TermsAndPrivacyModel {
  final bool? success;
  final int? status;
  final String? message;
  final PrivacyData? data;

  TermsAndPrivacyModel({
    this.success,
    this.status,
    this.message,
    this.data,
  });

  factory TermsAndPrivacyModel.fromJson(Map<String, dynamic> json) {
    return TermsAndPrivacyModel(
      success: json['success'] as bool?,
      status: json['status'] as int?,
      message: json['message'] as String?,
      data: json['data'] != null ? PrivacyData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'status': status,
      'message': message,
      'data': data?.toJson(),
    };
  }
}

class PrivacyData {
  final String? id;
  final String? description;
  final String? createdAt;
  final String? updatedAt;
  final int? v;

  PrivacyData({
    this.id,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory PrivacyData.fromJson(Map<String, dynamic> json) {
    return PrivacyData(
      id: json['_id'] as String?,
      description: json['description'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      v: json['__v'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'description': description,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': v,
    };
  }
}
