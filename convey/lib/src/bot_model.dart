

class BotModel {

  const BotModel({
    required this.id,
    required this.name,
    required this.description,
    required this.owner,
    required this.token,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  final int id;
  final String name;
  final String? owner;
  final String description;
  final String token;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory BotModel.fromJson(Map<String, dynamic> data) {
    try {
      return BotModel(
          id: data['id'],
          name: data['name'] ?? 'Bot',
          // TODO: user id
          owner: data['owner'] ?? 'Owner',
          description: data['description'],
          token: data['token'],
          status: data['status'],
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
      'description': description,
      'token': token,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

}
