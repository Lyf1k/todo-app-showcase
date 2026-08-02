import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:partfolio_app/feautures/auth/presentation/utils/auth_form_field.dart';
import 'package:provider/provider.dart';

import '../../../core/initialization/widgets/dependencies_scope.dart';
import '../../../core/theme/app_colors.dart';
import '../utils/task_card.dart';
import 'state/tasks_state.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreen();
}

class _TasksScreen extends State<TasksScreen> {
  late TextEditingController todosNameController;
  late DateTime? dateTime;

  @override
  void initState() {
    // TODO: implement initState
    todosNameController = TextEditingController();
    dateTime = null;
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    todosNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dependencies = DependenciesScope.of(context)!.dependencies;
    final tasksController = Provider.of<TasksController>(
      context,
      listen: false,
    );
    return SafeArea(
      child: CustomScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 100,
            actions: [
              // IconButton.outlined(onPressed: () async {
              //   await notificationService.showNotificationWithActions(); 
              //   await notificationService.createSheduleNotification(importance: true, tickerText: "Create shedule task");

              // }, icon: Icon(Icons.notification_add_outlined)),
              IconButton.outlined(
                onPressed: () async {
                  await tasksController.delAllItems();
                  // await tasksController.loadData();
                },
                icon: Icon(Icons.delete),
              ),
              IconButton(
                onPressed: () async {
                  // final user = await dependencies
                  //     .authenticationRepository
                  //     .userStream
                  //     .first;

                  // if (user == null) {
                  //   return;
                  // }
                  showModalBottom(
                    context: context,
                    child: _CreateTodoModalBottomSheet(
                      tasksController: tasksController,
                    ),
                  );
                  // tasksController.addItem("ASDASD");
                },
                icon: Icon(Icons.add),
              ),
              IconButton.filled(
                onPressed: () async {
                  // Navigator.of(context).pushReplacement(
                  //   MaterialPageRoute(builder: (context) => LoginScreen()),
                  // );
                  await dependencies.authenticationRepository.logout();
                },
                icon: Icon(
                  Icons.login_outlined,
                  color: Theme.of(context).primaryIconTheme.color,
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.only(
                top: MediaQuery.sizeOf(context).height * 0.01,
                left: MediaQuery.sizeOf(context).width * 0.01,
              ),
              // collapseMode: CollapseMode.values[14,],
              title: Text(
                'All to-dos',
                style: Theme.of(
                  context,
                ).textTheme.displayLarge?.copyWith(fontSize: 34),
              ),
              expandedTitleScale: 1.6,
            ),
          ),
          CupertinoSliverRefreshControl(
            onRefresh: () async {
              await tasksController.loadData();
            },
          ),
          _TaskCards(),
        ],
      ),
    );
  }

  showModalBottom({required BuildContext context, required Widget child}) {
    return showModalBottomSheet(
      backgroundColor: AppColors.surfaceVariant,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height - 10,
        maxWidth: MediaQuery.of(context).size.width - 12,
      ),
      barrierColor: const Color(0xFF253444).withOpacity(0.8),
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height * 0.025,
            left: MediaQuery.of(context).size.height * 0.015,
            right: MediaQuery.of(context).size.height * 0.015,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    margin: const EdgeInsets.only(top: 16, bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    width: 32,
                    height: 4,
                  ),
                ),
                child,
              ],
            ),
          ),
        );
      },
    );
  }
}

class _CreateTodoModalBottomSheet extends StatefulWidget {
  final TasksController tasksController;
  _CreateTodoModalBottomSheet({super.key, required this.tasksController});

  @override
  State<_CreateTodoModalBottomSheet> createState() =>
      _CreateTodoModalBottomSheetState();
}

class _CreateTodoModalBottomSheetState
    extends State<_CreateTodoModalBottomSheet> {
  late TextEditingController todosNameController;
  late DateTime? dateTime;

  @override
  void initState() {
    // TODO: implement initState
    todosNameController = TextEditingController();
    dateTime = null;
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    todosNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final taskController = Provider.of<TasksController>(context, listen: false);
    return Column(
      children: [
        ?dateTime != null
            ? DecoratedBox(
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: CupertinoColors.inactiveGray,
                      width: 0.0,
                    ),
                    bottom: BorderSide(
                      color: CupertinoColors.inactiveGray,
                      width: 0.0,
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text("Selected date time: $dateTime")],
                  ),
                ),
              )
            : null,
        // AuthTextField(

        //   titleText: 'Create Todo',
        // ),
        TextFormField(
          controller: todosNameController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 4),
              borderRadius: BorderRadius.circular(34),
            ),
            hintText: 'To-dos',
            hintStyle: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: AppColors.onInfo),
          ),
        ),

        Padding(
          padding: EdgeInsetsGeometry.only(
            top: MediaQuery.of(context).size.height * 0.02,
          ),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  _showDialog(
                    CupertinoDatePicker(
                      use24hFormat: true,
                      onDateTimeChanged: (DateTime newDateTime) {
                        setState(() {
                          dateTime = newDateTime;
                        });
                      },
                    ),
                  );
                },
                icon: Icon(Icons.alarm_outlined),
              ),
              Spacer(),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.2,
                child: ElevatedButton(
                  onPressed: () {
                    widget.tasksController.addItem(
                      todosNameController.text,
                      dateTime,
                    );
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Save",
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        // The Bottom margin is provided to align the popup above the system
        // navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(top: false, child: child),
      ),
    );
  }
}

class _TaskCards extends StatelessWidget {
  _TaskCards({super.key});

  @override
  Widget build(BuildContext context) {
    const Key centerKey = ValueKey<String>('bottom-sliver-list');
    final tasksController = Provider.of<TasksController>(
      context,
      listen: false,
    );
    return StreamBuilder(
      stream: tasksController.tasksStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data == null) {
          return SliverToBoxAdapter(
            child: Center(
              child: Column(
                children: [
                  Text(
                    "Uploading tasks...",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  CircularProgressIndicator(),
                ],
              ),
            ),
          );
        }
        final tasks = snapshot.data!;
        if (tasks.isEmpty) {
          return SliverToBoxAdapter(child: Center(child: Text("No tasks")));
        }
        return SliverList.separated(
          separatorBuilder: (context, index) =>
              // Divider(height: MediaQuery.sizeOf(context).height * 0.02),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.02,),
          key: centerKey,
          itemCount: tasks.length,
          itemBuilder: (BuildContext context, int index) {
            final task = tasks[index];
            return TaskCard(
              taskName: task.text,
              backgroundColor: AppColors.surface,
              width: MediaQuery.sizeOf(context).width,
              onPressed: () {},
              dateTime: task.dateTime?.toString(),
            );
          },
        );
      },
    );
  }
}
