import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:travel_log/config/constants/hive_table_constant.dart';
import 'package:travel_log/features/details/domain/entity/detail_entity.dart';
import 'package:uuid/uuid.dart';

import '../../../auth/domain/entity/user_entity.dart';

part 'detail_hive_model.g.dart';

final detailHiveModelProvider = Provider(
  (ref) => DetailHiveModel.empty(),
);

@HiveType(typeId: HiveTableConstant.detailTableId)
class DetailHiveModel {
  @HiveField(0)
  final String tripId;

  @HiveField(1)
  final String tripName;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final String startDate;

  @HiveField(4)
  final String endDate;

  @HiveField(5)
  final UserEntity user;

  DetailHiveModel({
    String? tripId,
    required this.user,
    required this.tripName,
    required this.description,
    required this.startDate,
    required this.endDate,
  }) : tripId = tripId ?? const Uuid().v4();

  DetailHiveModel.empty()
      : this(
          tripId: '',
          user: UserEntity(
            username: '',
            image: '',
            phone: '',
            email: '',
            password: '',
          ),
          tripName: '',
          description: '',
          startDate: '',
          endDate: '',
        );

  DetailEntity toEntity() => DetailEntity(
        tripId: tripId,
        user: user,
        tripName: tripName,
        description: description,
        startDate: startDate,
        endDate: endDate,
      );

  DetailHiveModel toHiveModel(DetailEntity entity) => DetailHiveModel(
        // username: username,
        tripName: entity.tripName,
        user: UserEntity(
          username: entity.user.username,
          image: entity.user.image,
          email: '',
          password: '',
          phone: '',
        ),
        description: entity.description ?? '',
        startDate: entity.startDate,
        endDate: entity.endDate,
      );

  // List<DetailHiveModel> toHiveModelList(List<DetailEntity> details) =>
  //     details.map((entity) => toHiveModel(entity)).toList();

  List<DetailEntity> toEntityList(List<DetailHiveModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  String toString() {
    return ' tripName: $tripName, description:$description, startDate:$startDate, endDate:$endDate';
  }
}
