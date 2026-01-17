class ServiceResponseModel {
  final bool? success;
  final int? status;
  final String? message;
  final ServiceData? data;

  ServiceResponseModel({
    this.success,
    this.status,
    this.message,
    this.data,
  });

  factory ServiceResponseModel.fromJson(Map<String, dynamic> json) {
    return ServiceResponseModel(
      success: json['success'],
      status: json['status'],
      message: json['message'],
      data: json['data'] != null
          ? ServiceData.fromJson(json['data'])
          : null,
    );
  }
}

class ServiceData {
  final Service? service;

  ServiceData({this.service});

  factory ServiceData.fromJson(Map<String, dynamic> json) {
    return ServiceData(
      service: json['service'] != null
          ? Service.fromJson(json['service'])
          : null,
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
  final int? version;
  final bool? active;

  Service({
    this.id,
    this.barberId,
    this.serviceName,
    this.serviceImage,
    this.price,
    this.description,
    this.version,
    this.active,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['_id'],
      barberId: json['barberId'],
      serviceName: json['serviceName'],
      serviceImage: json['serviceImage'],
      price: json['price'],
      description: json['description'],
      version: json['__v'],
      active: json['active'],
    );
  }
}
