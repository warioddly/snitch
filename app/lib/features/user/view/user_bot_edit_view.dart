import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:snitch/core/constants/constants.dart';
import 'package:snitch/features/tips/tips/tips.dart';
import 'package:snitch/features/tips/view/tip_detail_view.dart';
import 'package:snitch/features/user/bloc/user_bot/user_bot_bloc.dart';
import 'package:snitch/features/user/bloc/user_config/user_config_bloc.dart';
import 'package:snitch/features/user/model/user_config_model.dart';
import 'package:snitch/shared/ui/appbar/appbar.dart';
import 'package:snitch/shared/ui/button/styled_text_button.dart';
import 'package:snitch/shared/ui/layout/content_box.dart';
import 'package:snitch/shared/ui/textfield/styled_text_field.dart';


class UserBotUpdateSettingView extends StatefulWidget {

  const UserBotUpdateSettingView({super.key});

  static const String route = '/user-bot-update-setting';

  @override
  State<UserBotUpdateSettingView> createState() => _UserBotUpdateSettingViewState();
}

class _UserBotUpdateSettingViewState extends State<UserBotUpdateSettingView> {

  final nameController  = TextEditingController();
  final tokenController = TextEditingController();
  final guildController = TextEditingController();
  final formKey         = GlobalKey<FormState>();
  final configBloc      = GetIt.I.get<UserConfigBloc>();

  UserConfigModel? configs;


  UserBotBloc get botBloc  => context.read<UserBotBloc>();


  @override
  void initState() {
    super.initState();
    configBloc.add(const UserConfigReadEvent());
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Appbar(
        title: 'Update Your Bot',
        enableImplyLeading: true,
      ),
      body: ContentBox(
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
                          'Edit Your ${BOT_APP_NAME.toUpperCase()} Bot',
                          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                          )
                      ),
                    ),

                    const SizedBox(height: 20),

                    StyledTextField(
                      controller: nameController..text = configs?.name ?? "",
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
                      controller: tokenController..text = configs?.token ?? "",
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
                                  Navigator.of(context).pushNamed(TipDetailView.route, arguments: tip_how_to_get_discord_bot_token);
                                },
                              ),
                            ],
                          )
                      ),
                    ),

                    const SizedBox(height: 20),

                    StyledTextField(
                      controller: guildController..text = configs?.guildId.toString() ?? "",
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
                                  Navigator.of(context).pushNamed(TipDetailView.route, arguments: tip_how_to_get_discord_bot_token);
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

                          if (state is UserConfigReaded) {
                            setState(() {
                              configs = state.configs;
                            });
                          }

                          if (state is UserConfigUpdateError) {
                            BotToast.showSimpleNotification(
                                title: state.message,
                                subTitle: 'Please check your data and try again.',
                                backgroundColor: Colors.red,
                                duration: const Duration(seconds: 5)
                            );
                          }

                          if (state is UserConfigUpdated) {
                            context.read<UserBotBloc>().add(UserBotRestartEvent(state.configs));
                          }

                        },
                        builder: (context, configState) {
                          return BlocConsumer<UserBotBloc, UserBotState>(
                              listener: (context, state) {

                                if (state is UserBotRestarted) {
                                  // context.read<UserBloc>().add(const UserGood());
                                  BotToast.showSimpleNotification(
                                      title: 'Bot updated successfully',
                                      subTitle: 'Your bot is now ready to use.',
                                      backgroundColor: Colors.green,
                                      duration: const Duration(seconds: 5)
                                  );

                                  Navigator.maybePop(context);
                                }

                              },
                              builder: (context, botState) {
                                return StyledTextButton(
                                  loading: (configState is UserConfigUpdating || botState is UserBotRestarting),
                                  onPressed: () async {

                                    if (!formKey.currentState!.validate()) {
                                      return;
                                    }

                                    final config = UserConfigModel(
                                      id: configs?.id,
                                      name: nameController.text,
                                      token: tokenController.text,
                                      guildId: int.parse(guildController.text),
                                    );


                                    if (config == configs) {
                                      BotToast.showSimpleNotification(
                                          title: 'No changes',
                                          subTitle: 'You have not made any changes to the bot settings.',
                                          duration: const Duration(seconds: 5)
                                      );
                                      return;
                                    }

                                    configBloc.add(UserConfigUpdateEvent(config));

                                  },
                                  text: 'Update Bot',
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
      ),
    );
  }


}
