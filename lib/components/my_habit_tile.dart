import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MyHabitTile extends StatelessWidget {
  final String text;
  final bool isCompleted;
  final void Function(bool?)? onChanged;
  final void Function(BuildContext)? editHabit;
  final void Function(BuildContext)? deleteHabit;
  const MyHabitTile(
      {super.key,
      required this.text,
      required this.isCompleted,
      required this.onChanged,
      required this.editHabit,
      required this.deleteHabit});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: editHabit,
              icon: Icons.edit,
              backgroundColor: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(8),
            ),
            const SizedBox(width: 4,),
            SlidableAction(
              onPressed: deleteHabit,
              icon: Icons.delete,
              backgroundColor: Colors.red,
              borderRadius: BorderRadius.circular(8),
            ),
          ],
        ),
        child: GestureDetector(
          onTap: () {
            if (onChanged != null) {
              onChanged!(!isCompleted);
            }
          },
          child: Container(
            decoration: BoxDecoration(
                color: isCompleted
                    ? Colors.green
                    : Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.all(12),
            child: ListTile(
              title: Text(text,style: TextStyle(color: isCompleted
                    ? Colors.white
                    : Theme.of(context).colorScheme.inversePrimary,),),
              leading: Checkbox(
                activeColor: Colors.green,
                checkColor: Colors.black,
                value: isCompleted,
                onChanged: onChanged,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
