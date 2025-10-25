class ServicesModel {
  final bool success;
  final int status;
  final String message;
  final ServicesData data;

  ServicesModel({
    required this.success,
    required this.status,
    required this.message,
    required this.data,
  });

  factory ServicesModel.fromJson(Map<String, dynamic> json) {
    return ServicesModel(
      success: json['success'] ?? false,
      status: json['status'] ?? 0,
      message: json['message'] ?? '',
      data: ServicesData.fromJson(json['data'] ?? {}),
    );
  }
}

class ServicesData {
  final List<Service> services;

  ServicesData({required this.services});

  factory ServicesData.fromJson(Map<String, dynamic> json) {
    return ServicesData(
      services: (json['services'] as List<dynamic>? ?? [])
          .map((item) => Service.fromJson(item))
          .toList(),
    );
  }
}

class Service {
  final String id;
  final String barberId;
  final String serviceName;
  final String serviceImage;
  final int price;
  final String description;
  final int v;

  Service({
    required this.id,
    required this.barberId,
    required this.serviceName,
    required this.serviceImage,
    required this.price,
    required this.description,
    required this.v,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['_id'] ?? '',
      barberId: json['barberId'] ?? '',
      serviceName: json['serviceName'] ?? '',
      serviceImage: json['serviceImage'] ?? '',
      price: json['price'] ?? 0,
      description: json['description'] ?? '',
      v: json['__v'] ?? 0,
    );
  }
}
