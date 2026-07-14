import 'dart:convert';

import 'package:alarm_app_2/components/alarm_card.dart';
import 'package:alarm_app_2/models/alarm.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Alarm> alarms = [];

  Future<void> loadAlarms() async {
    final prefs = await SharedPreferences.getInstance();

    final String? jsonString = prefs.getString("alarms");

    if (jsonString == null) {
      return;
    }
    final decoded = jsonDecode(jsonString);
    final loadedAlarms = (decoded as List)
        .map((json) => Alarm.fromJson(json as Map<String, dynamic>))
        .toList();

    setState(() {
      alarms.clear();
      alarms.addAll(loadedAlarms);
    });
  }

  Future<void> saveAlarms() async {
    final prefs = await SharedPreferences.getInstance();
    final alarmMaps = alarms.map((alarm) => alarm.toJson()).toList();
    final jsonString = jsonEncode(alarmMaps);

    await prefs.setString("alarms", jsonString);
  }

  @override
  void initState() {
    super.initState();

    loadAlarms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0D1B2A),
      appBar: AppBar(actions: const [], backgroundColor: Colors.transparent),
      body: alarms.isEmpty
          ? const Center(
              child: Text(
                "No Alarm Yet",
                style: TextStyle(color: Colors.white54),
              ),
            )
          : ListView.builder(
              itemCount: alarms.length,
              itemBuilder: (context, index) {
                return AlarmCard(
                  alarm: alarms[index],
                  onToggle: (bool value) async {
                    setState(() {
                      alarms[index].isEnabled = value;
                    });
                    await saveAlarms();
                  },
                  onDayTapped: (day) async {
                    setState(() {
                      alarms[index].repeatDays.contains(day)
                          ? alarms[index].repeatDays.remove(day)
                          : alarms[index].repeatDays.add(day);
                    });
                    await saveAlarms();
                  },
                    onDismissed: (String id) async {
                      setState(() {
                        alarms.removeWhere((alarm) {
                          return alarm.id == id;
                        });
                      });
                      await saveAlarms(); 
                    },
                  );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurpleAccent,
        child: const Icon(Icons.add),
        onPressed: () async {
          final TimeOfDay? pickedTime = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
          );

          if (pickedTime != null) {
            setState(() {
              alarms.add(
                Alarm(
                  id: (alarms.length + 1).toString(),
                  hour: pickedTime.hour,
                  minute: pickedTime.minute,
                  repeatDays: [],
                ),
              );
            });
            await saveAlarms();
          }
        },
      ),
    );
  }
}
