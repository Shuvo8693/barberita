class BarberDetailsModel {
  final bool? success;
  final int? status;
  final String? message;
  final BarberDetails? data;

  BarberDetailsModel({this.success, this.status, this.message, this.data});

  factory BarberDetailsModel.fromJson(Map<String, dynamic> json) {
    return BarberDetailsModel(
      success: json['success'] as bool?,
      status: json['status'] as int?,
      message: json['message'] as String?,
      data: json['data'] != null ? BarberDetails.fromJson(json['data']) : null,
    );
  }
}

class BarberDetails {
  final String? id;
  final String? userId;
  final String? residencePath;
  final String? healthCertificate;
  final String? barberCover;
  final int? rating;
  final int? reviewCount;
  final bool? isOpen;
  final String? status;
  final int? v;
  final String? about;
  final int? experience;
  final String? workingHour;
  final String? barberStatus;
  final String? barberId;
  final String? name;
  final String? phone;
  final String? image;
  final String? role;
  final double? longitude;
  final double? latitude;
  final Location? location;
  final bool? isVerified;
  final bool? isLogin;
  final bool? isDeleted;
  final String? createdAt;
  final String? updatedAt;
  final String? email;

  BarberDetails({
    this.id,
    this.userId,
    this.residencePath,
    this.healthCertificate,
    this.barberCover,
    this.rating,
    this.reviewCount,
    this.isOpen,
    this.status,
    this.v,
    this.about,
    this.experience,
    this.workingHour,
    this.barberStatus,
    this.barberId,
    this.name,
    this.phone,
    this.image,
    this.role,
    this.longitude,
    this.latitude,
    this.location,
    this.isVerified,
    this.isLogin,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.email,
  });

  factory BarberDetails.fromJson(Map<String, dynamic> json) {
    return BarberDetails(
      id: json['_id'] as String?,
      userId: json['userId'] as String?,
      residencePath: json['residencePath'] as String?,
      healthCertificate: json['healthCertificate'] as String?,
      barberCover: json['barberCover'] as String?,
      rating: json['rating'] as int?,
      reviewCount: json['reviewCount'] as int?,
      isOpen: json['isOpen'] as bool?,
      status: json['status'] as String?,
      v: json['__v'] as int?,
      about: json['about'] as String?,
      experience: json['experience'] as int?,
      workingHour: json['workingHour'] as String?,
      barberStatus: json['barberStatus'] as String?,
      barberId: json['barberId'] as String?,
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      image: json['image'] as String?,
      role: json['role'] as String?,
      longitude: (json['longitude'] as num?)?.toDouble(),
      latitude: (json['latitude'] as num?)?.toDouble(),
      location: json['location'] != null
          ? Location.fromJson(json['location'])
          : null,
      isVerified: json['isVerified'] as bool?,
      isLogin: json['isLogin'] as bool?,
      isDeleted: json['isDeleted'] as bool?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      email: json['email'] as String?,
    );
  }
}

class Location {
  final String? type;
  final List<dynamic>? coordinates;

  Location({this.type, this.coordinates});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      type: json['type'] as String?,
      coordinates: (json['coordinates'] as List<dynamic>?)
          ?.map((e) => e.toDouble())
          .toList(),
    );
  }
}
