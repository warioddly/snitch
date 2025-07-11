

class Level {
  final int level;
  final String name;
  final String description;

  Level({
    required this.level,
    required this.name,
    required this.description,
  });

  @override
  String toString() {
    return 'Level(level: $level, name: $name, description: $description)';
  }
}