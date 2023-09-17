import 'package:uuid/uuid.dart';

enum Category {
  career,
  health,
  home,
  planningLife,
  rest,
  sport,
  travel,
  finances,
  education,
  social,
  hobbies,
}

const Map<Category, String> categoryIcon = {
  Category.career: "assets/images/carrer.png",
  Category.health: "assets/images/health.png",
  Category.home: "assets/images/home.png",
  Category.planningLife: "assets/images/planning.png",
  Category.rest: "assets/images/rest.png",
  Category.sport: "assets/images/sport.png",
  Category.travel: "assets/images/travel.png",
  Category.finances: "assets/images/finance.png",
  Category.education: "assets/images/education.png",
  Category.social: "assets/images/social.png",
  Category.hobbies: "assets/images/hobbies.png",
};

class Todo {
  final String id;
  final String title;
  final Category category;
  int position;

  Todo({
    required this.title,
    required this.category,
    required this.id,
    this.position = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'category': category.toString(),
      'position': position,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'] as String,
      title: map['title'] as String,
      category: Category.values.firstWhere(
        (e) => e.toString() == map['category'] as String,
      ),
    );
  }

  factory Todo.create({
    required String title,
    required Category category,
  }) {
    final id = const Uuid().v4();
    return Todo(
      id: id,
      title: title,
      category: category,
    );
  }
}
