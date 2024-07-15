import 'package:flutter/cupertino.dart';
import 'package:habit_tracker_app/models/app_setting.dart';
import 'package:habit_tracker_app/models/habit.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class HabitDatabase extends ChangeNotifier {
  static late Isar isar;

  /*

  SETUP

  */

  //Init DB
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar =
        await Isar.open([HabitSchema, AppSettingSchema], directory: dir.path);
  }

  //Save first date of app startup
  Future<void> saveFirstLaunchDate() async {
    final existingSettings = await isar.appSettings.where().findFirst();
    if (existingSettings == null) {
      final settings = AppSetting()..firstLaunchDate = DateTime.now();
      await isar.writeTxn(() => isar.appSettings.put(settings));
    }
  }

  //get first date of app startup
  Future<DateTime?> getFirstLaunchDate() async {
    final settings = await isar.appSettings.where().findFirst();
    return settings?.firstLaunchDate;
  }

  /* CRUD OPERATIONS
  */

  //List of habits
  final List<Habit> currentHabits = [];

  //create - add a new habit
  Future<void> addHabit(String habitName) async {
    //create new habit
    final newHabit = Habit()..name = habitName;

    //save to db

    await isar.writeTxn(() => isar.habits.put(newHabit));

    //re-read from db
    readHabits();
  }

  //read - read saved habits
  Future<void> readHabits() async {
    //fetch all habits from db
    List<Habit> fetchedHabits = await isar.habits.where().findAll();

    //give to current local habitList
    currentHabits.clear();
    currentHabits.addAll(fetchedHabits);

    //updateUI
    notifyListeners();
  }

  //update - check habit on and off
  Future<void> updateHabitCompletion(int id, bool isCompleted) async{
    final habit = await isar.habits.get(id);

    if (habit != null) {
      await isar.writeTxn(() async{
        //if habit is completed -> add the current date to the completedDays List
        if(isCompleted && !habit.completedDays.contains(DateTime.now())){
          final today = DateTime.now();

          //add the current date if it's not already in the list
          habit.completedDays.add(DateTime(today.year,today.month,today.day));
        }
        //if habit in NOT completed -> remove the current date form the list
        else {
          //remove the current date if the habit is marked as not completed
          habit.completedDays.removeWhere((date)=>date.year ==DateTime.now().year && date.month ==DateTime.now().month && date.day ==DateTime.now().day);
        }

        //save the updated habits to the db
        await isar.habits.put(habit);
      });
    }
    //re-read from the db
    readHabits();
  }

  //update - edit habit name
  Future<void> updateHabitName(int id, String newName) async {
    //find the specific habit
    final habit = await isar.habits.get(id);

    //update habit name
    if(habit != null) {
      //update name
      await isar.writeTxn(() async{
        habit.name = newName;
        //save updated habit back to the db
        await isar.habits.put(habit);
      });
    }
    //re-read
    readHabits();
  }

  //delete - delele a habit
  Future<void> deleleHabit(int id) async {
    //perform the deletion
    await isar.writeTxn(() async{
      await isar.habits.delete(id);
    });
  //re-read
  readHabits();
  }
}
