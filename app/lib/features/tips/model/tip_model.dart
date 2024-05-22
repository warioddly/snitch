import 'package:flutter/cupertino.dart';
import 'package:snitch/shared/model/base_model_interface.dart';


enum TipCategory {
  guide,
  feature,
  other,
  faq;
}


TipCategory _getCategory(String category) {
  return switch(category) {
    "learn"   => TipCategory.guide,
    "feature" => TipCategory.feature,
    "faq"     => TipCategory.faq,
    _         => TipCategory.other,
  };
}


class TipModel extends IBaseModel {


  const TipModel({
    super.id,
    this.icon = CupertinoIcons.flame,
    required this.title,
    required this.description,
    required this.category,
    required this.markdown
  });


  final IconData icon;
  final String title;
  final String description;
  final String markdown;
  final TipCategory category;


  factory TipModel.fromJson(Map<String, dynamic> data) {
    return TipModel(
      icon: data["icon"] ?? "",
      title: data["title"] ?? "",
      description: data["description"] ?? "",
      category: _getCategory(data["category"]),
      markdown: data["markdown"]
    );
  }


  @override
  toJson() {
    return {
      if (id != null) ...{
        'id': id,
      },
      "icon": icon,
      "title": title,
      "description": description,
      "markdown": markdown,
      "category": category.toString(),
    };
  }

  @override
  List<Object?> get props => [id, icon, title, description, markdown, category];


}