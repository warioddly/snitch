



import 'package:snitch/shared/model/base_model_interface.dart';

class CommandModel extends IBaseModel {

  const CommandModel({required this.command, super.id});

  final String command;

  @override
  Map<String, dynamic> toJson() {
    return {
      'command': command,
    };
  }

  factory CommandModel.fromJson(Map<String, dynamic> json) {
    return CommandModel(
      command: json['command'],
    );
  }


  CommandModel copyWith({int? id, String? command}) {
    return CommandModel(
      id: id ?? this.id,
      command: command ?? this.command,
    );
  }

  @override
  List<Object?> get props => [id, command];

}