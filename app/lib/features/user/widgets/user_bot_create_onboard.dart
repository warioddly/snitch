import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snitch/features/tips/tips/tips.dart';
import 'package:snitch/features/tips/view/tip_detail_view.dart';
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
  late final configBloc = context.read<UserConfigBloc>();


  @override
  Widget build(BuildContext context) {
    return ContentBox(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Text(
                      'Create Your First Bot',
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      )
                  ),
                ),

                const SizedBox(height: 20),

                StyledTextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    hintText: 'Bot Name',
                    suffixIcon: Icon(CupertinoIcons.ant),
                  ),
                ),

                const SizedBox(height: 20),

                StyledTextField(
                  controller: tokenController,
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
                  controller: guildController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
                  child: BlocBuilder<UserConfigBloc, UserConfigState>(
                    builder: (context, state) {
                      return StyledTextButton(
                        loading: state is UserConfigCreating,
                        onPressed: () async {

                          if (state is UserConfigCreating) {
                            BotToast.showText(text: 'Please wait');
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
                    },
                  ),
                )

              ],
            ),
          ),
        )
    );
  }


}
