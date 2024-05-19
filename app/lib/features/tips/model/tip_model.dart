


import 'package:snitch/shared/model/base_model_interface.dart';

class TipModel implements BaseModel {

  const TipModel({required this.title, required this.description});

  final String title;
  final String description;

  factory TipModel.fromJson(Map<String, dynamic> data) {
    return TipModel(
      title: data["title"] ?? "",
      description: data["description"] ?? ""
    );
  }

  @override
  String get table => "tips";

}