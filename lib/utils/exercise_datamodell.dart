// This defines which values an exercise has
class ExerciseDatamodell {
  final String name;
  final String description;
  final String task;
  final String solution;
  final int difficultyLevel;

  ExerciseDatamodell({
    required this.name,
    required this.description,
    required this.task,
    required this.solution,
    required this.difficultyLevel
  });
}
