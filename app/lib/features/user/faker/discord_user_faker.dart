import 'package:snitch/core/services/faker.dart';
import 'package:snitch/features/user/model/discord_user_model.dart';

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