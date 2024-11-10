import '../../../auth/domain/entity/user_entity.dart';

class DetailEntity {
  final String? tripId;
  final UserEntity user;
  final String? image;
  final String tripName;
  final String? description;
  final String startDate;
  final String endDate;

  DetailEntity({
    this.image,
    required this.user,
    required this.tripName,
    required this.description,
    required this.startDate,
    required this.endDate,
    this.tripId,
  });

  factory DetailEntity.fromJson(Map<String, dynamic> json) => DetailEntity(
        tripId: json["tripId"],
        user: UserEntity.fromJson(json["user"]),
        image: json["image"],
        tripName: json["tripName"],
        description: json["description"],
        startDate: json["startDate"],
        endDate: json["endDate"],
      );

  Map<String, dynamic> toJson() => {
        "tripId": tripId,
        "user": user.toJson(),
        'image': image,
        'tripName': tripName,
        'description': description,
        'startDate': startDate,
        'endDate': endDate
      };

  @override
  String toString() {
    return '$tripName, $description $image $startDate $endDate';
  }
}
