import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snitch/core/services/locator/locator.dart';
import 'package:snitch/core/utils/extensions/build_context_extenstion.dart';
import 'package:snitch/features/commands/bloc/command_bloc.dart';
import 'package:snitch/shared/ui/button/paste_icon_button.dart';
import 'package:snitch/shared/ui/button/styled_text_button.dart';
import 'package:snitch/shared/ui/textfield/styled_text_field.dart';

class AddCommandDialog extends StatefulWidget {

  const AddCommandDialog({super.key});

  @override
  State<AddCommandDialog> createState() => _AddCommandDialogState();
}

class _AddCommandDialogState extends State<AddCommandDialog> {


  final _formKey = GlobalKey<FormState>();
  final controller = TextEditingController();
  final commandBloc = getIt<CommandBloc>();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CommandBloc, CommandState>(
      bloc: commandBloc,
      listener: (context, state) {

        if (state is CommandCreateSuccess) {
          BotToast.showSimpleNotification(title: 'Command created');
          context.goBack(true);
        }

        if (state is CommandError) {
          BotToast.showSimpleNotification(title: state.message);
        }

      },
      builder: (context, state) {
        return AlertDialog(
          title: const Text('Add Command'),
          content: Form(
            key: _formKey,
            child: StyledTextField(
              controller: controller,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a command';
                }
                return null;
              },
              decoration: InputDecoration(
                  hintText: 'Command',
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      PasteIconButton(controller: controller)
                    ],
                  )
              ),
            ),
          ),
          actions: [
            StyledTextButton(
              onPressed: context.goBack,
              text: 'Cancel',
            ),
            StyledTextButton(
              loading: state is CommandLoading,
              onPressed: () {

                if (_formKey.currentState!.validate()) {
                  commandBloc.add(CommandCreateEvent(controller.text));
                }

              },
              text: 'Create',
            ),
          ],
        );
      },
    );
  }
}