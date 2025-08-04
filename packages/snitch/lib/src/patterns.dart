import 'package:snitch/src/ansi_colors.dart';
import 'package:snitch/src/level.dart';

const defaultPattern = '[{name}] [{time}] {message}';

const defaultConsolePatterns = {
  ErrorLevel: '${AnsiColors.red}[{name}] ${AnsiColors.brightBlack}[{time}] ${AnsiColors.red}{message}${AnsiColors.reset}',
  WarningLevel: '${AnsiColors.yellow}[{name}] ${AnsiColors.brightBlack}[{time}] ${AnsiColors.yellow}{message}${AnsiColors.reset}',
  InfoLevel: '${AnsiColors.blue}[{name}] ${AnsiColors.brightBlack}[{time}] ${AnsiColors.blue}{message}${AnsiColors.reset}',
  DebugLevel: '${AnsiColors.blue}[{name}] ${AnsiColors.brightBlack}[{time}]${AnsiColors.reset} {message}${AnsiColors.reset}',
  TraceLevel: '${AnsiColors.brightBlack}[{name}] ${AnsiColors.brightBlack}[{time}]${AnsiColors.reset} {message}${AnsiColors.reset}',
  VerboseLevel: '${AnsiColors.brightWhite}[{name}] ${AnsiColors.brightBlack}[{time}]${AnsiColors.reset} {message}${AnsiColors.reset}',
};
