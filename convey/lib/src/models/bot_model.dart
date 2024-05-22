

class BotModel {

  const BotModel({
    required this.id,
    required this.name,
    required this.token,
    required this.description,
    required this.owner,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String name;
  final String token;
  final String? owner;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory BotModel.fromJson(Map<String, dynamic> data) {
    try {
      print(data);
      return BotModel(
          id: data['id'],
          name: data['name'] ?? 'Bot',
          owner: data['owner'] ?? 'Owner',
          description: data['description'],
          token: data['token'],
          createdAt: DateTime.parse(data['createdAt']),
          updatedAt: DateTime.parse(data['updatedAt'])
      );
    }
    catch (e) {
      throw Exception('Error parsing BotModel: $e');
    }
  }

  toJson() {
    return {
      'id': id,
      'name': name,
      'owner': owner,
      'token': token,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

}
