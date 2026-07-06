import 'package:alarm_app_2/models/alarm.dart';
import 'package:flutter/material.dart';

class AlarmCard extends StatelessWidget {
  final Alarm alarm;
  final void Function(bool) onToggle;
  final void Function(int) onDayTapped;

  AlarmCard({
    required this.alarm,
    required this.onToggle,
    required this.onDayTapped,
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
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.grey[900],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
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
    );
  }
}
