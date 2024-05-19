import 'package:snitch/shared/model/base_model_interface.dart';


class BotModel implements BaseModel {


  const BotModel({
    required this.name,
    required this.description,
    this.image,
    required this.token,
    required this.status,
    required this.updatedAt
  });


  final String name;
  final String description;
  final String? image;
  final String token;
  final String status;
  final DateTime updatedAt;


  @override
  String get table => 'bot';

}