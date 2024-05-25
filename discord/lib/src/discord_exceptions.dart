
sealed class DiscordException extends Error {
  DiscordException();
}

final class DiscordUnknownException extends DiscordException {
  final Object error;
  DiscordUnknownException({required this.error});
}

final class DiscordUserNotFoundException extends DiscordException { }

final class DiscordTokenEmptyException extends DiscordException { }