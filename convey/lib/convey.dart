import 'dart:io';
import 'package:convey/core/services/locator.dart';
import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';


Future<void> runConvey() async {
  print('Running the app...');

  await setupLocator();

  ProcessResult results =  await Process.run('cmd.exe', ['ipconfig']);

  var BOT_TOKEN = '7021758078:AAH1GzauHADSqHl1jiwAPDpGeRvBUse6-yQ';
  final username = (await Telegram(BOT_TOKEN).getMe()).username;
  var teledart = TeleDart(BOT_TOKEN, Event(username!));

  teledart.start();

  print('App is running... $username');

  // Long way
  teledart.onMessage(entityType: 'bot_command', keyword: 'start')
      .listen((message) => teledart.sendMessage(message.chat.id, 'Hello TeleDart!'));

  teledart.onCommand('glory')
      .listen((message) => message.reply('to Ukraine!'));

}