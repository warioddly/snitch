import 'dart:async';

import 'package:snitch/snitch.dart';
import 'package:snitch/src/adapters/console_output_adapter.dart';
import 'package:snitch/src/adapters/file_output_adapter.dart';
import 'package:snitch/src/formatters/_patterns.dart';
import 'package:snitch/src/formatters/console_output_formatter.dart';
import 'package:snitch/src/levels/level.dart';
import 'package:snitch/src/utils/ansi_colors.dart';

extension TimeFormatting on DateTime {
  String formatTimeWithMicroseconds() {
    final hour = toUtc().hour;
    final minute = this.minute;
    final second = this.second;
    final millisecond = this.millisecond;

    return '${_twoDigits(hour)}:'
        '${_twoDigits(minute)}:'
        '${_twoDigits(second)}.'
        '${_threeDigits(millisecond)}';
  }

  String _twoDigits(int n) => n.toString().padLeft(2, '0');

  String _threeDigits(int n) => n.toString().padLeft(3, '0');
}

Future<void> delay() => Future.delayed(Duration(milliseconds: 500));

class FatalLevel extends Level {
  const FatalLevel()
    : super(level: 101, name: 'FATAL', description: 'Fatal Level');
}

extension on Snitch {
  void f(String message) => log(message, level: const FatalLevel());
}

void main() async {
  final consoleAdapter = ConsoleOutputAdapter(
    formatter: ConsoleOutputFormatter(
      timeFormatter: (time) => time.formatTimeWithMicroseconds(),
      patterns: {
        ...defaultConsolePatterns,
        FatalLevel: '${AnsiColors.red}[ℹ️{level}]${AnsiColors.reset} {message}',
      },
    ),
  );

  final fileAdapter = FileOutputAdapter(
    "logs.txt",
    filter: (Level level) => level is ErrorLevel || level is FatalLevel,
  );

  // final remoteOutputAdapter = RemoteOutputAdapter(
  //   filter: (Level level) =>
  //       level.level >= VerboseLevel.value && level.level <= WarningLevel.value,
  // );

  final snitch = Snitch(maxLogs: 50, adapters: [consoleAdapter, fileAdapter]);

  final subscription = snitch.stream().listen(
    (log) => print('Stream event: $log'),
    onDone: () => print('Stream closed'),
  );

  await runZonedGuarded(
    () async {
      print('Application started');

      snitch
        ..t('Trace message')
        ..d('Debug message')
        ..i('Info message')
        ..w('Warning message')
        ..e('Error message', stackTrace: StackTrace.current)
        ..f('Fatal message');

      await delay();

      await snitch.closeStream();
      await subscription.cancel();

      await delay();

      print('This print is captured by Snitch too!');

      await delay();

      await fileAdapter.close();

      print('Done. Logs stored: ${snitch.logs.length}');
    },
    (error, stackTrace) {
      snitch.e('Unhandled error:', error: error, stackTrace: stackTrace);
    },
    zoneSpecification: ZoneSpecification(
      print: (self, parent, zone, line) {
        snitch.i(line);
      },
    ),
  );
}
