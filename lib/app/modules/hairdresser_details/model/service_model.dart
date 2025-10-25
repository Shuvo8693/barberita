class ServicesModel {
  final bool? success;
  final int? status;
  final String? message;
  final ServicesData? data;

  ServicesModel({
    this.success,
    this.status,
    this.message,
    this.data,
  });

  factory ServicesModel.fromJson(Map<String, dynamic> json) {
    return ServicesModel(
      success: json['success'],
      status: json['status'],
      message: json['message'],
      data: json['data'] != null ? ServicesData.fromJson(json['data']) : null,
    );
  }
}

class ServicesData {
  final List<Service>? services;

  ServicesData({this.services});

  factory ServicesData.fromJson(Map<String, dynamic> json) {
    return ServicesData(
      services: (json['services'] as List<dynamic>?)
          ?.map((item) => Service.fromJson(item))
          .toList(),
    );
  }
}

class Service {
  final String? id;
  final String? barberId;
  final String? serviceName;
  final String? serviceImage;
  final int? price;
  final String? description;
  final int? v;

  Service({
    this.id,
    this.barberId,
    this.serviceName,
    this.serviceImage,
    this.price,
    this.description,
    this.v,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['_id'],
      barberId: json['barberId'],
      serviceName: json['serviceName'],
      serviceImage: json['serviceImage'],
      price: json['price'],
      description: json['description'],
      v: json['__v'],
    );
  }
}
