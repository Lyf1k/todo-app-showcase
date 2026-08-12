import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../core/theme/app_colors.dart';

class TaskCard extends StatelessWidget {
  final Color backgroundColor;
  final Future<void> Function() onPressed;

  final String taskName;
  final DateTime? dateTime;
  final bool isCompleted;
  final ValueChanged<bool> onToggle;
  final Icon activeIcon;
  final Icon deactiveteIcon;
  const TaskCard({
    super.key,
    required this.backgroundColor,
    required this.onPressed,
    this.taskName = " No name ...",
    this.dateTime,
    required this.isCompleted,
    required this.onToggle,
    required this.activeIcon,
    required this.deactiveteIcon,
  });
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: isCompleted
            ? Color.lerp(backgroundColor, Colors.grey, 0.2)
            : backgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(24)),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: IconButton(
              onPressed: () async {
                await onPressed();
                onToggle(!isCompleted);
              },
              icon: isCompleted ? deactiveteIcon : activeIcon,
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
                  taskName,
                  style: isCompleted
                      ? Theme.of(context).textTheme.bodyLarge?.copyWith(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey.shade500,
                        )
                      : Theme.of(context).textTheme.bodyLarge,
                  // softWrap: true,
                ),
              ),
              dateTime == null
                  ? SizedBox()
                  : AnimatedDefaultTextStyle(
                      duration: Duration(milliseconds: 1000),
                      style: TextStyle(
                        decoration: isCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        fontSize: 12,
                        color: isCompleted ? Colors.grey : AppColors.onInfo,
                      ),
                      curve: Curves.easeIn,
                      child: Text(
                        DateFormat("dd.MM.yyyy H:m").format(dateTime!),
                      ),
                    ),
            ],
          ),
        ],
      ),
    );
  }
}
