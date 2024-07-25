import 'package:flutter/material.dart';
import 'package:habit_tracker_app/components/my_dialog_box.dart';
import 'package:habit_tracker_app/components/my_habit_tile.dart';
import 'package:habit_tracker_app/database/habit_database.dart';
import 'package:habit_tracker_app/models/habit.dart';
import 'package:habit_tracker_app/themes/theme_provider.dart';
import 'package:habit_tracker_app/util/habit_util.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    Provider.of<HabitDatabase>(context, listen: false).readHabits();
  }

  final TextEditingController habitNameController = TextEditingController();
  MyDialogBox myDialogBox = MyDialogBox();

  void createNewHabit() {
    myDialogBox.displayDialog(
      context: context,
      content: TextField(
        controller: habitNameController,
        decoration: const InputDecoration(
            hintText: "Create a new habit", border: OutlineInputBorder()),
      ),
      textContoller: habitNameController,
       textBtn1: "Save",
      textBtn2: "Cancel",
      onPressBtn1: () {
        String habitName = habitNameController.text.trim();
        context.read<HabitDatabase>().addHabit(habitName);
      },
    );
  }

  void checkHabitOnOff(bool? value, Habit habit) {
    if (value != null) {
      context.read<HabitDatabase>().updateHabitCompletion(habit.id, value);
    }
  }

  void editHabit(Habit habit) {
    myDialogBox.displayDialog(
      context: context,
      content: TextField(
        controller: habitNameController,
        decoration: const InputDecoration(
            hintText: "Edit the habit", border: OutlineInputBorder()),
      ),
      textContoller: habitNameController,
       textBtn1: "Save",
      textBtn2: "Clear",
      onPressBtn1: () {
        String habitName = habitNameController.text.trim();
        context.read<HabitDatabase>().updateHabitName(habit.id, habitName);
      },
    );
  }

  void deleteHabit(Habit habit) {
    myDialogBox.displayDialog(
      context: context,
      content: const Text("Are you sure you want to delete"),
      textContoller: habitNameController,
      textBtn1: "Sure",
      textBtn2: "Cancel",
      onPressBtn1: () {
        context.read<HabitDatabase>().deleleHabit(habit.id);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Habit Buddy",
          style: TextStyle(
              fontFamily: 'Playwrite_HR_Lijeva',
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.inversePrimary),
        ),
        centerTitle: true,
        actions: [
          Provider.of<ThemeProvider>(context).isDarkMode
              ? IconButton(
                  icon: const Icon(Icons.light_mode),
                  onPressed: () {
                    Provider.of<ThemeProvider>(context, listen: false)
                        .toggleTheme();
                  },
                )
              : IconButton(
                  icon: const Icon(Icons.dark_mode),
                  onPressed: () {
                    Provider.of<ThemeProvider>(context, listen: false)
                        .toggleTheme();
                  },
                ),
        ],
      ),
      // drawer: MyDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewHabit,
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.secondary,
        child: const Icon(Icons.add),
      ),
      body: _buildHabitList(),
    );
  }

  Widget _buildHabitList() {
    final habitDatabase = context.watch<HabitDatabase>();

    List<Habit> currentHabits = habitDatabase.currentHabits;

    return ListView.builder(
        itemCount: currentHabits.length,
        itemBuilder: (context, index) {
          final habit = currentHabits[index];

          bool isCompletedToday = isHabitCompletedToday(habit.completedDays);

          return MyHabitTile(
            text: habit.name,
            isCompleted: isCompletedToday,
            onChanged: (value) => checkHabitOnOff(value, habit),
            editHabit: (p0) {
              editHabit(habit);
            },
            deleteHabit: (p0) {
              deleteHabit(habit);
            },
          );
        });
  }
}
