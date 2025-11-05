class UserInfoModel {
  final bool? success;
  final int? status;
  final String? message;
  final UserInfoData? data;

  UserInfoModel({
    this.success,
    this.status,
    this.message,
    this.data,
  });

  factory UserInfoModel.fromJson(Map<String, dynamic> json) {
    return UserInfoModel(
      success: json['success'] as bool?,
      status: json['status'] as int?,
      message: json['message'] as String?,
      data: json['data'] != null ? UserInfoData.fromJson(json['data']) : null,
    );
  }
}

class UserInfoData {
  final String? id;
  final String? userId;
  final String? residencePath;
  final String? healthCertificate;
  final int? rating;
  final int? reviewCount;
  final String? status;
  final int? v;
  final String? about;
  final String? address;
  final int? experience;
  final String? workingHour;
  final String? barberCover;
  final String? name;
  final String? password;
  final String? phone;
  final String? image;
  final String? role;
  final bool? isVerified;
  final bool? isDeleted;
  final String? createdAt;
  final String? updatedAt;
  final Location? location;
  final bool? isLogin;
        bool? isOpen;
  final String? email;

  UserInfoData( {
    this.id,
    this.userId,
    this.residencePath,
    this.healthCertificate,
    this.rating,
    this.reviewCount,
    this.status,
    this.v,
    this.about,
    this.experience,
    this.workingHour,
    this.barberCover,
    this.name,
    this.password,
    this.phone,
    this.image,
    this.role,
    this.isVerified,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.location,
    this.isLogin,
    this.isOpen,
    this.email,
    this.address,
  });

  factory UserInfoData.fromJson(Map<String, dynamic> json) {
    return UserInfoData(
      id: json['_id'] as String?,
      userId: json['userId'] as String?,
      residencePath: json['residencePath'] as String?,
      healthCertificate: json['healthCertificate'] as String?,
      rating: json['rating'] as int?,
      reviewCount: json['reviewCount'] as int?,
      status: json['status'] as String?,
      v: json['__v'] as int?,
      about: json['about'] as String?,
      address: json['address'] as String?,
      experience: json['experience'] as int?,
      workingHour: json['workingHour'] as String?,
      barberCover: json['barberCover'] as String?,
      name: json['name'] as String?,
      password: json['password'] as String?,
      phone: json['phone'] as String?,
      image: json['image'] as String?,
      role: json['role'] as String?,
      isVerified: json['isVerified'] as bool?,
      isDeleted: json['isDeleted'] as bool?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      location:
      json['location'] != null ? Location.fromJson(json['location']) : null,
      isLogin: json['isLogin'] as bool?,
      isOpen: json['isOpen'] as bool?,
      email: json['email'] as String?,
    );
  }
}

class Location {
  final String? type;
  final List<double>? coordinates;

  Location({
    this.type,
    this.coordinates,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      type: json['type'] as String?,
      coordinates: (json['coordinates'] as List<dynamic>?)
          ?.map((e) => (e as num).toDouble())
          .toList(),
    );
  }
}
