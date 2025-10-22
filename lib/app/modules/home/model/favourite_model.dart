

// Main Model (wraps the entire response, nullable)
class FavoriteBarbersModel {
  bool? success;
  int? status;
  String? message;
  List<FavoriteBarber?>? data;

  FavoriteBarbersModel({
    this.success,
    this.status,
    this.message,
    this.data,
  });

  factory FavoriteBarbersModel.fromJson(Map<String, dynamic> json) {
    var list = json['data'] as List?;
    List<FavoriteBarber?>? dataList = list?.map((i) => FavoriteBarber.fromJson(i)).toList();

    return FavoriteBarbersModel(
      success: json['success'],
      status: json['status'],
      message: json['message'],
      data: dataList,
    );
  }
}

// FavoriteBarber model (nullable)
class FavoriteBarber {
  String? id;
  String? customerId;
  Barber? barberId;
  int? version;

  FavoriteBarber({
    this.id,
    this.customerId,
    this.barberId,
    this.version,
  });

  factory FavoriteBarber.fromJson(Map<String, dynamic> json) {
    return FavoriteBarber(
      id: json['_id'],
      customerId: json['customerId'],
      barberId: json['barberId'] != null ? Barber.fromJson(json['barberId']) : null,
      version: json['__v'],
    );
  }
}

// Barber model (nullable)
class Barber {
  String? id;
  User? userId;
  double? rating;
  int? reviewCount;
  bool? isOpen;
  String? status;
  double? minPrice;
  double? maxPrice;

  Barber({
    this.id,
    this.userId,
    this.rating,
    this.reviewCount,
    this.isOpen,
    this.status,
    this.minPrice,
    this.maxPrice,
  });

  factory Barber.fromJson(Map<String, dynamic> json) {
    return Barber(
      id: json['_id'],
      userId: json['userId'] != null ? User.fromJson(json['userId']) : null,
      rating: json['rating']?.toDouble(),
      reviewCount: json['reviewCount'],
      isOpen: json['isOpen'],
      status: json['status'],
      minPrice: json['minPrice']?.toDouble(),
      maxPrice: json['maxPrice']?.toDouble(),
    );
  }
}



// User model (nullable)
class User {
  String? id;
  String? name;
  String? image;
  String? role;
  bool? isLogin;
  int? version;

  User({
    this.id,
    this.name,
    this.image,
    this.role,
    this.isLogin,
    this.version,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      name: json['name'],
      image: json['image'],
      role: json['role'],
      isLogin: json['isLogin'],
      version: json['__v'],
    );
  }
}




