// notification_model.dart

import 'dart:ffi';

class NotificationModel {
  final bool? success;
  final int? status;
  final String? message;
  final NotificationData? data;

  NotificationModel({this.success, this.status, this.message, this.data});

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      success: json['success'] as bool?,
      status: json['status'] as int?,
      message: json['message'] as String?,
      data: json['data'] != null
          ? NotificationData.fromJson(json['data'])
          : null,
    );
  }
}

class NotificationData {
  final UserInfo? userInfo;
  final List<NotificationItems>? notifications;
  final Pagination? pagination;

  NotificationData({this.userInfo, this.notifications, this.pagination});

  factory NotificationData.fromJson(Map<String, dynamic> json) {
    return NotificationData(
      userInfo: json['userInfo'] != null
          ? UserInfo.fromJson(json['userInfo'])
          : null,
      notifications: (json['notifications'] as List<dynamic>?)
          ?.map((e) => NotificationItems.fromJson(e))
          .toList(),
      pagination: json['pagination'] != null
          ? Pagination.fromJson(json['pagination'])
          : null,
    );
  }
}

class UserInfo {
  final String? id;
  final String? name;
  final String? image;
  final String? email;

  UserInfo({this.id, this.name, this.image, this.email});

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      image: json['image'] as String?,
      email: json['email'] as String?,
    );
  }
}

class NotificationItems {
  final String? id;
  final String? customerName;
  final String? barberName;
  final int? quantity;
  final String? msg;
        String? status;
  final String? bookingId;
  final bool isUnread;
  final String? createdAt;
  final String? updatedAt;

  NotificationItems({
    this.id,
    this.customerName,
    this.barberName,
    this.quantity,
    this.msg,
    this.isUnread = false,
    this.status,
    this.bookingId,
    this.createdAt,
    this.updatedAt,
  });

  factory NotificationItems.fromJson(Map<String, dynamic> json) {
    return NotificationItems(
      id: json['_id'] as String?,
      customerName : json['customerName'] as String?,
      barberName: json['barberName'] as String?,
      isUnread: json['isReadable'] as bool? ?? false,
      quantity : json['quantity'] as int?,
      msg: json['msg'] as String?,
      status: json['status'] as String?,
      bookingId: json['bookingId'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );
  }
}

class Pagination {
  final int? totalPage;
  final int? currentPage;
  final int? prevPage;
  final int? nextPage;
  final int? totalData;

  Pagination({
    this.totalPage,
    this.currentPage,
    this.prevPage,
    this.nextPage,
    this.totalData,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      totalPage: json['totalPage'] as int?,
      currentPage: json['currentPage'] as int?,
      prevPage: json['prevPage'] as int?,
      nextPage: json['nextPage'] as int?,
      totalData: json['totalData'] as int?,
    );
  }
}
