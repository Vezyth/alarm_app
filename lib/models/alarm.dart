class Alarm {
  final String id;
  final int hour;
  final int minute;
  final List<int> repeatDays;
  bool isEnabled;

  Alarm({
    required this.id,
    required this.hour,
    required this.minute,
    required this.repeatDays,
    this.isEnabled = true,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'hour': hour,
      'minute': minute,
      'repeatDays': repeatDays,
      'isEnabled': isEnabled,
    };
  }

  factory Alarm.fromJson(Map<String, dynamic> json) {
    return Alarm(
      id: json['id'],
      hour: json['hour'],
      minute: json['minute'],
      repeatDays: List<int>.from(json['repeatDays']),
      isEnabled: json['isEnabled'],
    );
  }
}
