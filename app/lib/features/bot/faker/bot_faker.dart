import 'package:snitch/core/services/faker.dart';
import 'package:snitch/features/bot/model/bot_model.dart';


class BotFaker {


  static BotModel createBot([int? id]) {
    return BotModel(
        id: id ?? faker.randomGenerator.integer(9999),
        name: faker.person.name(),
        description: faker.lorem.sentence(),
        token: faker.guid.guid(),
        image: faker.image.image(),
        createdAt: faker.date.dateTime(),
        updatedAt: faker.date.dateTime()
    );
  }


  static List<BotModel> createBots([int amount = 10, bool uniqueId = false]) {
    return List.generate(amount, (index) => createBot(uniqueId ? index : null));
  }


}