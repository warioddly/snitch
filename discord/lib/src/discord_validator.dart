import 'dart:async';
import 'package:nyxx/nyxx.dart';


sealed class DiscordValidatorStatus {
  const DiscordValidatorStatus();
}

final class DiscordValidatorStatusSuccess extends DiscordValidatorStatus {
  const DiscordValidatorStatusSuccess();
}

final class DiscordValidatorStatusTokenEmpty extends DiscordValidatorStatus {
  const DiscordValidatorStatusTokenEmpty();
}

final class DiscordValidatorStatusTokenInvalid extends DiscordValidatorStatus {
  const DiscordValidatorStatusTokenInvalid();
}

final class DiscordValidatorStatusGuildNotFound extends DiscordValidatorStatus {
  const DiscordValidatorStatusGuildNotFound();
}

final class DiscordValidatorStatusUnknownError extends DiscordValidatorStatus {
  const DiscordValidatorStatusUnknownError(this.message);
  final Object? message;
}

extension DiscordValidatorStatusError on DiscordValidatorStatus {
  String get message {
    if (this is DiscordValidatorStatusTokenEmpty) {
      return 'Token is empty';
    }
    else if (this is DiscordValidatorStatusTokenInvalid) {
      return 'Token is invalid';
    }
    else if (this is DiscordValidatorStatusGuildNotFound) {
      return 'Guild not found';
    }
    else if (this is DiscordValidatorStatusUnknownError) {
      return 'Unknown error';
    }
    else {
      return 'Unknown error';
    }
  }
}



class DiscordValidator {


  const DiscordValidator();


  Future<DiscordValidatorStatus> checkToken(String token) async {
      try {
        final response = await _checkToken(token);
        return response.$1;
      }
      catch (e) {
        return DiscordValidatorStatusUnknownError(e);
      }
  }


  Future<(DiscordValidatorStatus, NyxxGateway? client)> _checkToken(String token) async {

      try {

        if (token.isEmpty) {
          return (DiscordValidatorStatusTokenEmpty(), null);
        }

        final client = await Nyxx.connectGateway(token, GatewayIntents.all);

        return (DiscordValidatorStatusSuccess(), client);
      }
      on NyxxException catch (_) {
        return (DiscordValidatorStatusTokenInvalid(), null);
      }
      catch (e) {
        return (DiscordValidatorStatusUnknownError(e), null);
      }

  }


  Future<DiscordValidatorStatus> check(String token, int guildId) async {
      try {

        final tokenStatus = await _checkToken(token);

        if (tokenStatus.$1 is! DiscordValidatorStatusSuccess) {
          return tokenStatus.$1;
        }

        await tokenStatus.$2?.guilds.fetch(Snowflake(guildId));

        return DiscordValidatorStatusSuccess();
      }
      on NyxxException catch (_) {
        return DiscordValidatorStatusGuildNotFound();
      }
      catch (e) {
        return DiscordValidatorStatusUnknownError(e);
      }
  }

}