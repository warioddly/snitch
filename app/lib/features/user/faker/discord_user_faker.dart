import 'package:discord/discord.dart';
import 'package:snitch/core/services/faker.dart';

class DiscordUserFaker {

  static DiscordUserModel createDiscordUser() {
    return DiscordUserModel(
        id: faker.randomGenerator.integer(9999),
        name: faker.person.name(),
        avatar: faker.image.image(),
    );
  }

  static List<DiscordUserModel> createDiscordUsers([int amount = 10]) {
    return List.generate(amount, (index) => createDiscordUser());
  }

}