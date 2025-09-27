// Service Item Model
class ServiceItem {
  final String id;
  final String imagePath;
  final String title;
  final String subtitle;
  final String status;
  final String priceRange;
  final bool isActive;

  ServiceItem({
    required this.id,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.status,
    required this.priceRange,
    required this.isActive,
  });

  ServiceItem copyWith({
    String? id,
    String? imagePath,
    String? title,
    String? subtitle,
    String? status,
    String? priceRange,
    bool? isActive,
  }) {
    return ServiceItem(
      id: id ?? this.id,
      imagePath: imagePath ?? this.imagePath,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      status: status ?? this.status,
      priceRange: priceRange ?? this.priceRange,
      isActive: isActive ?? this.isActive,
    );
  }
}

