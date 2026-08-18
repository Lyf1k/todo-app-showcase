import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/theme_controller.dart';
import '../../auth/presentation/state/auth_controller.dart';
import '../domain/entity/tasks.dart';
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

  late bool value;

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
    final tasksController = Provider.of<TasksController>(
      context,
      listen: false,
    );
    final authController = Provider.of<AuthController>(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
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
              _SwitchThemeModeButton(),
              IconButton.outlined(
                tooltip: "Delete all items",
                onPressed: () async {
                  await tasksController.delAllItems();
                  // await tasksController.loadData();
                },
                icon: Icon(Icons.delete),
              ),
              IconButton(
                tooltip: "Create task",
                onPressed: () async {
                  showModalBottom(
                    context: context,
                    child: _CreateTodoModalBottomSheet(
                      tasksController: tasksController,
                    ),
                    height: height,
                    width: width,
                  );
                  // tasksController.addItem("ASDASD");
                },
                icon: Icon(Icons.add),
              ),
              IconButton.filled(
                tooltip: "Log out",
                onPressed: () async {
                  await authController.logout();
                },
                icon: Icon(
                  Icons.login_outlined,
                  color: Theme.of(context).primaryIconTheme.color,
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.only(
                top: height * 0.01,
                left: width * 0.01,
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

  showModalBottom({
    required BuildContext context,
    required Widget child,
    required double height,
    required double width,
  }) {
    return showModalBottomSheet(
      useRootNavigator: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      constraints: BoxConstraints(maxHeight: height - 10, maxWidth: width - 12),
      barrierColor: const Color(0xFF253444).withValues(alpha: 0.5),
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
            bottom: MediaQuery.viewInsetsOf(context).bottom + height * 0.025,
            left: height * 0.015,
            right: height * 0.015,
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

class _SwitchThemeModeButton extends StatefulWidget {
  const _SwitchThemeModeButton({super.key});

  @override
  State<_SwitchThemeModeButton> createState() => _SwitchThemeModeButtonState();
}

class _SwitchThemeModeButtonState extends State<_SwitchThemeModeButton> {
  late bool isDark;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    isDark = Provider.of<AppThemeController>(context).isDark;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final themeController = Provider.of<AppThemeController>(context);
    return Row(
      children: [
        Icon(isDark ? Icons.dark_mode_outlined : Icons.light_mode_outlined),
        Switch.adaptive(
          value: isDark,
          onChanged: (bool value) async {
            await themeController.switchTheme(value);
            setState(() {
              isDark = value;
            });
          },
        ),
      ],
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
  bool _canSave = false;
  @override
  void initState() {
    // TODO: implement initState
    todosNameController = TextEditingController();
    dateTime = null;
    todosNameController.addListener(_onTextChanged);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    todosNameController.removeListener(_onTextChanged);
    todosNameController.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    final isValid = todosNameController.text.trim().isNotEmpty;
    if (isValid != _canSave) {
      setState(() {
        _canSave = isValid;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 8),
      child: Column(
        children: [
          ?dateTime != null
              ? Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.018,
                  ),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      border: Border.all(
                        color: CupertinoColors.inactiveGray,
                        width: 0.0,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                          child: Text(
                            " Selected date time: $dateTime",
                            style: textTheme.bodyLarge,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : null,

          TextFormField(
            controller: todosNameController,
            autofocus: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 4),
                borderRadius: BorderRadius.circular(34),
              ),
              hintText: 'To-dos',
              hintStyle: textTheme.bodyLarge,
            ),
          ),

          Padding(
            padding: EdgeInsetsGeometry.only(
              top: MediaQuery.of(context).size.height * 0.018,
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
                    onPressed: _canSave
                        ? () {
                            final newTask = Tasks(
                              id: Random().nextInt(10000),
                              text: todosNameController.text.trim(),
                              isDone: false,
                              dateTime: dateTime,
                            );
                            widget.tasksController.addItem(
                              newTask,
                              todoNotificationTime: dateTime,
                            );
                            Navigator.of(context).pop();
                          }
                        : null,
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
      ),
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

class _TaskCards extends StatefulWidget {
  const _TaskCards({super.key});

  @override
  State<_TaskCards> createState() => _TaskCardsState();
}

class _TaskCardsState extends State<_TaskCards> {
  @override
  Widget build(BuildContext context) {
    const Key centerKey = ValueKey<String>('bottom-sliver-list');
    final tasksController = Provider.of<TasksController>(
      context,
      listen: false,
    );
    final textTheme = Theme.of(context).textTheme;
    return StreamBuilder(
      stream: tasksController.tasksStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data == null) {
          return SliverToBoxAdapter(
            child: Center(
              child: Column(
                children: [
                  Text("Uploading tasks...", style: textTheme.titleLarge),
                  CircularProgressIndicator(),
                ],
              ),
            ),
          );
        }
        final tasks = snapshot.data!;
        if (tasks.isEmpty) {
          return SliverToBoxAdapter(
            child: Center(child: Text("No tasks", style: textTheme.titleLarge)),
          );
        }
        return SliverList.separated(
          separatorBuilder: (context, index) =>
              // Divider(height: MediaQuery.sizeOf(context).height * 0.02),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
          key: centerKey,
          itemCount: tasks.length,
          itemBuilder: (BuildContext context, int index) {
            final task = tasks[index];
            print("task: ${task.id}/${task.text}, isDone: ${task.isDone}");
            return Dismissible(
              // confirmDismiss: (direction) => async {},
              key: Key(task.id.toString()),
              onDismissed: (direction) async {
                await tasksController.delItem(task.id);

                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    shape: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.onInfo, width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    backgroundColor: AppColors.info,
                    content: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Text("Task:'${task.text}' => dissmissed"),
                    ),
                  ),
                );
              },
              background: DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColors.error,
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                child: SizedBox(),
              ),
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TaskCard(
                    isCompleted: task.isDone,
                    taskName: task.text,
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    onPressed: () => tasksController.toggleTaskDone(task),
                    // onToggle: (value) =>
                    //     setState(() => task.copyWith(isDone: value)),
                    dateTime: task.dateTime,
                    activeIcon: Icon(Icons.circle_outlined),
                    deactiveteIcon: Icon(Icons.check_circle_outline),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
