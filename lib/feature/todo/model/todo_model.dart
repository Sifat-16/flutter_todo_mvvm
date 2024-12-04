class TodoModel {
  int? id;
  String title;
  bool isSelected;
  String? hexColor;
  TodoModel({this.id, required this.title, this.isSelected = false, this.hexColor});

  // Convert TodoModel to a map for database operations
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'isSelected': isSelected ? 1 : 0, // Convert bool to int for SQLite
      'hexColor': hexColor,
    };
  }

  // Create TodoModel from a map (database row)
  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      id: map['id'] as int?,
      title: map['title'] as String,
      isSelected: map['isSelected'] == 1, // Convert int to bool
      hexColor: map['hexColor'] as String?,
    );
  }
}
