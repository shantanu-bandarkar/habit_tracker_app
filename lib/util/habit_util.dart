import 'package:habit_tracker_app/models/habit.dart';

bool isHabitCompletedToday(List<DateTime> completedDays) {
  final today = DateTime.now();
  return completedDays.any((date) =>
      date.year == today.year &&
      date.month == today.month &&
      date.day == today.day);
}


// prepare the heat map dataset

Map<DateTime,int> prepareHeatMapDataset(List<Habit> habits){
  Map<DateTime, int> dataset = {};

  for(var habit in habits) {
    for(var date in habit.completedDays) {
      //normalize date to abvoid time mismatch
      final normalizedDate = DateTime(date.year,date.month,date.day);
      print(normalizedDate);
      //if the date already exists in db, increment its counts
      if(dataset.containsKey(normalizedDate)){
        dataset[normalizedDate] = dataset[normalizedDate]! + 1;
      }
      else{
        dataset[normalizedDate] = 1;
      }
    }
  }
  return dataset;
}
