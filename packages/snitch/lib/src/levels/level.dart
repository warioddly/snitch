abstract class Level {
  final int level;
  final String name;
  final String description;

  const Level({
    required this.level,
    required this.name,
    required this.description,
  });

  @override
  String toString() {
    return 'Level(level: $level, name: $name, description: $description)';
  }
}

class ErrorLevel extends Level {
  static const int value = 1000;

  const ErrorLevel()
    : super(level: value, name: "ERROR", description: "Error level");
}

class WarningLevel extends Level {
  static const int value = 900;

  const WarningLevel()
    : super(level: value, name: "WARNING", description: "Warning level");
}

class VerboseLevel extends Level {
  static const int value = 500;

  const VerboseLevel()
    : super(level: value, name: "VERBOSE", description: "Verbose level");
}

class DebugLevel extends Level {
  static const int value = 400;

  const DebugLevel()
    : super(level: value, name: "DEBUG", description: "Debug level");
}

class TraceLevel extends Level {
  static const int value = 200;

  const TraceLevel()
    : super(level: value, name: "TRACE", description: "Trace level");
}

class InfoLevel extends Level {
  static const int value = 100;

  const InfoLevel()
    : super(level: value, name: "INFO", description: "Info level");
}
