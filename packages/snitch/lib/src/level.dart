
abstract class Level {
  final int level;
  final String name;

  const Level({required this.level, required this.name});

  @override
  String toString() {
    return 'Level(level: $level, name: $name)';
  }

  Map<String, dynamic> toJson() {
    return {
      'level': level,
      'name': name,
    };
  }
}

class ErrorLevel extends Level {
  static const int value = 1000;

  const ErrorLevel() : super(level: value, name: "ERROR");
}

class WarningLevel extends Level {
  static const int value = 900;

  const WarningLevel() : super(level: value, name: "WARNING");
}

class VerboseLevel extends Level {
  static const int value = 500;

  const VerboseLevel() : super(level: value, name: "VERBOSE");
}

class DebugLevel extends Level {
  static const int value = 400;

  const DebugLevel() : super(level: value, name: "DEBUG");
}

class TraceLevel extends Level {
  static const int value = 200;

  const TraceLevel() : super(level: value, name: "TRACE");
}

class InfoLevel extends Level {
  static const int value = 100;

  const InfoLevel() : super(level: value, name: "INFO");
}
