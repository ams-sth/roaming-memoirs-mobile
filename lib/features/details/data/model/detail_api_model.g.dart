// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetailApiModel _$DetailApiModelFromJson(Map<String, dynamic> json) =>
    DetailApiModel(
      image: json['image'] as String?,
      user: UserEntity.fromJson(json['user'] as Map<String, dynamic>),
      tripId: json['_id'] as String?,
      tripName: json['tripName'] as String?,
      description: json['description'] as String?,
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
    );

Map<String, dynamic> _$DetailApiModelToJson(DetailApiModel instance) =>
    <String, dynamic>{
      '_id': instance.tripId,
      'image': instance.image,
      'user': instance.user,
      'tripName': instance.tripName,
      'description': instance.description,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
    };
