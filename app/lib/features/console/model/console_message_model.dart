import 'package:snitch/shared/model/base_model_interface.dart';

class ConsoleMessageModel extends IBaseModel {

  ConsoleMessageModel({
    required this.user,
    required this.content,
    required this.createdDate,
    required super.id
  });

  final bool user;
  final String content;
  final DateTime createdDate;

  factory ConsoleMessageModel.fromJson(Map<String, dynamic> data) {
    return ConsoleMessageModel(
        id: data["id"],
        user: data["user"] ?? true,
        content: data["command"] ?? "",
        createdDate: data["createdDate"] ? DateTime.parse(data["createdDate"]) : DateTime.now()
    );
  }


  @override
  Map<String, dynamic> toJson() {
    return {
      "user": user,
      "command": content,
      "createdDate": createdDate.toIso8601String(),
    };
  }


}