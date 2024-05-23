

import 'package:snitch/shared/model/base_model_interface.dart';

class DiscordUserModel extends IBaseModel {

  const DiscordUserModel({super.id, required this.name, this.avatar});

  final String name;
  final String? avatar;


  factory DiscordUserModel.fromJson(Map<String, dynamic> data) {
    return DiscordUserModel(
        id: data["id"],
        name: data["name"],
        avatar: data["avatar"]
    );
  }
  

  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null)
        "id": id,
      "name": name,
      "avatar": avatar,
    };
  }


}