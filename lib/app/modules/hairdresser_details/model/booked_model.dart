// booked_model.dart

class BookedModel {
  final bool? success;
  final int? status;
  final String? message;
  final List<BookedData>? data;

  BookedModel({
    this.success,
    this.status,
    this.message,
    this.data,
  });

  factory BookedModel.fromJson(Map<String, dynamic> json) {
    return BookedModel(
      success: json['success'] as bool?,
      status: json['status'] as int?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => BookedData.fromJson(e))
          .toList(),
    );
  }
}

class BookedData {
  final String? date;
  final String? time;
  final String? status;
  final String? bookingGroupId;

  BookedData({
    this.date,
    this.time,
    this.status,
    this.bookingGroupId,
  });

  factory BookedData.fromJson(Map<String, dynamic> json) {
    return BookedData(
      date: json['date'] as String?,
      time: json['time'] as String?,
      status: json['status'] as String?,
      bookingGroupId: json['bookingGroupId'] as String?,
    );
  }
}
