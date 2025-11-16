// unread_and_latest_notifications_model.dart

class UnreadAndLatestNotificationModel {
  final bool? success;
  final int? status;
  final String? message;
  final UnreadLatestData? data;

  UnreadAndLatestNotificationModel({
    this.success,
    this.status,
    this.message,
    this.data,
  });

  factory UnreadAndLatestNotificationModel.fromJson(Map<String, dynamic> json) {
    return UnreadAndLatestNotificationModel(
      success: json['success'] as bool?,
      status: json['status'] as int?,
      message: json['message'] as String?,
      data: json['data'] != null
          ? UnreadLatestData.fromJson(json['data'])
          : null,
    );
  }
}

class UnreadLatestData {
  final UnreadLatestUserInfo? userInfo;
  final int? unreadCount;
  final List<UnreadLatestNotificationItem>? latestNotifications;

  UnreadLatestData({
    this.userInfo,
    this.unreadCount,
    this.latestNotifications,
  });

  factory UnreadLatestData.fromJson(Map<String, dynamic> json) {
    return UnreadLatestData(
      userInfo: json['userInfo'] != null
          ? UnreadLatestUserInfo.fromJson(json['userInfo'])
          : null,
      unreadCount: json['unreadCount'] as int?,
      latestNotifications: (json['latestNotifications'] as List<dynamic>?)
          ?.map((e) => UnreadLatestNotificationItem.fromJson(e))
          .toList(),
    );
  }
}

class UnreadLatestUserInfo {
  final String? id;
  final String? name;
  final String? phone;
  final String? image;

  UnreadLatestUserInfo({
    this.id,
    this.name,
    this.phone,
    this.image,
  });

  factory UnreadLatestUserInfo.fromJson(Map<String, dynamic> json) {
    return UnreadLatestUserInfo(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      image: json['image'] as String?,
    );
  }
}

class UnreadLatestNotificationItem {
  final String? msg;
  final String? createdAt;

  UnreadLatestNotificationItem({
    this.msg,
    this.createdAt,
  });

  factory UnreadLatestNotificationItem.fromJson(Map<String, dynamic> json) {
    return UnreadLatestNotificationItem(
      msg: json['msg'] as String?,
      createdAt: json['createdAt'] as String?,
    );
  }
}
