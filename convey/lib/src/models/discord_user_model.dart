
class DiscordUserModel {

  const DiscordUserModel({required this.id, required this.name, this.avatar});

  final int id;
  final String name;
  final String? avatar;


  factory DiscordUserModel.fromJson(Map<String, dynamic> data) {
    return DiscordUserModel(
        id: data["id"],
        name: data["name"],
        avatar: data["avatar"]
    );
  }
  

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "avatar": avatar,
    };
  }


}