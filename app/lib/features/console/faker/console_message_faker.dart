import 'package:snitch/core/services/faker.dart';
import 'package:snitch/features/console/model/console_message_model.dart';

class ConsoleMessageFaker {

  static ConsoleMessageModel createMessage() {
    return ConsoleMessageModel(
        user: faker.randomGenerator.boolean(),
        content: faker.lorem.sentence(),
        createdDate: faker.date.dateTime()
    );
  }

  static List<ConsoleMessageModel> createMessages([int amount = 10]) {
    return List.generate(amount, (index) => createMessage());
  }

}