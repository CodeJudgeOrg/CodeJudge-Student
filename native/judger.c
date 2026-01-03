#include "judger.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Additional for windows support
#ifdef _WIN32
#include <windows.h>
#define popen _popen
#define pclose _pclose
#else
#include <sys/wait.h>
#endif

// Pointers for returning errors
#define FILE_ERROR ((char*)1)
#define SYSTEM_ERROR (3)
#define MISSING_COMPILER_ERROR (-2)
#define COMPILATION_ERROR (2)

// Values for integers working as Booleans
#define TRUE (1)
#define FALSE (0)

// If called this function receives 3 String and it returns one as soon as it's done
char* runJudge(const char* usersCode, const char* programmingLanguage, const char* solution) {
    char* fileName = NULL;
    char* result;

    // Perform the file generation, compilation depending on the used language
    if (strcmp(programmingLanguage, ".c") == 0) {
        // Write the users code into a file with the correct ending of the language he used
        fileName = writeFile(usersCode, programmingLanguage);
        if (fileName == FILE_ERROR){
            //free(fileName);
            return "ERROR: Unable to generate the file (Code -1)";
        }

        // Call the compiler for the correct language and check for errors
#ifdef _WIN32
        int compilation = callCompiler(fileName, "gcc %s -o UserProgramm.exe 2> NUL");
#else
        int compilation = callCompiler(fileName, "gcc %s -o UserProgramm 2> /dev/null");
#endif
        if (compilation == SYSTEM_ERROR) {
            free(fileName);
            return "ERROR: Calling system() didn't work (Code 3)";
        } else if (compilation == MISSING_COMPILER_ERROR) {
            free(fileName);
            return "ERROR: No compiler found (Code -2)";
        } else if (compilation == COMPILATION_ERROR) {
            free(fileName);
            return "ERROR: Error while compiling the code (Code 2)";
        }

        // Run and correct the programm
#ifdef _WIN32
        result = runProgramAndCalculateTheScore((char*)solution, "UserProgramm.exe");
#else
        result = runProgramAndCalculateTheScore((char*)solution, "./UserProgramm");
#endif
    } else if (strcmp(programmingLanguage, ".go") == 0) {
        // Write the users code into a file with the correct ending of the language he used
        fileName = writeFile(usersCode, programmingLanguage);
        if (fileName == FILE_ERROR){
            //free(fileName);
            return "ERROR: Unable to generate the file (Code -1)";
        }

        // Call the compiler for the correct language and check for errors
        int compilation = callCompiler(fileName, "GO111MODULE=off go build -o UserProgramm %s");
        if (compilation == SYSTEM_ERROR) {
            free(fileName);
            return "ERROR: Calling system() didn't work (Code 3)";
        } else if (compilation == MISSING_COMPILER_ERROR) {
            free(fileName);
            return "ERROR: No compiler found (Code -2)";
        } else if (compilation == COMPILATION_ERROR) {
            free(fileName);
            return "ERROR: Error while compiling the code (Code 2)";
        }

        // Run and correct the programm
#ifdef _WIN32
        result = runProgramAndCalculateTheScore((char*)solution, "UserProgramm.exe");
#else
        result = runProgramAndCalculateTheScore((char*)solution, "./UserProgramm");
#endif
    } else if (strcmp(programmingLanguage, ".py") == 0) {
        // Write the users code into a file with the correct ending of the language he used
        fileName = writeFile(usersCode, programmingLanguage);
        if (fileName == FILE_ERROR){
            //free(fileName);
            return "ERROR: Unable to generate the file (Code -1)";
        }

        // Check at least whether the syntax is fine or not
#ifdef _WIN32
        int interpretation = callCompiler(fileName, "python -m py_compile %s 2> NUL");
#else
        int interpretation = callCompiler(fileName, "python3 -m py_compile %s 2> /dev/null");
#endif
        if (interpretation == SYSTEM_ERROR) {
            free(fileName);
            return "ERROR: Calling system() didn't work (Code 3)";
        } else if (interpretation == MISSING_COMPILER_ERROR) {
            free(fileName);
            return "ERROR: No compiler found (Code -2)";
        } else if (interpretation == COMPILATION_ERROR) {
            free(fileName);
            return "ERROR: Error while compiling the code (Code 2)";
        }

        // Run and correct the programm
#ifdef _WIN32
        result = runProgramAndCalculateTheScore((char*)solution, "python UserCode.py");
#else
        result = runProgramAndCalculateTheScore((char*)solution, "python3 UserCode.py");
#endif
    } else if (strcmp(programmingLanguage, ".cpp") == 0) {
        // Write the users code into a file with the correct ending of the language he used
        fileName = writeFile(usersCode, programmingLanguage);
        if (fileName == FILE_ERROR){
            //free(fileName);
            return "ERROR: Unable to generate the file (Code -1)";
        }

        // Call the compiler for the correct language and check for errors
#ifdef _WIN32
        int compilation = callCompiler(fileName, "g++ %s -o UserProgramm.exe 2> NUL");
#else
        int compilation = callCompiler(fileName, "g++ %s -o UserProgramm 2> /dev/null");
#endif
        if (compilation == SYSTEM_ERROR) {
            free(fileName);
            return "ERROR: Calling system() didn't work (Code 3)";
        } else if (compilation == MISSING_COMPILER_ERROR) {
            free(fileName);
            return "ERROR: No compiler found (Code -2)";
        } else if (compilation == COMPILATION_ERROR) {
            free(fileName);
            return "ERROR: Error while compiling the code (Code 2)";
        }

        // Run and correct the programm
#ifdef _WIN32
        result = runProgramAndCalculateTheScore((char*)solution, "UserProgramm.exe");
#else
        result = runProgramAndCalculateTheScore((char*)solution, "./UserProgramm");
#endif
    }  else if (strcmp(programmingLanguage, ".rs") == 0) {
        // Write the users code into a file with the correct ending of the language he used
        fileName = writeFile(usersCode, programmingLanguage);
        if (fileName == FILE_ERROR){
            //free(fileName);
            return "ERROR: Unable to generate the file (Code -1)";
        }

        // Call the compiler for the correct language and check for errors
#ifdef _WIN32
        int compilation = callCompiler(fileName, "rustc %s -o UserProgramm.exe");
#else
        int compilation = callCompiler(fileName, "rustc %s -o UserProgramm");
#endif
        if (compilation == SYSTEM_ERROR) {
            free(fileName);
            return "ERROR: Calling system() didn't work (Code 3)";
        } else if (compilation == MISSING_COMPILER_ERROR) {
            free(fileName);
            return "ERROR: No compiler found (Code -2)";
        } else if (compilation == COMPILATION_ERROR) {
            free(fileName);
            return "ERROR: Error while compiling the code (Code 2)";
        }

        // Run and correct the programm
#ifdef _WIN32
        result = runProgramAndCalculateTheScore((char*)solution, "UserProgramm.exe");
#else
        result = runProgramAndCalculateTheScore((char*)solution, "./UserProgramm");
#endif
    }  else if (strcmp(programmingLanguage, ".rb") == 0) {
        // Write the users code into a file with the correct ending of the language he used
        fileName = writeFile(usersCode, programmingLanguage);
        if (fileName == FILE_ERROR){
            //free(fileName);
            return "ERROR: Unable to generate the file (Code -1)";
        }

        // Call the compiler for the correct language and check for errors
        int compilation = callCompiler(fileName, "ruby -c %s");
        if (compilation == SYSTEM_ERROR) {
            free(fileName);
            return "ERROR: Calling system() didn't work (Code 3)";
        } else if (compilation == MISSING_COMPILER_ERROR) {
            free(fileName);
            return "ERROR: No compiler found (Code -2)";
        } else if (compilation == COMPILATION_ERROR) {
            free(fileName);
            return "ERROR: Error while compiling the code (Code 2)";
        }

        // Run and correct the programm
        result = runProgramAndCalculateTheScore((char*)solution, "ruby UserCode.rb");
    }   else if (strcmp(programmingLanguage, ".js") == 0) {
        // Write the users code into a file with the correct ending of the language he used
        fileName = writeFile(usersCode, programmingLanguage);
        if (fileName == FILE_ERROR){
            //free(fileName);
            return "ERROR: Unable to generate the file (Code -1)";
        }

        // Call the compiler for the correct language and check for errors
        int check = callCompiler(fileName, "node --check %s");
        if (check == SYSTEM_ERROR) {
            free(fileName);
            return "ERROR: Calling system() didn't work (Code 3)";
        } else if (check == MISSING_COMPILER_ERROR) {
            free(fileName);
            return "ERROR: No compiler found (Code -2)";
        } else if (check == COMPILATION_ERROR) {
            free(fileName);
            return "ERROR: Error while compiling the code (Code 2)";
        }

        // Run and correct the programm
        result = runProgramAndCalculateTheScore((char*)solution, "node UserCode.js");
    }  else if (strcmp(programmingLanguage, ".php") == 0) {
        // Write the users code into a file with the correct ending of the language he used
        fileName = writeFile(usersCode, programmingLanguage);
        if (fileName == FILE_ERROR){
            //free(fileName);
            return "ERROR: Unable to generate the file (Code -1)";
        }

        // Call the compiler for the correct language and check for errors
        int compilation = callCompiler(fileName, "php -l %s");
        if (compilation == SYSTEM_ERROR) {
            free(fileName);
            return "ERROR: Calling system() didn't work (Code 3)";
        } else if (compilation == MISSING_COMPILER_ERROR) {
            free(fileName);
            return "ERROR: No compiler found (Code -2)";
        } else if (compilation == COMPILATION_ERROR) {
            free(fileName);
            return "ERROR: Error while compiling the code (Code 2)";
        }

        // Run and correct the programm
        result = runProgramAndCalculateTheScore((char*)solution, "php UserCode.php");
    } else {
        printf("ERROR: Undefined language (Code 1)\n");
        return "ERROR: Undefined language (Code 1)";
    }

    if (fileName != NULL) {
        free(fileName);
    }
    return result;
}

// Generate a file and write its content
char* writeFile(const char* content, const char* ending){
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

    // Check whether the system() works
    if (status == -1) {
        printf("ERROR: Calling system() didn't work (Code 3)\n");
        return SYSTEM_ERROR;
    }

#ifdef _WIN32
    // On Windows we do not distinguish missing compiler vs. other compilation errors reliably
    if (status != 0) {
        printf("ERROR: Error while compiling the code (Code 2)\n");
        return COMPILATION_ERROR;
    }
#else
    int exitCode = WEXITSTATUS(status);

    // Check for errors and whether the compiler is installed or not
    if (exitCode == 127) {
        printf("ERROR: No compiler found (Code -2)\n");
        return MISSING_COMPILER_ERROR;
    } else if (exitCode != 0 && exitCode != 127) {
        printf("ERROR: Error while compiling the code (Code 2)\n");
        return COMPILATION_ERROR;
    }
#endif

    return 0;
}

// Run a programm and handle the errors => Calculate the results
char* runProgramAndCalculateTheScore(char* correctSolution, char* instruction) {
    
    int crashed = FALSE;
    char* result = malloc(2048);
    result[0] = '\0';

    // Try to start the programm and throw an error if it crashes
    FILE* pipe = popen(instruction, "r");
    if (!pipe) {
        crashed = TRUE;
        printf("ERROR: The programm crashed  (Code -3)\n");
        free(result);
        // 0 points if it crashed without an output
        return "0";
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
#ifdef _WIN32
    if (status != 0) {
        printf("ERROR: The programm crashed  (Code -3)\n");
        crashed = TRUE;
    } else {
        // If everything is fine return the correct Output
        crashed = FALSE;
    }
#else
    if (WIFSIGNALED(status)) {
        printf("ERROR: The programm crashed  (Code -3)\n");
        crashed = TRUE;
    } else {
        // If everything is fine return the correct Output
        crashed = FALSE;
    }
#endif

    // Calculate the score
    trimNewline(result);
    trimNewline(correctSolution);

    // 25 points if crashed with wrong Output
    if (strcmp(result, correctSolution) != 0 && crashed == TRUE) {
        free(result);
        return "25";
    // 50 points if crashed with correct Output
    } else if (strcmp(result, correctSolution) == 0 && crashed == TRUE) {
        free(result);
        return "50";
    // 75 points if wrong Output but no crash
    } else if (strcmp(result, correctSolution) != 0 && crashed == FALSE) {
        free(result);
        return "75";
        // 100 points if correct Output without crashes
    } else {
        free(result);
        return "100";
    }
}

// Removes \n & \r at the End of a String
void trimNewline(char* s) {
    size_t len = strlen(s);
    while (len > 0 && (s[len-1] == '\n' || s[len-1] == '\r')) {
        s[len-1] = '\0';
        len--;
    }
}

// #ifdef _WIN32 ... else ... endif makes sure it runs on windows as well as on linux
