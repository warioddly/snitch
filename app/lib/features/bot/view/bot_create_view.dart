import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snitch/core/constants/constants.dart';
import 'package:snitch/core/services/faker.dart';
import 'package:snitch/features/bot/bloc/bot_bloc.dart';
import 'package:snitch/features/bot/model/bot_model.dart';
import 'package:snitch/features/tips/view/tips_view.dart';
import 'package:snitch/shared/ui/appbar/appbar.dart';
import 'package:snitch/shared/ui/layout/content_box.dart';

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
            children: [

              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                    labelText: 'Bot name*',
                    hintText: 'Enter bot name',
                    suffix: IconButton(
                        icon: const Icon(CupertinoIcons.wand_stars),
                        onPressed: () {
                          _nameController
                            ..clear()
                            ..text = 'Bot ${faker.animal.name()}';
                        }
                    )
                ),
              ),


              TextField(
                decoration: InputDecoration(
                  labelText: 'Bot description',
                  hintText: 'Enter bot description',
                ),
              ),


              TextField(
                controller: _tokenController,
                decoration: InputDecoration(
                    labelText: 'Token',
                    hintText: 'Enter bot token',
                    suffix: IconButton(
                        icon: const Icon(CupertinoIcons.info),
                        onPressed: () {
                          Navigator.pushNamed(context, TipsView.route, arguments: 'token');
                        }
                    )
                ),
              ),


              const Spacer(),


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