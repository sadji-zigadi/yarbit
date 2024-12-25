import '../../../../core/utils/model_structure.dart';
import '../../../../core/utils/string_extensions.dart';

import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import '../../domain/entities/client_entity.dart';

part 'client_model.g.dart';

@HiveType(typeId: 1)
class ClientModel extends ClientEntity with ModelStructure<ClientEntity> {
  ClientModel({
    required super.id,
    required super.email,
    required super.name,
    super.address,
    super.phoneNum,
    super.pictureUrl,
  });

  factory ClientModel.withId({
    required String email,
    required String name,
    required Map<String, dynamic> address,
    required String phoneNum,
    required String pictureUrl,
  }) {
    final String id = const Uuid().v1();
    return ClientModel(
      id: id,
      email: email,
      name: name,
    );
  }

  @override
  ClientModel copyWith({
    String? id,
    String? email,
    String? name,
    Map<String, dynamic>? address,
    String? phoneNum,
    String? pictureUrl,
  }) {
    return ClientModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      address: address ?? this.address,
      phoneNum: phoneNum ?? this.phoneNum,
      pictureUrl: pictureUrl ?? this.pictureUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'address': address,
      'phone number': phoneNum,
      'picture url': pictureUrl,
    };
  }

  factory ClientModel.fromMap({
    required Map<String, dynamic> map,
  }) {
    map['wilaya'] = WilayaParsing.deserialize(map['address']['wilaya']);
    return ClientModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      address: map['address'],
      phoneNum: map['phone number'],
      pictureUrl: map['picture url'],
    );
  }

  @override
  ClientEntity mapToEntity() {
    return ClientEntity(
      id: id,
      email: email,
      name: name,
    );
  }

  @override
  String toString() {
    return 'Client(id: $id, name: $name, email: $email, address: $address, phone number: $phoneNum, picture url: $pictureUrl)';
  }
}
