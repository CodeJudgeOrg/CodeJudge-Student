#include "judger.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/wait.h>

// Pointers for returning errors
#define FILE_ERROR ((char*)1)
#define SYSTEM_ERROR (3)
#define MISSING_COMPILER_ERROR (-2)
#define COMPILATION_ERROR (2)

// Values for integers working as Booleans
#define TRUE (1)
#define FALSE (0)

// Struct handling the final result of running a programm
struct Judger{
    char* explanation;
    int score;
};

// If called this function receives 3 String and it returns one as soon as it's done
char* run_judge(const char* usersCode, const char* programmingLanguage, const char* solution) {
    char* fileName;

    // Perform the file generation, compilation depending on the used language
    if (strcmp(programmingLanguage, ".c") == 0) {
        // Write the users code into a file with the correct ending of the language he used
        fileName = writeFile(usersCode, programmingLanguage);
        if (fileName == FILE_ERROR){
            return "ERROR: Unable to generate the file (Code -1)";
        }

        // Call the compiler for the correct language and check for errors
        int compilation = callCompiler(fileName, "gcc %s -o UserProgramm 2> /dev/null");
        if (compilation == SYSTEM_ERROR) {
            return "ERROR: Calling system() didn't work (Code 3)";
        } else if (compilation == MISSING_COMPILER_ERROR) {
            return "ERROR: No compiler found (Code -2)";
        } else if (compilation == COMPILATION_ERROR) {
            return "ERROR: Error while compiling the code (Code 2)";
        }

        // Run and correct the programm
        runProgramAndCalculateTheScore(solution, "./UserProgramm");
    } else if (strcmp(programmingLanguage, ".java") == 0) {
        // Write the users code into a file with the correct ending of the language he used
        fileName = writeFile(usersCode, programmingLanguage);
        if (fileName == FILE_ERROR){
            return "ERROR: Unable to generate the file (Code -1)";
        }

        // Call the compiler for the correct language and check for errors
        int compilation = callCompiler(fileName, "javac %s 2> /dev/null");
        if (compilation == SYSTEM_ERROR) {
            return "ERROR: Calling system() didn't work (Code 3)";
        } else if (compilation == MISSING_COMPILER_ERROR) {
            return "ERROR: No compiler found (Code -2)";
        } else if (compilation == COMPILATION_ERROR) {
            return "ERROR: Error while compiling the code (Code 2)";
        }

        // Run and correct the programm
        runProgramAndCalculateTheScore(solution, "java UserCode");
    } else if (strcmp(programmingLanguage, ".py") == 0) {
        // Write the users code into a file with the correct ending of the language he used
        fileName = writeFile(usersCode, programmingLanguage);
        if (fileName == FILE_ERROR){
            return "ERROR: Unable to generate the file (Code -1)";
        }

        // Check at least whether the syntax is fine or not
        int interpretation = callCompiler(fileName, "python3 -m py_compile %s 2> /dev/null");
        if (interpretation == SYSTEM_ERROR) {
            return "ERROR: Calling system() didn't work (Code 3)";
        } else if (interpretation == MISSING_COMPILER_ERROR) {
            return "ERROR: No compiler found (Code -2)";
        } else if (interpretation == COMPILATION_ERROR) {
            return "ERROR: Error while compiling the code (Code 2)";
        }

        // Run and correct the programm
        runProgramAndCalculateTheScore(solution, "python3 UserCode.py");
    } else if (strcmp(programmingLanguage, ".cpp") == 0) {
        // Write the users code into a file with the correct ending of the language he used
        fileName = writeFile(usersCode, programmingLanguage);
        if (fileName == FILE_ERROR){
            return "ERROR: Unable to generate the file (Code -1)";
        }

        // Call the compiler for the correct language and check for errors
        int compilation = callCompiler(fileName, "g++ %s -o UserProgramm 2> /dev/null");
        if (compilation == SYSTEM_ERROR) {
            return "ERROR: Calling system() didn't work (Code 3)";
        } else if (compilation == MISSING_COMPILER_ERROR) {
            return "ERROR: No compiler found (Code -2)";
        } else if (compilation == COMPILATION_ERROR) {
            return "ERROR: Error while compiling the code (Code 2)";
        }

        // Run and correct the programm
        runProgramAndCalculateTheScore(solution, "./UserProgramm");
    } else {
        printf("ERROR: Undefined language (Code 1)\n");
        return "ERROR: Undefined language (Code 1)";
    }

    free(fileName);
    struct Judger result = runProgramAndCalculateTheScore("", "");
    return result.explanation;
}

// Generate a file and write its content
char* writeFile(char* content, char* ending){
    // Generate the correct file name depending on the langugae the user used
    size_t len = 8 + strlen(ending);
    char* fileName = malloc(len);
    strcpy(fileName, "UserCode");
    strcat(fileName, ending);

    // Generate a new file or override an existing one
    FILE *userFile = fopen(fileName, "w");
    if (userFile == NULL){
        printf("ERROR: Unable to generate the file (Code -1)\n");
        return FILE_ERROR;
    }
    
    // Write the content
    fputs(content, userFile);
    fclose(userFile);

    // Return the correct file name
    return fileName;
}

// Call the compiler and notice errors
int callCompiler(char* fileName, char* instruction){
    char cmd[256];
    snprintf(cmd, sizeof(cmd), instruction, fileName);

    int status = system(cmd);
    int exitCode = WEXITSTATUS(status);

    // Check whether the system() works
    if (status == -1) {
        printf("ERROR: Calling system() didn't work (Code 3)\n");
        return SYSTEM_ERROR;
    }

    // Check for errors and whether the compiler is installed or not
    if (exitCode != 0 && exitCode == 127) {
        printf("ERROR: No compiler found (Code -2)\n");
        return MISSING_COMPILER_ERROR;
    } else if (exitCode != 0) {
        printf("ERROR: Error while compiling the code (Code 2)\n");
        return COMPILATION_ERROR;
    }

    return 0;
}

// Run a programm and handle the errors
struct Judger runProgramAndCalculateTheScore(char* correctSolution, char* instruction) {
    struct Judger judger;

    int crashed = FALSE;
    char* result = malloc(2048);
    result[0] = '\0';

    // Try to start the programm and throw an error if it crashes
    FILE* pipe = popen(instruction, "r");
    if (!pipe) {
        crashed = TRUE;
        result = NULL;
        printf("ERROR: The programm crashed  (Code -3)\n");
    }

    // Receive the output
    if (crashed != TRUE){
        char buffer[256];
        while (fgets(buffer, sizeof(buffer), pipe)) {
            strcat(result, buffer);
        }
    }

    // Quit the programm and receive the exit code
    int status = pclose(pipe);

    // Check whether the programm crashed by checking the exit codes
    if (WIFSIGNALED(status)) {
        crashed = TRUE;
    } else {
        // If everything is fine return the correct Output
        crashed = FALSE;
    }

    // Calculate the score
    // 0 points if it crashed without an output
    if (result == NULL && crashed == TRUE) {
        judger.explanation = "The programm crashed without an output";
        judger.score = 0;
    // 25 points if crashed with wrong Output
    } else if (strcmp(result, correctSolution) != 0 && crashed == TRUE) {
        judger.explanation = "The programm crashed and it the output is wrong";
        judger.score = 25;
    // 50 points if crashed with correct Output
    } else if (strcmp(result, correctSolution) == 0 && crashed == TRUE) {
        judger.explanation = "The programm crashed, but the output is correct.";
        judger.score = 50;
    // 75 points if wrong Output but no crash
    } else if (strcmp(result, correctSolution) != 0 && crashed == FALSE) {
        judger.explanation = "The programm didn't crash, but the output is wrong.";
        judger.score = 75;
    // 100 points if correct Output without crashes
    } else {
        judger.explanation = "The programm ran successfully and the output is correct as well!";
        judger.score = 100;
    }

    free(result);
    return judger;
}
