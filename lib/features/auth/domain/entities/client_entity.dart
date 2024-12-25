import 'package:client/core/utils/constants.dart';

import '../../../../core/utils/entity_structure.dart';

import '../../data/models/client_model.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

class ClientEntity extends Equatable
    with EntityStructure<ClientEntity, ClientModel> {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String email;

  @HiveField(2)
  final String name;

  @HiveField(3)
  final Map<String, dynamic>? address;

  @HiveField(4)
  final String? phoneNum;

  @HiveField(5)
  final String pictureUrl;

  ClientEntity({
    String? id,
    required this.email,
    required this.name,
    this.address,
    this.phoneNum,
    this.pictureUrl = Constants.defaultPic,
  }) : id = id ?? const Uuid().v1();

  @override
  ClientEntity copyWith({
    String? id,
    String? email,
    String? name,
    Map<String, dynamic>? address,
    String? phoneNum,
    String? pictureUrl,
  }) {
    return ClientEntity(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      address: address ?? this.address,
      phoneNum: phoneNum ?? this.phoneNum,
      pictureUrl: pictureUrl ?? this.pictureUrl,
    );
  }

  @override
  ClientModel mapToModel() {
    return ClientModel(
      id: id,
      email: email,
      name: name,
    );
  }

  @override
  List<Object?> get props => [
        id,
        email,
        name,
        address,
        phoneNum,
        pictureUrl,
      ];
}
