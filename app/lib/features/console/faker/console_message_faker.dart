import 'package:snitch/core/services/faker.dart';
import 'package:snitch/features/bot/faker/bot_faker.dart';
import 'package:snitch/features/console/model/console_message_model.dart';
import 'package:snitch/features/user/faker/discord_user_faker.dart';

class ConsoleMessageFaker {

  static ConsoleMessageModel createMessage() {
    return ConsoleMessageModel(
        id: faker.randomGenerator.integer(9999),
        bot: BotFaker.createBot(),
        user: DiscordUserFaker.createDiscordUser(),
        content: faker.lorem.sentence(),
        createdAt: faker.date.dateTime()
    );
  }

  static List<ConsoleMessageModel> createMessages([int amount = 10]) {
    return List.generate(amount, (index) => createMessage());
  }

}