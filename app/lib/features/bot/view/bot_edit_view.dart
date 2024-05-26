import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snitch/core/constants/constants.dart';
import 'package:snitch/core/services/faker.dart';
import 'package:snitch/features/bot/bloc/bot_action/bot_action_bloc.dart';
import 'package:snitch/features/bot/bloc/bots_bloc/bots_bloc.dart';
import 'package:snitch/features/bot/model/bot_model.dart';
import 'package:snitch/features/bot/widgets/bot_convey_info.dart';
import 'package:snitch/features/tips/tips/tips.dart';
import 'package:snitch/features/tips/view/tip_detail_view.dart';
import 'package:snitch/shared/ui/appbar/appbar.dart';
import 'package:snitch/shared/ui/button/styled_text_button.dart';
import 'package:snitch/shared/ui/layout/content_box.dart';
import 'package:snitch/shared/ui/textfield/styled_text_field.dart';

class BotEditView extends StatefulWidget {

  const BotEditView({super.key, required this.bot});

  static const String route = '/bot-edit';

  final BotModel bot;

  @override
  State<BotEditView> createState() => _BotEditViewState();
}

class _BotEditViewState extends State<BotEditView> {

  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _tokenController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(
        title: 'Edit ${widget.bot.name}',
        enableImplyLeading: true,
      ),
      body: ContentBox(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: Text(
                    'Edit Your ${BOT_APP_NAME.toUpperCase()} Bot',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    )
                ),
              ),

              const SizedBox(height: 20),

              StyledTextField(
                controller: _nameController..text = widget.bot.name,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Bot name is required';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: 'Enter bot name*',
                    suffixIcon: IconButton(
                        visualDensity: VisualDensity.compact,
                        enableFeedback: true,
                        icon: const Icon(CupertinoIcons.wand_stars),
                        onPressed: () {
                          _nameController
                            ..clear()
                            ..text = 'Bot ${faker.animal.name()}';
                        }
                    )
                ),
              ),


              const SizedBox(height: 20),


              StyledTextField(
                controller: _descriptionController..text = widget.bot.description,
                decoration: const InputDecoration(
                  hintText: 'Enter bot description',
                ),
              ),


              const SizedBox(height: 20),


              StyledTextField(
                controller: _tokenController..text = widget.bot.token,
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Please, provide your Discord BOT token";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    hintText: 'Enter bot token',
                    suffixIcon: IconButton(
                        visualDensity: VisualDensity.compact,
                        enableFeedback: true,
                        icon: const Icon(CupertinoIcons.info),
                        onPressed: () {
                          Navigator.pushNamed(context, TipDetailView.route, arguments: tip_how_to_get_discord_bot_token);
                        }
                    )
                ),
              ),


              const SizedBox(height: 20),


              BlocConsumer<BotActionBloc, BotActionState>(
                bloc: context.read<BotActionBloc>()..add(const BotActionInitialEvent()),
                listener: (context, state) {

                  if (state is BotActionSuccess) {
                    context.read<BotsBloc>().add(const BotsReadEvent());
                    Navigator.pop(context);
                  }

                  if (state is BotActionError) {
                    BotToast.showSimpleNotification(
                      title: "Oops! Something went wrong",
                      backgroundColor: Colors.red,
                    );
                  }

                },
                builder: (context, state) {
                  return StyledTextButton(
                    loading: state is BotActionLoading,
                    onPressed: () {

                      if (state is BotActionLoading) {
                        return;
                      }

                      if (_formKey.currentState!.validate()) {

                        // final bot = BotModel(
                        //   name: _nameController.text,
                        //   description: _descriptionController.text,
                        //   token: _tokenController.text,
                        //   image: faker.image.image(),
                        //   createdAt: DateTime.now(),
                        //   updatedAt: DateTime.now(),
                        // );

                        // context.read<BotActionBloc>().add(BotActionCreateEvent(bot: bot));

                      }
                    },
                    text: 'Save',
                  );
                },
              ),


              const BotConveyInfo()

            ],
          ),
        ),
      )
    );
  }
}