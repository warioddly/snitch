import 'package:discord/discord.dart';
import 'package:nyxx/nyxx.dart';


typedef DiscordMessageCreateEvent = void Function(MessageCreateEvent event);

typedef DiscordClientReadyEvent = void Function(ReadyEvent event);

typedef DiscordChannelReadyEvent = void Function(GuildTextChannel channel);

typedef DiscordExceptionEvent = void Function(DiscordException error);


class Discord {

  Discord({
    required this.token,
    required this.guildId,
    this.onMessageCreate,
    this.onReady,
    this.onChannelReady,
    this.onError
  });

  final String token;
  final int guildId;
  final DiscordMessageCreateEvent? onMessageCreate;
  final DiscordClientReadyEvent?   onReady;
  final DiscordChannelReadyEvent?  onChannelReady;
  final DiscordExceptionEvent?  onError;

  NyxxGateway?      _client;
  GuildTextChannel? _channel;
  User?  _user;
  DiscordUserModel? _discordUser;
  Guild? _guild;


  Future<void> start() async {

        try {

          if (token.isEmpty) {
            throw DiscordTokenEmptyException();
          }

          _client = await Nyxx.connectGateway(token, GatewayIntents.all);
          _user   = await _client?.users.fetchCurrentUser();


          if (_user == null) {
            throw DiscordUserNotFoundException();
          }

          _discordUser = DiscordUserModel.fromUser(_user!);


          _client?.onReady.listen((ReadyEvent event) async {

            await _getChannel();

            print('Discord is ready to receive messages! 🚀');

            _client?.onMessageCreate.listen(_onMessage);

            onReady?.call(event);

          });
        }
        on DiscordUserNotFoundException {
          onError?.call(DiscordUserNotFoundException());
        }
        on DiscordTokenEmptyException {
          onError?.call(DiscordTokenEmptyException());
        }
        catch (e) {
          onError?.call(DiscordUnknownException(error: e));
        }

  }


  Future<void> sendMessage(String content, [Message? message, bool reply = false]) async {
    try {
      await _channel?.sendMessage(MessageBuilder(content: content));
    }
    catch (e) {
      onError?.call(DiscordUnknownException(error: e));
    }
  }


  Future<void> _onMessage(MessageCreateEvent event) async {
    onMessageCreate?.call(event);
  }


  Future<void> _getChannel() async {
    try {
      _guild = await _client?.guilds.fetch(Snowflake(guildId));
      _client?.channels.cache.forEach((Snowflake id, Channel channel) async {
        if (channel is GuildTextChannel) {
          print('${user?.name} is connected to channel: ${channel.name}');
          _channel = channel;
          onChannelReady?.call(channel);
        }
      });
    }
    catch (e) {
      onError?.call(DiscordUnknownException(error: e));
    }
  }


  void stop() {
    _client?.close();
    print('Discord is stopping... 🛑');
  }


  Future<void> restart() async {
    stop();
    await start();
  }


  NyxxGateway? get client => _client;


  GuildTextChannel? get channel => _channel;


  DiscordUserModel? get user => _discordUser;


  Guild? get guild => _guild;

  // String _buildMessage(String content) {
  //   return jsonEncode({
  //     'bot': bot.toJson(),
  //     'user': {
  //       'id': user.id.value,
  //       'name': user.username,
  //       'avatar': user.avatar.url.toString()
  //     },
  //     'content': content,
  //     'createdAt': DateTime.now().toIso8601String(),
  //   });
  // }

}