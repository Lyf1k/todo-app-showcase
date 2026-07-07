import 'package:flutter/material.dart';

class TaskCard extends StatefulWidget {
  final Color backgroundColor;
  final double width;
  final void Function()? onPressed;
  final String taskName;
  final String dateTime;
  const TaskCard({
    super.key,
    required this.backgroundColor,
    required this.width,
    required this.onPressed,
    this.taskName = "Task ...",
    required this.dateTime,
  });

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  late bool isCompleted;

  @override
  void initState() {
    // TODO: implement initState
    isCompleted = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(24)),
      ),
      child: SizedBox(
        width: widget.width,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: IconButton(
                onPressed: () {
                  setState(() {
                    isCompleted = !isCompleted;
                  });
                },
                icon: isCompleted ? Icon(Icons.task) : Icon(Icons.add_task),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.4,
                  child: Text(
                    // maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    widget.taskName,
                    style: Theme.of(context).textTheme.bodyLarge,
                    // softWrap: true,
                  ),
                ),
                Text(
                  // "${DateTime.now().month} ${DateTime.now().day}, ${DateTime.now().year}, ${DateTime.now().hour}:${DateTime.now().minute}",
                  widget.dateTime,
                  style: isCompleted
                      ? Theme.of(context).textTheme.bodyLarge
                      : Theme.of(
                          context,
                        ).textTheme.bodyLarge!.copyWith(fontSize: 18),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
