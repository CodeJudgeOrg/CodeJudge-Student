import 'package:code_judge_library/exercise_datamodel.dart';

/// Copyright 2026 Fabian Roland (naibaf-1)

/// Licensed under the Apache License, Version 2.0 (the "License");
/// you may not use this file except in compliance with the License.
/// You may obtain a copy of the License at

/// http://www.apache.org/licenses/LICENSE-2.0

/// Unless required by applicable law or agreed to in writing, software
/// distributed under the License is distributed on an "AS IS" BASIS,
/// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
/// See the License for the specific language governing permissions and
/// limitations under the License.

class MyExercises {
  final List<ExerciseDatamodel> exercises = [

    // Difficulty Level 0
    ExerciseDatamodel(
      id: 1,
      name: "Message Length Analyzer",
      description: "Basic string processing.",
      task: "A system receives the identifier string \"HelloWorld\". Determine how many characters this identifier contains and output the number.",
      solution: "10",
      difficultyLevel: 0,
    ),
    // Difficulty Level 1
    ExerciseDatamodel(
      id: 2,
      name: "Energy Pulse Calculation",
      description: "A basic mathematical operation involving exponentiation.",
      task: "In a physics simulation, a small energy pulse has an intensity of 12 units. The total energy released "
            "is defined as the square of this intensity. Calculate and output the resulting energy value.",
      solution: "144",
      difficultyLevel: 1,
      hint: "You only need to multiply the number by itself.",
    ),
    ExerciseDatamodel(
      id: 3,
      name: "Character Encoding Lookup",
      description: "Understanding ASCII encoding.",
      task: "In a low-level communication protocol, the character 'A' is transmitted. Determine the ASCII value of 'A' and output it.",
      solution: "65",
      difficultyLevel: 1,
    ),
    // Difficulty Level 2
    ExerciseDatamodel(
      id: 4,
      name: "Accumulated Workload",
      description: "Summation of a numerical series.",
      task: "A researcher records daily workload values from day 1 to day 50. Calculate the sum of all integers from 1 to 50 and output the result.",
      solution: "1275",
      difficultyLevel: 2,
      hint: "A loop or a mathematical formula can help you sum consecutive numbers.",
    ),
    ExerciseDatamodel(
      id: 5,
      name: "Sensor Data Averaging",
      description: "Working with multiple fixed numeric values.",
      task: "A measurement device produced the readings: 4, 18, 22, 9, and 17. Compute the average of these five values and output the "
            "result as a whole number.",
      solution: "14",
      difficultyLevel: 2,
    ),
    ExerciseDatamodel(
      id: 6,
      name: "Weather Station Conversion",
      description: "Applying a temperature conversion formula.",
      task: "A weather station reports a temperature of 68°F. Convert this value to Celsius using the standard formula and output the whole-number result.",
      solution: "20",
      difficultyLevel: 2,
      hint: "Use the formula: (°F - 32) × 5/9.",
    ),
    // Difficulty Level 3
    ExerciseDatamodel(
      id: 7,
      name: "Circular Field Area",
      description: "Applying geometric formulas.",
      task: "A circular field has a radius of 7 meters. Using π = 3.14159, calculate the area of the field. "
            "Round the result to the nearest whole number and output it.",
      solution: "154",
      difficultyLevel: 3,
    ),
    ExerciseDatamodel(
      id: 8,
      name: "Fibonacci Growth Model",
      description: "Working with a classical recursive sequence.",
      task: "A biological growth model follows the Fibonacci sequence, starting with 0 and 1. Determine the 10th Fibonacci number and output it.",
      solution: "55",
      difficultyLevel: 3,
      hint: "Each number is the sum of the previous two.",
    ),
    // Difficulty Level 4
    ExerciseDatamodel(
      id: 9,
      name: "Prime Distribution Analysis",
      description: "Algorithmic reasoning with number theory.",
      task: "A mathematical model requires knowing how many prime numbers exist between 1 and 30. Count all primes in this range and output the total.",
      solution: "10",
      difficultyLevel: 4,
    ),
    ExerciseDatamodel(
      id: 10,
      name: "Matrix Diagnostic Scan",
      description: "Working with two-dimensional data structures.",
      task: "A diagnostic system stores sensor readings in a 3×3 matrix: [[2,3,1],[4,5,6],[7,8,9]]. "
            "Calculate the sum of the main diagonal elements and output the result.",
      solution: "16",
      difficultyLevel: 4,
      hint: "The main diagonal uses indices [0][0], [1][1], [2][2].",
    ),
    ExerciseDatamodel(
      id: 11,
      name: "Array Rotation Mechanism",
      description: "Array manipulation and index shifting.",
      task: "Rotate the array [1, 2, 3, 4, 5, 6] three positions to the right. Output the resulting array as a comma-separated string.",
      solution: "4,5,6,1,2,3",
      difficultyLevel: 4,
      hint: "Elements moved off the end reappear at the beginning.",
    ),
    // Difficulty Level 5
    ExerciseDatamodel(
      id: 12,
      name: "Encrypted Transmission Decoder",
      description: "Decoding a Caesar cipher with character shifting.",
      task: "A satellite sends the encrypted message \"KHOORZRUOG\" using a Caesar cipher with a shift of +3. "
            "Decode the message by reversing the shift and output the original plaintext.",
      solution: "HELLOWORLD",
      difficultyLevel: 5,
      hint: "Shift each letter three positions backward. The alphabet wraps around.",
    ),
    ExerciseDatamodel(
      id: 13,
      name: "Lexicographical Sort Engine",
      description: "Implementing a sorting algorithm without built-in sort functions.",
      task: "A dataset contains the words: [\"zebra\", \"apple\", \"moon\", \"delta\", \"car\"]. Sort these words in ascending lexicographical "
            "order using your own sorting logic and output them as a single comma-separated string.",
      solution: "apple,car,delta,moon,zebra",
      difficultyLevel: 5,
      hint: "Compare strings character by character, similar to dictionary order.",
    ),
    ExerciseDatamodel(
      id: 14,
      name: "Maximum Frequency Analyzer",
      description: "A frequency-counting task requiring iteration and comparison.",
      task: "Given the string \"MISSISSIPPI\", determine which character appears most frequently. "
            "If multiple characters tie, output the alphabetically first one.",
      solution: "I",
      difficultyLevel: 5,
    ),
    ExerciseDatamodel(
      id: 15,
      name: "Binary Search Simulation",
      description: "Simulating a binary search on a fixed dataset.",
      task: "You are given the sorted array [3, 8, 15, 23, 42, 56, 78, 91]. Simulate a binary search for the value 42 and "
            "output the index where it is found. Use zero-based indexing.",
      solution: "4",
      difficultyLevel: 5,
      hint: "Binary search repeatedly halves the search interval.",
    ),
    ExerciseDatamodel(
      id: 16,
      name: "Checksum Validator",
      description: "A weighted summation task for validating numeric codes.",
      task: "A device generates the identification code \"57281\". Compute the checksum by multiplying each digit by its 1-based index "
            "(first digit × 1, second digit × 2, ...). Sum all products and output the checksum.",
      solution: "62",
      difficultyLevel: 5,
    ),
  ];

  List<ExerciseDatamodel> getAllExercises() => exercises;
}
