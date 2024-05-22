import 'dart:async';
import 'package:discord/discord.dart';
import 'package:nyxx/nyxx.dart';

class DiscordValidate {


  const DiscordValidate();


  Future<DiscordStatus> checkToken(String token) async {
      try {
        final response = await _checkToken(token);
        return response.$1;
      }
      catch (e) {
        return DiscordUnknownStatus(message: e);
      }
  }


  Future<(DiscordStatus, NyxxGateway? client)> _checkToken(String token) async {

      try {

        if (token.isEmpty) {
          return (DiscordEmptyTokenStatus(), null);
        }

        final client = await Nyxx.connectGateway(token, GatewayIntents.all);

        return (DiscordTokenSuccessStatus(), client);
      }
      on NyxxException catch (_) {
        return (DiscordTokenInvalidStatus(), null);
      }
      catch (e) {
        return (DiscordUnknownStatus(message: e), null);
      }

  }


  Future<DiscordStatus> check(String token, int guildId) async {
      try {

        final tokenStatus = await _checkToken(token);

        if (tokenStatus.$1 is! DiscordTokenSuccessStatus) {
          return tokenStatus.$1;
        }

        await tokenStatus.$2?.guilds.fetch(Snowflake(guildId));

        return DiscordTokenSuccessStatus();
      }
      on NyxxException catch (_) {
        return DiscordGuildNotFoundStatus();
      }
      catch (e) {
        return DiscordUnknownStatus(message: e);
      }
  }

}