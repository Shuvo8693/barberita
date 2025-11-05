// barber_added_service_model.dart

class BarberAddedServiceModel {
  final bool? success;
  final int? status;
  final String? message;
  final BarberAddedServiceData? data;

  BarberAddedServiceModel({
    this.success,
    this.status,
    this.message,
    this.data,
  });

  factory BarberAddedServiceModel.fromJson(Map<String, dynamic> json) {
    return BarberAddedServiceModel(
      success: json['success'] as bool?,
      status: json['status'] as int?,
      message: json['message'] as String?,
      data: json['data'] != null
          ? BarberAddedServiceData.fromJson(json['data'])
          : null,
    );
  }
}

class BarberAddedServiceData {
  final String? workingHours;
  final List<Service>? services;

  BarberAddedServiceData({
    this.workingHours,
    this.services,
  });

  factory BarberAddedServiceData.fromJson(Map<String, dynamic> json) {
    return BarberAddedServiceData(
      workingHours: json['workingHours'] as String?,
      services: (json['services'] as List<dynamic>?)
          ?.map((e) => Service.fromJson(e))
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
  final bool? active;

  Service({
    this.id,
    this.barberId,
    this.serviceName,
    this.serviceImage,
    this.price,
    this.description,
    this.v,
    this.active,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['_id'] as String?,
      barberId: json['barberId'] as String?,
      serviceName: json['serviceName'] as String?,
      serviceImage: json['serviceImage'] as String?,
      price: json['price'] as int?,
      description: json['description'] as String?,
      v: json['__v'] as int?,
      active: json['active'] as bool?,
    );
  }
}
