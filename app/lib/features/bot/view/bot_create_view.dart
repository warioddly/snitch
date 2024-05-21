import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snitch/core/constants/constants.dart';
import 'package:snitch/core/services/faker.dart';
import 'package:snitch/features/bot/bloc/bot_bloc/bot_bloc.dart';
import 'package:snitch/features/bot/model/bot_model.dart';
import 'package:snitch/features/tips/view/tips_view.dart';
import 'package:snitch/shared/ui/appbar/appbar.dart';
import 'package:snitch/shared/ui/layout/content_box.dart';
import 'package:snitch/shared/ui/textfield/StyledTextField.dart';

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
            children: [

              StyledTextField(
                controller: _nameController,
                decoration: InputDecoration(
                    hintText: 'Enter bot name*',
                    suffixIconConstraints: const BoxConstraints(
                        maxHeight: 42,
                        maxWidth: 42
                    ),
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

              const SizedBox(height: 10),

              StyledTextField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  hintText: 'Enter bot description',
                ),
              ),

              const SizedBox(height: 10),

              StyledTextField(
                controller: _tokenController,
                decoration: InputDecoration(
                    hintText: 'Enter bot token',
                    suffixIconConstraints: const BoxConstraints(
                        maxHeight: 42,
                        maxWidth: 42
                    ),
                    suffixIcon: IconButton(
                        visualDensity: VisualDensity.compact,
                        enableFeedback: true,
                        icon: const Icon(CupertinoIcons.info),
                        onPressed: () {
                          Navigator.pushNamed(context, TipsView.route, arguments: 'token');
                        }
                    )
                ),
              ),

              const SizedBox(height: 10),

              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {

                    final bot = BotModel(
                      name: _nameController.text,
                      description: _descriptionController.text,
                      token: _tokenController.text,
                      status: "active",
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now(),
                    );

                    context.read<BotBloc>().add(BotCreateEvent(bot));
                    Navigator.maybePop(context);

                  }
                },
                child: const Text('Create Bot'),
              ),


              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  "${BOT_APP_NAME.toUpperCase()} v1.0.0",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              )

            ],
          ),
        ),
      )
    );
  }
}