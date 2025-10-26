class BarberServicesModel {
  final bool? success;
  final int? status;
  final String? message;
  final BarberServicesData? data;

  BarberServicesModel({
    this.success,
    this.status,
    this.message,
    this.data,
  });

  factory BarberServicesModel.fromJson(Map<String, dynamic> json) {
    return BarberServicesModel(
      success: json['success'],
      status: json['status'],
      message: json['message'],
      data: json['data'] != null
          ? BarberServicesData.fromJson(json['data'])
          : null,
    );
  }
}

class BarberServicesData {
  final List<BarberService>? services;

  BarberServicesData({this.services});

  factory BarberServicesData.fromJson(Map<String, dynamic> json) {
    return BarberServicesData(
      services: (json['services'] as List<dynamic>?)
          ?.map((item) => BarberService.fromJson(item))
          .toList(),
    );
  }
}

class BarberService {
  final String? id;
  final String? barberId;
  final String? serviceName;
  final String? serviceImage;
  final int? price;
  final String? description;
  final int? v;

  BarberService({
    this.id,
    this.barberId,
    this.serviceName,
    this.serviceImage,
    this.price,
    this.description,
    this.v,
  });

  factory BarberService.fromJson(Map<String, dynamic> json) {
    return BarberService(
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
