

import 'package:snitch/shared/model/base_model_interface.dart';

class UserConfigModel extends IBaseModel {


  const UserConfigModel({required super.id, required this.name, required this.token, required this.guildId});


  final String name;
  final String token;
  final int guildId;


  factory UserConfigModel.fromJson(Map<String, dynamic> json) {
    return UserConfigModel(
      id: json['id'],
      name: json['name'],
      token: json['token'],
      guildId: json['guildId'],
    );
  }


  UserConfigModel copyWith({int? id, String? name, String? token, int? guildId}) {
    return UserConfigModel(
      id: id ?? this.id,
      name: name ?? this.name,
      token: token ?? this.token,
      guildId: guildId ?? this.guildId,
    );
  }


  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'token': token,
      'guildId': guildId,
    };
  }


  @override
  List<Object?> get props => [
    id,
    name,
    token,
    guildId,
  ];


}