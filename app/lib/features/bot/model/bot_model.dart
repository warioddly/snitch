import 'package:snitch/shared/model/base_model_interface.dart';


class BotModel extends IBaseModel {


  BotModel({
    this.id,
    required this.name,
    required this.description,
    required this.token,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.image,
  });


  final int? id;
  final String name;
  final String description;
  final String? image;
  final String token;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;


  factory BotModel.fromJson(Map<String, dynamic> data) {
    return BotModel(
      id: data['id'],
      name: data['name'],
      description: data['description'],
      image: data['image'],
      token: data['token'],
      status: data['status'],
      createdAt: DateTime.parse(data['createdAt']),
      updatedAt: DateTime.parse(data['updatedAt'])
    );
  }


  @override
  toJson() {
    return {
      if (id != null) ...{
        'id': id,
      },
      'name': name,
      'description': description,
      'image': image,
      'token': token,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String()
    };
  }


  copyWith({
    int? id,
    String? name,
    String? description,
    String? image,
    String? token,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt
  }) {
    return BotModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      image: image ?? this.image,
      token: token ?? this.token,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt
    );
  }

}