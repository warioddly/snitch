import 'package:snitch/core/services/faker.dart';
import 'package:snitch/features/bot/model/bot_model.dart';


class BotFaker {


  static BotModel createBot() {
    return BotModel(
        name: faker.person.name(),
        description: faker.lorem.sentence(),
        token: faker.guid.guid(),
        image: faker.image.image(),
        status: faker.randomGenerator.boolean().toString(),
        updatedAt: faker.date.dateTime()
    );
  }


  static List<BotModel> createBots([int amount = 10]) {
    return List.generate(amount, (index) => createBot());
  }


}