import 'dart:async';

import 'package:snitch/snitch.dart';
import 'package:snitch/src/adapters/console_output_adapter.dart';
import 'package:snitch/src/adapters/file_output_adapter.dart';
import 'package:snitch/src/formatters/_format_patterns.dart';
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

void main() async {
  final fileOutputAdapter = FileOutputAdapter(
    "logs.txt",
    filter: (Level level) => level is ErrorLevel || level is FatalLevel,
  );

  // final remoteOutputAdapter = RemoteOutputAdapter(
  //   filter: (Level level) =>
  //       level.level >= VerboseLevel.value && level.level <= WarningLevel.value,
  // );

  var snitch = Snitch(
    maxLogs: 20,
    adapters: <OutputAdapter>[
      ConsoleOutputAdapter(
        formatter: ConsoleOutputFormatter(
          timeFormatter: (time) => time.formatTimeWithMicroseconds(),
          patterns: {
            ...defaultConsolePatterns,
            FatalLevel: '${AnsiColors.bgBrightRed}{level}${AnsiColors.reset} [{message}]',
          },
        ),
      ),
      fileOutputAdapter,
      // remoteOutputAdapter,
    ],
  );

  var subscription = snitch.stream().listen(
    (data) => print('Получено: $data'),
    onError: print,
    onDone: () => print('Поток закрыт'),
  );

  runZoned(
    () async {
      print('hello print!');

      snitch
        ..t("message")
        ..i("info")
        ..w("warning")
        ..f("error")
        ..d("debug")
        ..v("verbose");

      await delay();
      snitch.e("1", stackTrace: StackTrace.current);
      snitch.f("2");

      await snitch.closeStream();
      await subscription.cancel();

      await delay();
      snitch.e("2");
      await delay();

      await delay();
      snitch.i("3");
      snitch.f("1");

      await delay();
      snitch.e("4");

      await delay();
      snitch.e("5");

      snitch.e(
        UnimplementedError("Oops, something went wrong").toString(),
        stackTrace: StackTrace.current,
      );
    },
    zoneSpecification: ZoneSpecification(
      print: (Zone self, ZoneDelegate parent, Zone zone, line) {
        snitch.i(line);
      },
    ),
  );

  await fileOutputAdapter.close();

  print('snitch.logs ${snitch.logs.length}');
}

Future<void> delay() => Future.delayed(Duration(seconds: 1));

class FatalLevel extends Level {
  const FatalLevel()
    : super(level: 101, name: 'FATAL', description: 'Fatal Level');
}

extension on Snitch {
  void f(String message) => log(message, level: const FatalLevel());
}
