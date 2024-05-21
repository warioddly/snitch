import 'package:snitch/core/services/faker.dart';
import 'package:snitch/features/tips/model/tip_model.dart';


class TipFaker {

  static TipModel createTip() {
    return TipModel(
        title: faker.lorem.words(8).join(" "),
        description: faker.lorem.sentence()
    );
  }

  static List<TipModel> createTips([int amount = 10]) {
    return List.generate(amount, (index) => createTip());
  }



}