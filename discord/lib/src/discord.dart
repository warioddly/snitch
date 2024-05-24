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

  late final NyxxGateway      _client;
  late final GuildTextChannel _channel;
  late final User  _user;
  late final Guild _guild;


  Future<void> start() async {

    if (token.isEmpty) {
      throw Exception('Token is empty');
    }

    _client = await Nyxx.connectGateway(token, GatewayIntents.all);
    _user   = await _client.users.fetchCurrentUser();

    _client.onReady.listen((ReadyEvent event) async {

      await _getChannel();

      print('Discord is ready to receive messages! 🚀');

      _client.onMessageCreate.listen(_onMessage);

      onReady?.call(event);

    });

  }


  Future<void> sendMessage(String content, [Message? message, bool reply = false]) async {
    await _channel.sendMessage(MessageBuilder(content: content));
  }


  Future<void> _onMessage(MessageCreateEvent event) async {
    onMessageCreate?.call(event);
  }


  Future<void> _getChannel() async {
    _guild = await _client.guilds.fetch(Snowflake(guildId));
    _client.channels.cache.forEach((Snowflake id, Channel channel) async {
      if (channel is GuildTextChannel) {
        print('Bot is connected to channel: ${channel.name}');
        _channel = channel;
        onChannelReady?.call(_channel);
      }
    });
  }


  void stop() {
    _client.close();
    print('Bot is stopping... 🛑');
  }


  void restart() {
    stop();
    start();
  }



  NyxxGateway get client => _client;


  GuildTextChannel get channel => _channel;


  User get user => _user;


  Guild get guild => _guild;

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