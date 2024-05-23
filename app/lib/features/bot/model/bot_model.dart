import 'package:snitch/shared/model/base_model_interface.dart';


class BotModel extends IBaseModel {


  const BotModel({
    super.id,
    required this.name,
    required this.description,
    required this.token,
    required this.createdAt,
    required this.updatedAt,
    this.image,
  });


  final String name;
  final String description;
  final String? image;
  final String token;
  final DateTime createdAt;
  final DateTime updatedAt;


  factory BotModel.fromJson(Map<String, dynamic> data) {
    return BotModel(
      id: data['id'],
      name: data['name'],
      description: data['description'],
      image: data['image'],
      token: data['token'] ?? '',
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
    DateTime? createdAt,
    DateTime? updatedAt
  }) {
    return BotModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      image: image ?? this.image,
      token: token ?? this.token,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt
    );
  }

}