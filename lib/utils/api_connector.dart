import 'dart:convert';

import 'package:code_judge/utils/my_provider.dart';
import 'package:code_judge_library/datamodels.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ApiConnector {
  // Always use the same instance
  static final ApiConnector instance = ApiConnector.internal();
  factory ApiConnector() => instance;
  ApiConnector.internal();

  final String baseURL = "http://127.0.0.1:8000/student";

  // Download all exercises and update the list
  void receiveExercises(BuildContext context) async {
    final url = Uri.parse("$baseURL/retrieveExercises");

    final response = await http.get(url);
    final List<dynamic> decodedResponse = jsonDecode(response.body);

    // Convert the result into a list of exercises
    final List<ExerciseDatamodel> receivedExercises = decodedResponse.map((item) {
      return ExerciseDatamodel(
        id: item["id"],
        name: item["name"],
        description: item["description"],
        task: item["task"],
        solution: item["solution"],
        difficultyLevel: item["difficulty"],
        hint: item["hint"] ?? "",
      );
    }).toList();

    // Update the list
    context.read<ExerciseProvider>().updateExercises(receivedExercises);
  }

  // Upload submissions
  void uploadSubmission(BuildContext context, SubmissionDatamodel submission) async {
    final url = Uri.parse("$baseURL/uploadSubmissions");

    // Encode the code correctly
    final encodedCode = base64Encode(utf8.encode(submission.code));

    http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode([{
        "exerciseName": submission.exerciseName,
        "task": submission.task,
        "code": encodedCode,
        "output": submission.output,
        "studentName": submission.studentName,
      }]),
    );

    // Move the exercise to the submission Page
    context.read<SubmissionProvider>().addSubmission(SubmissionDatamodel(
      exerciseName: submission.exerciseName,
      task: submission.task,
      code: submission.code,
      output: submission.output,
      studentName: submission.studentName
    ));
  }
}

// TODO: Improve error handling and display a SnackBar!