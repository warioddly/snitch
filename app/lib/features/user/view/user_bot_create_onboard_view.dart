import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:snitch/features/tips/tips/tips.dart';
import 'package:snitch/features/tips/view/tip_detail_view.dart';
import 'package:snitch/features/user/bloc/user/user_bloc.dart';
import 'package:snitch/features/user/bloc/user_bot/user_bot_bloc.dart';
import 'package:snitch/features/user/bloc/user_config/user_config_bloc.dart';
import 'package:snitch/features/user/model/user_config_model.dart';
import 'package:snitch/shared/ui/button/styled_text_button.dart';
import 'package:snitch/shared/ui/layout/content_box.dart';
import 'package:snitch/shared/ui/textfield/styled_text_field.dart';


class UserBotCreateOnboard extends StatefulWidget {
  const UserBotCreateOnboard({super.key});

  @override
  State<UserBotCreateOnboard> createState() => _UserBotCreateOnboardState();
}

class _UserBotCreateOnboardState extends State<UserBotCreateOnboard> {

  final nameController  = TextEditingController();
  final tokenController = TextEditingController();
  final guildController = TextEditingController();
  final formKey         = GlobalKey<FormState>();
  final configBloc      = GetIt.I.get<UserConfigBloc>();

  @override
  Widget build(BuildContext context) {
    return ContentBox(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Text(
                        'Create Your First Bot',
                        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          fontWeight: FontWeight.w700
                        )
                    ),
                  ),

                  const SizedBox(height: 20),

                  StyledTextField(
                    controller: nameController,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Please specify the name of the bot";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      hintText: 'Bot Name',
                      suffixIcon: Icon(CupertinoIcons.ant),
                    ),
                  ),

                  const SizedBox(height: 20),

                  StyledTextField(
                    controller: tokenController,
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return "Please, provide your Discord BOT token";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: 'Bot Token',
                        suffixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              enableFeedback: true,
                              icon: const Icon(CupertinoIcons.doc_text),
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                Clipboard.getData('text/plain').then((value) {
                                  tokenController.text = value?.text ?? '';
                                });
                              },
                            ),
                            IconButton(
                              enableFeedback: true,
                              icon: const Icon(CupertinoIcons.info),
                              onPressed: () {
                                Navigator.of(context).pushNamed(
                                    TipDetailView.route,
                                    arguments: tip_how_to_get_discord_bot_token);
                              },
                            ),
                          ],
                        )
                    ),
                  ),

                  const SizedBox(height: 20),

                  StyledTextField(
                    controller: guildController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (String? value) {
                      if (value != null) {
                        if (value.isEmpty) {
                          return "Please, provide your Guild ID";
                        }

                        if (int.tryParse(value) == null) {
                          return "Guild ID should be number";
                        }
                      }

                      return null;
                    },
                    decoration: InputDecoration(
                        hintText: 'Guild ID',
                        suffixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              enableFeedback: true,
                              icon: const Icon(CupertinoIcons.doc_text),
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                Clipboard.getData('text/plain').then((value) {
                                  guildController.text = value?.text ?? '';
                                });
                              },
                            ),
                            IconButton(
                              enableFeedback: true,
                              icon: const Icon(CupertinoIcons.info),
                              onPressed: () {
                                Navigator.of(context).pushNamed(
                                    TipDetailView.route,
                                    arguments: tip_how_to_get_discord_bot_token);
                              },
                            ),
                          ],
                        )
                    ),
                  ),

                  const SizedBox(height: 20),

                  Center(
                    child: BlocConsumer<UserConfigBloc, UserConfigState>(
                      bloc: configBloc,
                      listener: (context, state) {

                        if (state is UserConfigCreateError) {

                          BotToast.showSimpleNotification(
                              title: state.message,
                              subTitle: 'Please check your data and try again.',
                              backgroundColor: Colors.red,
                              duration: const Duration(seconds: 5)
                          );
                        }

                        if (state is UserConfigCreated) {
                          context.read<UserBotBloc>().add(UserBotStartEvent(state.configs));
                        }

                      },
                      builder: (context, configState) {
                        return BlocConsumer<UserBotBloc, UserBotState>(
                          listener: (context, state) {

                            if (state is UserBotStarted) {
                              context.read<UserBloc>().add(const UserGood());
                            }

                          },
                          builder: (context, botState) {
                            return StyledTextButton(
                              loading: (configState is UserConfigCreating || botState is UserBotStarting),
                              onPressed: () async {

                                if (!formKey.currentState!.validate()) {
                                  return;
                                }

                                final config = UserConfigModel(
                                  id: null,
                                  name: nameController.text,
                                  token: tokenController.text,
                                  guildId: int.parse(guildController.text),
                                );

                                configBloc.add(UserConfigCreateEvent(config));

                              },
                              text: 'Create Bot',
                            );
                          }
                        );
                      },
                    ),
                  ),

                ],
              ),
            ),
          ),
        )
    );
  }


}
