import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:partfolio_app/core/theme/app_colors.dart';
import 'package:partfolio_app/feautures/tasks/utils/task_card.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() => _TasksScreen();
}

class _TasksScreen extends State<TasksScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.sizeOf(context).width * 0.02,
                  top: MediaQuery.sizeOf(context).width * 0.02,
                ),
                child: SvgPicture.asset('assets/Component 1.svg'),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.sizeOf(context).width * 0.02,
                  right: MediaQuery.sizeOf(context).width * 0.01,
                ),
                child: IconButton.filled(
                  onPressed: () {},
                  icon: Icon(Icons.logout),
                ),
              ),
            ],
          ),
        ),
        // elevation: 20,
        // shape: BoxBorder.fromBorderSide(BorderSide(color: Colors.black)),
        shape: BoxBorder.fromLTRB(bottom: BorderSide(width: 2)),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            top: MediaQuery.sizeOf(context).height * 0.02,
            left: MediaQuery.sizeOf(context).height * 0.02,
            right: MediaQuery.sizeOf(context).height * 0.02,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "All to-dos",
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                ),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
                TaskCard(
                  taskName:
                      "some texte some texte some texte some texte some texte some texte some texte some texte some texte some texte ",
                  backgroundColor: AppColors.surface,
                  width: MediaQuery.sizeOf(context).width,
                  onPressed: () {},
                  dateTime:
                      '${DateTime.now().month} ${DateTime.now().day}, ${DateTime.now().year}, ${DateTime.now().hour}:${DateTime.now().minute}',
                ),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
                TaskCard(
                  backgroundColor: AppColors.surface,
                  width: MediaQuery.sizeOf(context).width,
                  onPressed: () {},
                  dateTime:
                      '${DateTime.now().month} ${DateTime.now().day}, ${DateTime.now().year}, ${DateTime.now().hour}:${DateTime.now().minute}',
                ),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
                TaskCard(
                  backgroundColor: AppColors.surface,
                  width: MediaQuery.sizeOf(context).width,
                  onPressed: () {},
                  dateTime:
                      '${DateTime.now().month} ${DateTime.now().day}, ${DateTime.now().year}, ${DateTime.now().hour}:${DateTime.now().minute}',
                ),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
                TaskCard(
                  backgroundColor: AppColors.surface,
                  width: MediaQuery.sizeOf(context).width,
                  onPressed: () {},
                  dateTime:
                      '${DateTime.now().month} ${DateTime.now().day}, ${DateTime.now().year}, ${DateTime.now().hour}:${DateTime.now().minute}',
                ),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
                TaskCard(
                  backgroundColor: AppColors.surface,
                  width: MediaQuery.sizeOf(context).width,
                  onPressed: () {},
                  dateTime:
                      '${DateTime.now().month} ${DateTime.now().day}, ${DateTime.now().year}, ${DateTime.now().hour}:${DateTime.now().minute}',
                ),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
                TaskCard(
                  backgroundColor: AppColors.surface,
                  width: MediaQuery.sizeOf(context).width,
                  onPressed: () {},
                  dateTime:
                      '${DateTime.now().month} ${DateTime.now().day}, ${DateTime.now().year}, ${DateTime.now().hour}:${DateTime.now().minute}',
                ),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
                TaskCard(
                  backgroundColor: AppColors.surface,
                  width: MediaQuery.sizeOf(context).width,
                  onPressed: () {},
                  dateTime:
                      '${DateTime.now().month} ${DateTime.now().day}, ${DateTime.now().year}, ${DateTime.now().hour}:${DateTime.now().minute}',
                ),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
                TaskCard(
                  backgroundColor: AppColors.surface,
                  width: MediaQuery.sizeOf(context).width,
                  onPressed: () {},
                  dateTime:
                      '${DateTime.now().month} ${DateTime.now().day}, ${DateTime.now().year}, ${DateTime.now().hour}:${DateTime.now().minute}',
                ),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
                TaskCard(
                  backgroundColor: AppColors.surface,
                  width: MediaQuery.sizeOf(context).width,
                  onPressed: () {},
                  dateTime:
                      '${DateTime.now().month} ${DateTime.now().day}, ${DateTime.now().year}, ${DateTime.now().hour}:${DateTime.now().minute}',
                ),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
                TaskCard(
                  backgroundColor: AppColors.surface,
                  width: MediaQuery.sizeOf(context).width,
                  onPressed: () {},
                  dateTime:
                      '${DateTime.now().month} ${DateTime.now().day}, ${DateTime.now().year}, ${DateTime.now().hour}:${DateTime.now().minute}',
                ),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
                TaskCard(
                  backgroundColor: AppColors.surface,
                  width: MediaQuery.sizeOf(context).width,
                  onPressed: () {},
                  dateTime:
                      '${DateTime.now().month} ${DateTime.now().day}, ${DateTime.now().year}, ${DateTime.now().hour}:${DateTime.now().minute}',
                ),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
                TaskCard(
                  backgroundColor: AppColors.surface,
                  width: MediaQuery.sizeOf(context).width,
                  onPressed: () {},
                  dateTime:
                      '${DateTime.now().month} ${DateTime.now().day}, ${DateTime.now().year}, ${DateTime.now().hour}:${DateTime.now().minute}',
                ),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
