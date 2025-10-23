class NearByBarberModel {
  final bool? success;
  final int? status;
  final String? message;
  final List<NearbyBarber>? nearbyBarberList;

  NearByBarberModel({this.success, this.status, this.message, this.nearbyBarberList});

  factory NearByBarberModel.fromJson(Map<String, dynamic> json) {
    return NearByBarberModel(
      success: json['success'] as bool?,
      status: json['status'] as int?,
      message: json['message'] as String?,
      nearbyBarberList: (json['data'] as List<dynamic>?)?.map((e) => NearbyBarber.fromJson(e as Map<String, dynamic>)).toList(),
    );
  }
}

class NearbyBarber {
  final String? id;
  final String? name;
  final String? phone;
  final String? image;
  final String? role;
  final String? status;
  final double? longitude;
  final double? latitude;
  final bool? isVerified;
  final bool? isDeleted;
  final bool? isLogin;
  final String? createdAt;
  final String? updatedAt;
  final int? v;
  final BarberDetails? barberDetails;
  final double? minPrice;
  final double? maxPrice;
  final Location? location;

  NearbyBarber({
    this.id,
    this.name,
    this.phone,
    this.image,
    this.role,
    this.status,
    this.longitude,
    this.latitude,
    this.isVerified,
    this.isDeleted,
    this.isLogin,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.barberDetails,
    this.minPrice,
    this.maxPrice,
    this.location,
  });

  factory NearbyBarber.fromJson(Map<String, dynamic> json) {
    return NearbyBarber(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      image: json['image'] as String?,
      role: json['role'] as String?,
      status: json['status'] as String?,
      longitude: (json['longitude'] as num?)?.toDouble(),
      latitude: (json['latitude'] as num?)?.toDouble(),
      isVerified: json['isVerified'] as bool?,
      isDeleted: json['isDeleted'] as bool?,
      isLogin: json['isLogin'] as bool?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      v: json['__v'] as int?,
      barberDetails: json['barberDetails'] != null
          ? BarberDetails.fromJson(json['barberDetails'])
          : null,
      minPrice: (json['minPrice'] as num?)?.toDouble(),
      maxPrice: (json['maxPrice'] as num?)?.toDouble(),
      location: json['location'] != null
          ? Location.fromJson(json['location'])
          : null,
    );
  }
}

class BarberDetails {
  final bool? isOpen;
  final String? id;
  final String? userId;
  final String? residencePath;
  final String? healthCertificate;
  final String? barberCover;
  final int? rating;
  final int? reviewCount;
  final String? status;

  BarberDetails({
    this.isOpen,
    this.id,
    this.userId,
    this.residencePath,
    this.healthCertificate,
    this.barberCover,
    this.rating,
    this.reviewCount,
    this.status,
  });

  factory BarberDetails.fromJson(Map<String, dynamic> json) {
    return BarberDetails(
      isOpen: json['isOpen'] as bool?,
      id: json['_id'] as String?,
      userId: json['userId'] as String?,
      residencePath: json['residencePath'] as String?,
      healthCertificate: json['healthCertificate'] as String?,
      barberCover: json['barberCover'] as String?,
      rating: json['rating'] as int?,
      reviewCount: json['reviewCount'] as int?,
      status: json['status'] as String?,
    );
  }
}

class Location {
  final String? type;
  final List<double>? coordinates;

  Location({this.type, this.coordinates});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      type: json['type'] as String?,
      coordinates: (json['coordinates'] as List<double>?)?.map((e) => e.toDouble()).toList(),
    );
  }
}
