class Habit {
  final String id;
  final String name;
  final String category;
  final int colorValue;
  final String icon;
  final DateTime createdAt;
  final Map<String, bool> history;

  Habit({
    required this.id,
    required this.name,
    required this.category,
    required this.colorValue,
    required this.icon,
    required this.createdAt,
    required this.history,
  });

  bool isCompletedOn(String dateStr) {
    return history[dateStr] ?? false;
  }

  Habit copyWith({
    String? id,
    String? name,
    String? category,
    int? colorValue,
    String? icon,
    DateTime? createdAt,
    Map<String, bool>? history,
  }) {
    return Habit(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      colorValue: colorValue ?? this.colorValue,
      icon: icon ?? this.icon,
      createdAt: createdAt ?? this.createdAt,
      history: history ?? Map<String, bool>.from(this.history),
    );
  }

}
