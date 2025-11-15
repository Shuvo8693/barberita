// notification_model.dart

class NotificationModel {
  final bool? success;
  final int? status;
  final String? message;
  final NotificationData? data;

  NotificationModel({
    this.success,
    this.status,
    this.message,
    this.data,
  });

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
  final List<NotificationItem>? notifications;
  final Pagination? pagination;

  NotificationData({
    this.userInfo,
    this.notifications,
    this.pagination,
  });

  factory NotificationData.fromJson(Map<String, dynamic> json) {
    return NotificationData(
      userInfo: json['userInfo'] != null
          ? UserInfo.fromJson(json['userInfo'])
          : null,
      notifications: (json['notifications'] as List<dynamic>?)
          ?.map((e) => NotificationItem.fromJson(e))
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

  UserInfo({
    this.id,
    this.name,
    this.image,
    this.email,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      image: json['image'] as String?,
      email: json['email'] as String?,
    );
  }
}

class NotificationItem {
  final String? id;
  final String? msg;
  final String? status;
  final String? bookingId;
  final String? createdAt;
  final String? updatedAt;

  NotificationItem({
    this.id,
    this.msg,
    this.status,
    this.bookingId,
    this.createdAt,
    this.updatedAt,
  });

  factory NotificationItem.fromJson(Map<String, dynamic> json) {
    return NotificationItem(
      id: json['_id'] as String?,
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
