import 'package:code_juge/utils/exercise_datamodell.dart';

class MyExercises {
  final List<ExerciseDatamodell> exercises = [

    ExerciseDatamodell(
      name: "Energy Pulse Calculation",
      description: "A basic mathematical operation involving exponentiation.",
      task: "In a physics simulation, a small energy pulse has an intensity value of 12 units. "
            "The total energy released is defined as the square of this intensity. "
            "Calculate the energy released and output the resulting value.",
      solution: "144",
      difficultyLevel: 1,
      hint: "You only need to multiply the number by itself.",
    ),
    ExerciseDatamodell(
      name: "Accumulated Workload",
      description: "Summation of a numerical series.",
      task: "A researcher records daily workload values from day 1 to day 50. "
            "To estimate the total effort, calculate the sum of all integers from 1 to 50 and output the result.",
      solution: "1275",
      difficultyLevel: 2,
      hint: "A loop or a mathematical formula can help you sum consecutive numbers.",
    ),
    ExerciseDatamodell(
      name: "Sensor Data Averaging",
      description: "Working with multiple fixed numeric values.",
      task: "A measurement device produced the following readings: 4, 18, 22, 9, and 17. "
            "To smooth out fluctuations, compute the average of these five values and output the result as a whole number.",
      solution: "14",
      difficultyLevel: 2,
    ),
    ExerciseDatamodell(
      name: "Weather Station Conversion",
      description: "Applying a temperature conversion formula.",
      task: "A weather station reports a temperature of 68°F. "
            "Convert this value to Celsius using the standard formula and output the result as a whole number.",
      solution: "20",
      difficultyLevel: 2,
      hint: "Use the formula: 1°C = (1°F - 32) × 5/9.",
    ),
    ExerciseDatamodell(
      name: "Circular Field Area",
      description: "Applying geometric formulas.",
      task: "A circular field has a radius of 7 meters. Using π = 3.14159, calculate the area of the field. "
            "Round the result to the nearest whole number and output it.",
      solution: "154",
      difficultyLevel: 3,
    ),
    ExerciseDatamodell(
      name: "Message Length Analyzer",
      description: "Basic string processing.",
      task: "A system receives the identifier string \"HelloWorld\". "
            "Determine how many characters this identifier contains and output the number.",
      solution: "10",
      difficultyLevel: 1,
    ),
    ExerciseDatamodell(
      name: "Character Encoding Lookup",
      description: "Understanding ASCII encoding.",
      task: "In a low-level communication protocol, the character 'A' is transmitted. "
            "Determine the ASCII value of 'A' and output it.",
      solution: "65",
      difficultyLevel: 1,
    ),
    ExerciseDatamodell(
      name: "Fibonacci Growth Model",
      description: "Working with a classical recursive sequence.",
      task: "A biological growth model follows the Fibonacci sequence, starting with 0 and 1. "
            "Determine the 10th Fibonacci number and output it.",
      solution: "55",
      difficultyLevel: 3,
      hint: "Each number is the sum of the previous two.",
    ),
    ExerciseDatamodell(
      name: "Prime Distribution Analysis",
      description: "Algorithmic reasoning with number theory.",
      task: "A mathematical model requires knowing how many prime numbers exist between 1 and 30. "
            "Count all primes in this range and output the total.",
      solution: "10",
      difficultyLevel: 4,
    ),
    ExerciseDatamodell(
      name: "Matrix Diagnostic Scan",
      description: "Working with two-dimensional data structures.",
      task: "A diagnostic system stores sensor readings in a 3×3 matrix: "
            "[[2,3,1],[4,5,6],[7,8,9]]. "
            "Calculate the sum of the main diagonal elements and output the result.",
      solution: "16",
      difficultyLevel: 4,
      hint: "The main diagonal uses indices [0][0], [1][1], [2][2].",
    ),
    ExerciseDatamodell(
      name: "Encrypted Transmission Decoder",
      description: "A challenging task involving character shifting and basic cryptographic transformation.",
      task: "A satellite sends the encrypted message \"KHOORZRUOG\" using a Caesar cipher with a shift of +3. "
            "Write a program that decodes the message by reversing the shift and outputs the original plaintext.",
      solution: "HELLOWORLD",
      difficultyLevel: 5,
      hint: "In a Caesar cipher with a shift of +3, each letter in the encrypted text was moved three positions forward in the alphabet. "
            "To decode it, shift each letter three positions backward (e.g., D → A, E → B). "
            "Remember that the alphabet wraps around.",
    ),
    ExerciseDatamodell(
      name: "Lexicographical Sort Engine",
      description: "Implementing a sorting algorithm without relying on built-in sort functions.",
      task: "A dataset contains the following words: [\"zebra\", \"apple\", \"moon\", \"delta\", \"car\"]. "
            "Sort these words in ascending lexicographical order using your own sorting logic and output them "
            "as a single string separated by commas.",
      solution: "apple,car,delta,moon,zebra",
      difficultyLevel: 5,
      hint: "Compare strings character by character, similar to dictionary order.",
    ),
    ExerciseDatamodell(
      name: "Maximum Frequency Analyzer",
      description: "A frequency-counting task requiring iteration and comparison logic.",
      task: "Given the string \"MISSISSIPPI\", determine which character appears most frequently. "
            "If multiple characters have the same highest frequency, output the alphabetically first one. "
            "Output only the character.",
      solution: "I",
      difficultyLevel: 5,
    ),
    ExerciseDatamodell(
      name: "Binary Search Simulation",
      description: "Simulating a binary search manually on a fixed dataset.",
      task: "You are given the sorted array [3, 8, 15, 23, 42, 56, 78, 91]. "
            "Simulate a binary search for the value 42 and output the index at which it is found. "
            "Use zero-based indexing.",
      solution: "4",
      difficultyLevel: 5,
      hint: "Binary search repeatedly halves the search interval.",
    ),
    ExerciseDatamodell(
      name: "Array Rotation Mechanism",
      description: "A task involving array manipulation and index shifting.",
      task: "Rotate the array [1, 2, 3, 4, 5, 6] three positions to the right. "
            "Output the resulting array as a comma-separated string.",
      solution: "4,5,6,1,2,3",
      difficultyLevel: 4,
      hint: "Elements moved off the end reappear at the beginning.",
    ),
    ExerciseDatamodell(
      name: "Checksum Validator",
      description: "A more advanced algorithmic task involving weighted summation.",
      task: "A device generates the identification code \"57281\". "
            "To validate it, compute the checksum by multiplying each digit by its 1-based index "
            "(first digit × 1, second digit × 2, ...). "
            "Sum all products and output the checksum.",
      solution: "62",
      difficultyLevel: 5,
    ),
  ];

  List<ExerciseDatamodell> getAllExercises() => exercises;
}
