import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snitch/core/services/locator/locator.dart';
import 'package:snitch/features/commands/bloc/command_bloc.dart';
import 'package:snitch/features/commands/widgets/add_command_dialog.dart';
import 'package:snitch/shared/ui/appbar/appbar.dart';

class CommandView extends StatefulWidget {

  const CommandView({super.key});

  static const String route = '/commands';

  @override
  State<StatefulWidget> createState() => _CommandViewState();

}

class _CommandViewState extends State<CommandView> {


  final commandBloc = getIt<CommandBloc>();


  @override
  void initState() {
    super.initState();
    commandBloc.add(CommandReadAllEvent());
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(
        title: "Commands",
        enableImplyLeading: true,
        actions: [
          IconButton(
              tooltip: 'Bot settings',
              icon: const Icon(CupertinoIcons.add_circled),
              onPressed: () async {

                final result = await showDialog<bool?>(
                  context: context,
                  builder: (context) => const AddCommandDialog(),
                );

                if (result != null) {
                  commandBloc.add(CommandReadAllEvent());
                }

              }
          )
        ],
      ),
      body: BlocConsumer<CommandBloc, CommandState>(
        bloc: commandBloc,
        listener: (context, state) {

          if (state is CommandCreateSuccess) {
            BotToast.showSimpleNotification(title: 'Command created');
          }

          if (state is CommandUpdateSuccess) {
            BotToast.showSimpleNotification(title: 'Command updated');
          }

          if (state is CommandDeleteSuccess) {
            BotToast.showSimpleNotification(title: 'Command deleted');
          }

        },
        builder: (context, state) {
          return CustomScrollView(
            shrinkWrap: true,
            slivers: [

              /// TODO: Implement Sliver Search Bar
              // const SliverAppBar(
              //   snap: true,
              //   floating: true,
              //   pinned: false,
              //   automaticallyImplyLeading: false,
              //   flexibleSpace: ChatFooter(),
              // ),


              if (state is CommandReadAllSuccess)
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      final command = state.commands[index];
                      return ListTile(
                        title: Text(command.command),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            commandBloc.add(CommandDeleteEvent(command.id!));
                          },
                        ),
                      );
                    },
                    childCount: state.commands.length,
                  ),
                ),


            ],
          );
        },
      ),
    );
  }


}