class BarberTopRatedModel {
  final bool? success;
  final String? message;
  final List<BarberTopRated>? barberList;

  BarberTopRatedModel({
     this.success,
     this.message,
     this.barberList,
  });

  // Factory constructor to parse the JSON response
  factory BarberTopRatedModel.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List;
    List<BarberTopRated> barberList = list.map((i) => BarberTopRated.fromJson(i)).toList();

    return BarberTopRatedModel(
      success: json['success'],
      message: json['message'],
      barberList: barberList,
    );
  }
}

class BarberTopRated {
  final String barberId;
  final String name;
  final String phone;
  final String? image; // Nullable
  final String? coverPicture; // Nullable
  final String residencePath;
  final String healthCertificate;
  final double averageRating;
  final int reviewCount;
  final bool isOpen;
  final double minPrice;
  final double maxPrice;

  BarberTopRated({
    required this.barberId,
    required this.name,
    required this.phone,
    this.image, // Nullable
    this.coverPicture, // Nullable
    required this.residencePath,
    required this.healthCertificate,
    required this.averageRating,
    required this.reviewCount,
    required this.isOpen,
    required this.minPrice,
    required this.maxPrice,
  });

  // Factory constructor to parse the JSON response
  factory BarberTopRated.fromJson(Map<String, dynamic> json) {
    return BarberTopRated(
      barberId: json['barberId'],
      name: json['name'],
      phone: json['phone'],
      image: json['image'], // Nullable
      coverPicture: json['coverPicture'], // Nullable
      residencePath: json['residencePath'],
      healthCertificate: json['healthCertificate'],
      averageRating: (json['averageRating'] ?? 0).toDouble(), // Null check and conversion to double
      reviewCount: json['reviewCount'] ?? 0, // Null check
      isOpen: json['isOpen'] ?? false, // Null check
      minPrice: (json['minPrice'] ?? 0).toDouble(), // Null check and conversion to double
      maxPrice: (json['maxPrice'] ?? 0).toDouble(), // Null check and conversion to double
    );
  }
}
