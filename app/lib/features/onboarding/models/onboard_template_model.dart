import 'package:snitch/shared/ui/button/styled_text_button.dart';

class OnboardTemplateModel {


  const OnboardTemplateModel({
    required this.title,
    required this.description,
    required this.image,
    this.button,
  });

  final String title;
  final String description;
  final String image;
  final StyledTextButton? button;

}