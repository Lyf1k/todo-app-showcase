import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:partfolio_app/feautures/tasks/domain/entity/tasks.dart';
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
              IconButton.outlined(
                onPressed: () async {
                  await tasksController.delAllItems();
                  // await tasksController.loadData();
                },
                icon: Icon(Icons.delete),
              ),
              IconButton(
                onPressed: () async {
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
            bottom:
                MediaQuery.viewInsetsOf(context).bottom +
                MediaQuery.of(context).size.height * 0.025,
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
    return Column(
      children: [
        ?dateTime != null
            ? DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  border: Border.all(
                    color: CupertinoColors.inactiveGray,
                    width: 0.0,
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
        TextFormField(
          controller: todosNameController,
          autofocus: true,
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
                  onPressed: _canSave
                      ? () {
                          final newTask = Tasks(
                            id: DateTime.now().microsecondsSinceEpoch,
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
  _TaskCards({super.key});

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
          return SliverToBoxAdapter(
            child: Center(
              child: Text(
                "No tasks",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
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
                      child: Text("${task.text} dissmissed"),
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
                    backgroundColor: AppColors.surface,
                    onPressed: () => tasksController.toggleDoneTask(task),
                    onToggle: (value) =>
                        setState(() => task.copyWith(isDone: value)),
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
