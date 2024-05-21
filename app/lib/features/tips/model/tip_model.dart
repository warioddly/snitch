


import 'package:snitch/shared/model/base_model_interface.dart';

class TipModel implements IBaseModel {

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
  toJson() {
    return {
      "title": title,
      "description": description
    };
  }

  @override
  String get table => 'tips';

}