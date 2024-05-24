import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snitch/core/constants/constants.dart';
import 'package:snitch/core/services/faker.dart';
import 'package:snitch/features/bot/bloc/bot_action/bot_action_bloc.dart';
import 'package:snitch/features/bot/bloc/bots_bloc/bots_bloc.dart';
import 'package:snitch/features/bot/model/bot_model.dart';
import 'package:snitch/features/tips/tips/tips.dart';
import 'package:snitch/features/tips/view/tip_detail_view.dart';
import 'package:snitch/shared/ui/appbar/appbar.dart';
import 'package:snitch/shared/ui/button/styled_text_button.dart';
import 'package:snitch/shared/ui/layout/content_box.dart';
import 'package:snitch/shared/ui/textfield/styled_text_field.dart';

class BotCreateView extends StatefulWidget {

  const BotCreateView({super.key});

  static const String route = '/bot-create';

  @override
  State<BotCreateView> createState() => _BotCreateViewState();
}

class _BotCreateViewState extends State<BotCreateView> {


  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _tokenController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Appbar(
        title: 'Create Bot',
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
                    'Create Your ${BOT_APP_NAME.toUpperCase()} Bot',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    )
                ),
              ),

              const SizedBox(height: 20),

              StyledTextField(
                controller: _nameController,
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
                controller: _descriptionController,
                decoration: const InputDecoration(
                  hintText: 'Enter bot description',
                ),
              ),


              const SizedBox(height: 20),


              StyledTextField(
                controller: _tokenController..text = "MTI0MzExNDg2OTk0Nzg5MTcxMg.GgdI8l.HMDyb_6bl00msg6kZgKvZABSY20bJ-3L3tmO5E",
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
                    print(state.message);
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

                        final bot = BotModel(
                          name: _nameController.text,
                          description: _descriptionController.text,
                          token: _tokenController.text,
                          image: faker.image.image(),
                          createdAt: DateTime.now(),
                          updatedAt: DateTime.now(),
                        );

                        context.read<BotActionBloc>().add(BotActionCreateEvent(bot: bot));

                      }
                    },
                    text: 'Create Bot',
                  );
                },
              ),


              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    "${BOT_APP_NAME.toUpperCase()} v1.0.0",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              )

            ],
          ),
        ),
      )
    );
  }
}