import 'package:discord/discord.dart';
import 'package:nyxx/nyxx.dart';


typedef DiscordMessageCreateEvent = void Function(MessageCreateEvent event);

typedef DiscordClientReadyEvent = void Function(ReadyEvent event);

typedef DiscordChannelReadyEvent = void Function(GuildTextChannel channel);


class Discord {

  Discord({
    required this.token,
    required this.guildId,
    this.onMessageCreate,
    this.onReady,
    this.onChannelReady
  });

  final String token;
  final int guildId;
  final DiscordMessageCreateEvent? onMessageCreate;
  final DiscordClientReadyEvent?   onReady;
  final DiscordChannelReadyEvent?  onChannelReady;

  NyxxGateway?      _client;
  GuildTextChannel? _channel;
  User?  _user;
  DiscordUserModel? _discordUser;
  Guild? _guild;


  Future<void> start() async {

    if (token.isEmpty) {
      throw Exception('Token is empty');
    }

    _client = await Nyxx.connectGateway(token, GatewayIntents.all);
    _user   = await _client?.users.fetchCurrentUser();


    if (_user == null) {
      throw Exception('User is null');
    }

    _discordUser = DiscordUserModel.fromUser(_user!);


    _client?.onReady.listen((ReadyEvent event) async {

      await _getChannel();

      print('Discord is ready to receive messages! 🚀');

      _client?.onMessageCreate.listen(_onMessage);

      onReady?.call(event);

    });

  }


  Future<void> sendMessage(String content, [Message? message, bool reply = false]) async {
    await _channel?.sendMessage(MessageBuilder(
        content: content,
    ));
  }


  Future<void> _onMessage(MessageCreateEvent event) async {
    onMessageCreate?.call(event);
  }


  Future<void> _getChannel() async {
    _guild = await _client?.guilds.fetch(Snowflake(guildId));
    _client?.channels.cache.forEach((Snowflake id, Channel channel) async {
      if (channel is GuildTextChannel) {
        print('${user?.name} is connected to channel: ${channel.name}');
        _channel = channel;
        onChannelReady?.call(channel);
      }
    });
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