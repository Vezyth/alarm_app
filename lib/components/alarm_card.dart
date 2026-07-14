import 'package:alarm_app_2/models/alarm.dart';
import 'package:flutter/material.dart';

class AlarmCard extends StatelessWidget {
  final Alarm alarm;
  final void Function(bool) onToggle;
  final void Function(int) onDayTapped;
  Future<void> Function(String) onDismissed;

  AlarmCard({
    required this.alarm,
    required this.onToggle,
    required this.onDayTapped,
    required this.onDismissed,
  });

  @override
  final List<String> dayLabels = ["M", "T", "W", "T", "F", "S", "S"];

  final List<Color> dayColors = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.purple,
    Colors.pink,
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Dismissible(
        key: Key(alarm.id),
        onDismissed: (direction) {
          onDismissed(alarm.id);  
        },
        direction: DismissDirection.endToStart,
        background: Container(padding: EdgeInsets.only(right: 20), decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.red), child: Align(alignment: Alignment.centerRight,child: Icon(Icons.delete, color: Colors.white, ),),),
        child: Card(
          color: Colors.grey[900],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${alarm.hour.toString().padLeft(2, '0')}:${alarm.minute.toString().padLeft(2, '0')}",
                      style: TextStyle(color: Colors.white, fontSize: 42),
                    ),
                    Switch(
                      // This bool value toggles the switch.
                      value: alarm.isEnabled,
                      activeThumbColor: Colors.deepPurpleAccent,
                      onChanged: onToggle,
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Wrap(
                      spacing: 6,
                      children: List.generate(7, (i) {
                        final dayNumber = i + 1;
        
                        return GestureDetector(
                          onTap: () {
                            onDayTapped(dayNumber);
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: alarm.repeatDays.contains(dayNumber)
                                  ? dayColors[i]
                                  : dayColors[i].withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              dayLabels[i],
                              style: TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
