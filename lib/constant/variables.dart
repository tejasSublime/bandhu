import 'package:bandhu/api/ask_give_api.dart';
import 'package:bandhu/model/user_model.dart';
// ignore: unused_import
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// server endpoint
// Main Server
const baseUrl = "http://5.189.156.172/BNI";

// localHost
// const baseUrl = "http://192.168.0.161/BNI_25oct18/BNI_25oct18";

const defaultprofileImage = "assets/images/default.png";
final StateProvider<User> userDataProvider = StateProvider<User>(
    (ref) => User(email: "", name: "", userid: "", image: "", phone: ""));

final screenIndexProvider = StateProvider((ref) => 0);
final selectedWeekProvider = StateProvider((ref) {
  DateTime date = DateTime.now();
  int firstDayOfMonthWeekday = DateTime(date.year, date.month, 1).weekday;
  int adjustedDayOfMonth = date.day + firstDayOfMonthWeekday - 1;
  return (adjustedDayOfMonth / 7).ceil();
});
final selectedDateTimeProvider = StateProvider((ref) => DateTime.now());
final TextEditingController searchController = TextEditingController();

final listViewDataProvider = FutureProvider((ref) async => await AskGive()
    .getAskGive(
        id: ref.read(userDataProvider).userid,
        month:
            "${ref.read(selectedDateTimeProvider).year}-${ref.read(selectedDateTimeProvider).month}"));

final gridViewDataProvider = FutureProvider((ref) async => await AskGive()
    .getAskGiveByMonth(
        id: ref.watch(userDataProvider).userid,
        // week: ref.watch(selectedWeekProvider),
        month:
            "${ref.read(selectedDateTimeProvider).year}-${ref.read(selectedDateTimeProvider).month}"));

final memberListProvider = FutureProvider((ref) async {
  return await AskGive().getMembers(search: searchController.text);
});
