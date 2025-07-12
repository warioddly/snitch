import 'package:snitch/src/utils/ansi_colors.dart';
import 'package:snitch/src/levels/level.dart';

const defaultPattern = '[{level}] [{time}] {message}';

const defaultConsolePatterns = {
  ErrorLevel: '${AnsiColors.red}[{level}] ${AnsiColors.brightBlack}[{time}] ${AnsiColors.red}{message}${AnsiColors.reset}',
  WarningLevel: '${AnsiColors.yellow}[{level}] ${AnsiColors.brightBlack}[{time}] ${AnsiColors.yellow}{message}${AnsiColors.reset}',
  InfoLevel: '${AnsiColors.blue}[{level}] ${AnsiColors.brightBlack}[{time}] ${AnsiColors.blue}{message}${AnsiColors.reset}',
  DebugLevel: '${AnsiColors.blue}[{level}] ${AnsiColors.brightBlack}[{time}]${AnsiColors.reset} {message}${AnsiColors.reset}',
  TraceLevel: '${AnsiColors.brightBlack}[{level}] ${AnsiColors.brightBlack}[{time}]${AnsiColors.reset} {message}${AnsiColors.reset}',
  VerboseLevel: '${AnsiColors.brightWhite}[{level}] ${AnsiColors.brightBlack}[{time}]${AnsiColors.reset} {message}${AnsiColors.reset}',
};
