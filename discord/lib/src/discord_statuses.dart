
sealed class DiscordStatus {
  const DiscordStatus();
}

final class DiscordUnknownStatus extends DiscordStatus {
  const DiscordUnknownStatus({required this.message});
  final Object message;
}

final class DiscordEmptyTokenStatus extends DiscordStatus {
  const DiscordEmptyTokenStatus();
}

final class DiscordTokenInvalidStatus extends DiscordStatus {
  const DiscordTokenInvalidStatus();
}

final class DiscordGuildNotFoundStatus extends DiscordStatus {
  const DiscordGuildNotFoundStatus();
}

final class DiscordTokenSuccessStatus extends DiscordStatus {
  const DiscordTokenSuccessStatus();
}

final class DiscordUserNotFoundStatus extends DiscordStatus {
  const DiscordUserNotFoundStatus();
}

extension DiscordStatusExtension on DiscordStatus {
  String get message {
    if (this is DiscordEmptyTokenStatus) {
      return 'Token is empty';
    }
    else if (this is DiscordTokenInvalidStatus) {
      return 'Token is invalid';
    }
    else if (this is DiscordGuildNotFoundStatus) {
      return 'Guild not found';
    }
    else if (this is DiscordUnknownStatus) {
      return 'Unknown error';
    }
    else {
      return 'Unknown error';
    }
  }
}


