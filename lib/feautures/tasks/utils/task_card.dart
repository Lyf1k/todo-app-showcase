import 'package:flutter/material.dart';
import 'package:partfolio_app/core/theme/app_colors.dart';

class TaskCard extends StatefulWidget {
  final Color backgroundColor;
  final double width;
  final void Function()? onPressed;
  final String taskName;
  final String? dateTime;
  final bool isCompleted;
  const TaskCard({
    super.key,
    required this.backgroundColor,
    required this.width,
    required this.onPressed,
    this.taskName = " No name ...",
    this.dateTime,
    this.isCompleted = false,
  });

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  late bool isCompletedTask;

  @override
  void initState() {
    isCompletedTask = widget.isCompleted;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: isCompletedTask ? Color.lerp(widget.backgroundColor, Colors.grey, 0.2) : widget.backgroundColor,
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
                    isCompletedTask = !isCompletedTask;
                  });
                },
                icon: isCompletedTask ? Icon(Icons.check_box_outlined) : Icon(Icons.check_box_outline_blank),
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
                    style: isCompletedTask ? Theme.of(context).textTheme.bodyLarge?.copyWith(decoration: TextDecoration.lineThrough, color: Colors.grey.shade500) : Theme.of(context).textTheme.bodyLarge,
                    // softWrap: true,
                  ),
                ),
                widget.dateTime == null || widget.dateTime == "null" ? SizedBox() : AnimatedDefaultTextStyle(duration: Duration(milliseconds: 1000), style: TextStyle(  decoration: isCompletedTask ? TextDecoration.lineThrough : TextDecoration.none, fontSize: 12, color: isCompletedTask ? Colors.grey : AppColors.onInfo), curve: Curves.easeIn, child:Text("${widget.dateTime}"),
                      )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
