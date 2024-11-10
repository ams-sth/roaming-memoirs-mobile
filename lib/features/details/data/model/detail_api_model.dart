import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:travel_log/features/auth/domain/entity/user_entity.dart';
import 'package:travel_log/features/details/domain/entity/detail_entity.dart';

part 'detail_api_model.g.dart';

final detailApiModelProvider = Provider<DetailApiModel>(
  (ref) => DetailApiModel(
    tripId: '',
    tripName: '',
    description: '',
    startDate: '',
    endDate: '',
    user: UserEntity(
      username: '',
      image: '',
      phone: '',
      email: '',
      password: '',
    ),
  ),
);

@JsonSerializable()
class DetailApiModel {
  @JsonKey(name: '_id')
  final String? tripId;
  final String? image;
  final UserEntity user;
  final String? tripName;
  final String? description;
  final String? startDate;
  final String? endDate;

  DetailApiModel({
    this.image,
    required this.user,
    required this.tripId,
    required this.tripName,
    this.description,
    required this.startDate,
    required this.endDate,
  });

  Map<String, dynamic> toJson() => _$DetailApiModelToJson(this);

  factory DetailApiModel.fromJson(Map<String, dynamic> json) =>
      _$DetailApiModelFromJson(json);

  DetailEntity toEntity() => DetailEntity(
        image: image,
        tripId: tripId,
        user: user,
        tripName: tripName ?? '',
        description: description,
        startDate: startDate ?? '',
        endDate: endDate ?? '',
      );

  DetailApiModel fromEntity(DetailEntity entity) => DetailApiModel(
      image: entity.image,
      tripId: entity.tripId ?? '',
      user: UserEntity(
        username: entity.user.username,
        image: entity.user.image,
        email: '',
        password: '',
        phone: '',
      ),
      tripName: entity.tripName,
      description: entity.description ?? '',
      startDate: entity.startDate,
      endDate: entity.endDate);

  List<DetailEntity> toEntityList(List<DetailApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  List<DetailEntity> listFromJson(List<DetailApiModel> models) =>
      models.map((model) => model.toEntity()).toList();
}
