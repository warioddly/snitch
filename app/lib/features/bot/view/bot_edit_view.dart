import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:snitch/core/constants/constants.dart';
import 'package:snitch/core/extensions/build_context_extenstion.dart';
import 'package:snitch/core/services/faker.dart';
import 'package:snitch/features/bot/bloc/bot_action/bot_action_bloc.dart';
import 'package:snitch/features/bot/bloc/bots_bloc/bots_bloc.dart';
import 'package:snitch/features/bot/model/bot_model.dart';
import 'package:snitch/features/bot/widgets/bot_convey_info.dart';
import 'package:snitch/features/tips/tips/tips.dart';
import 'package:snitch/features/tips/view/tip_detail_view.dart';
import 'package:snitch/features/wrapper/view/wrapper_view.dart';
import 'package:snitch/shared/ui/appbar/appbar.dart';
import 'package:snitch/shared/ui/button/paste_icon_button.dart';
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


  final nameController        = TextEditingController();
  final descriptionController = TextEditingController();
  final tokenController       = TextEditingController();
  final formKey               = GlobalKey<FormState>();
  final actionBotBloc         = GetIt.I.get<BotActionBloc>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const Appbar(
          title: 'Create Bot',
          enableImplyLeading: true,
        ),
        body: ContentBox(
          child: Form(
            key: formKey,
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
                  controller: nameController..text = widget.bot.name,
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
                            nameController
                              ..clear()
                              ..text = 'Bot ${faker.animal.name()}';
                          }
                      )
                  ),
                ),

                const SizedBox(height: 20),

                StyledTextField(
                  controller: descriptionController..text = widget.bot.description,
                  decoration: const InputDecoration(
                    hintText: 'Enter bot description',
                  ),
                ),

                const SizedBox(height: 20),

                StyledTextField(
                  controller: tokenController..text = widget.bot.token,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Please, provide your Discord BOT token";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      hintText: 'Enter bot token',
                      suffixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          PasteIconButton(controller: tokenController),
                          IconButton(
                              icon: const Icon(CupertinoIcons.info),
                              onPressed: () {
                                context.go(TipDetailView.route, arguments: tip_how_to_get_discord_bot_token);
                              }
                          )
                        ],
                      )
                  ),
                ),

                const SizedBox(height: 20),

                BlocConsumer<BotActionBloc, BotActionState>(
                  bloc: actionBotBloc,
                  listener: (context, state) {

                    if (state is BotActionSuccess) {
                      context.read<BotsBloc>().add(const BotsReadEvent());
                      context.goBackUntil((route) => route.settings.name == WrapperView.route);
                    }

                    if (state is BotActionError) {
                      BotToast.showSimpleNotification(
                        title: "Oops! Something went wrong",
                        subTitle: state.message,
                        backgroundColor: Colors.red,
                      );
                    }

                  },
                  builder: (context, state) {
                    return StyledTextButton(
                      loading: state is BotActionLoading,
                      onPressed: () {

                        FocusManager.instance.primaryFocus?.unfocus();

                        if (formKey.currentState!.validate()) {

                          final bot = widget.bot.copyWith(
                            name: nameController.text,
                            description: descriptionController.text,
                            token: tokenController.text,
                            updatedAt: DateTime.now(),
                          );

                          actionBotBloc.add(BotActionUpdateEvent(bot: bot));

                        }
                      },
                      text: 'Edit Bot',
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