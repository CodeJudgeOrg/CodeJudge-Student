#include "judger.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/wait.h>

// If called this function receives 3 String and it returns one as soon as it's done
char* run_judge(const char* usersCode, const char* programmingLanguage, const char* solution) {
    char* fileName;

    // TODO Perform the file generation & compilation depending on the used language
    if (programmingLanguage == ".c") {
        // Write the users code into a file with the correct ending of the language he used
        fileName = writeFile(usersCode, programmingLanguage);
        if (fileName == "-1"){
            return "ERROR: Unable to generate the file (Code -1)";
        }

        // Call the compiler for the correct language and check for errors
        int compilation = callCompiler(fileName, "gcc %s -o UserProgramm 2> /dev/null");
        if (compilation == 3) {
            return "ERROR: Calling system() didn't work (Code 3)";
        } else if (compilation == -2) {
            return "ERROR: No compiler found (Code -2)";
        } else if (compilation == 2) {
            return "ERROR: Error while compiling the code (Code 2)";
        }
    } else if (programmingLanguage == ".java") {
        // Write the users code into a file with the correct ending of the language he used
        fileName = writeFile(usersCode, programmingLanguage);
        if (fileName == "-1"){
            return "ERROR: Unable to generate the file (Code -1)";
        }

        // Call the compiler for the correct language and check for errors
        int compilation = callCompiler(fileName, "javac %s 2> /dev/null");
        if (compilation == 3) {
            return "ERROR: Calling system() didn't work (Code 3)";
        } else if (compilation == -2) {
            return "ERROR: No compiler found (Code -2)";
        } else if (compilation == 2) {
            return "ERROR: Error while compiling the code (Code 2)";
        }
    } else if (programmingLanguage == ".py") {
        // Write the users code into a file with the correct ending of the language he used
        fileName = writeFile(usersCode, programmingLanguage);
        if (fileName == "-1"){
            return "ERROR: Unable to generate the file (Code -1)";
        }

        // Check at least whether the syntax is fine or not
        int interpretation = callCompiler(fileName, "python3 -m py_compile %s 2> /dev/null");
        if (interpretation == 3) {
            return "ERROR: Calling system() didn't work (Code 3)";
        } else if (interpretation == -2) {
            return "ERROR: No compiler found (Code -2)";
        } else if (interpretation == 2) {
            return "ERROR: Error while compiling the code (Code 2)";
        }
    } else if (programmingLanguage == ".cpp") {
        // Write the users code into a file with the correct ending of the language he used
        fileName = writeFile(usersCode, programmingLanguage);
        if (fileName == "-1"){
            return "ERROR: Unable to generate the file (Code -1)";
        }

        // Call the compiler for the correct language and check for errors
        int compilation = callCompiler(fileName, "g++ %s -o UserProgramm 2> /dev/null");
        if (compilation == 3) {
            return "ERROR: Calling system() didn't work (Code 3)";
        } else if (compilation == -2) {
            return "ERROR: No compiler found (Code -2)";
        } else if (compilation == 2) {
            return "ERROR: Error while compiling the code (Code 2)";
        }
    } else {
        printf("ERROR: Undefined language (Code 1)\n");
        return "ERROR: Undefined language (Code 1)";
    }

    free(fileName);
}

// Generate a file and write its content
char* writeFile(char* content, char* ending){
    // Generate the correct file name depending on the langugae the user used
    size_t len = 8 + strlen(ending);
    char* fileName = malloc(len);
    strcpy(fileName, "UserCode");
    strcat(fileName, ending);

    // Generate a new file or override an existing one
    FILE *userFile = fopen("", "w");
    if (userFile == NULL){
        printf("ERROR: Unable to generate the file (Code -1)\n");
        return -1;
    }
    
    // Write the content
    fprintf(userFile, content);
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
        return 3;
    }

    // Check for errors and whether the compiler is installed or not
    if (exitCode != 0 && exitCode == 127) {
        printf("ERROR: No compiler found (Code -2)\n");
        return -2;
    } else if (exitCode != 0) {
        printf("ERROR: Error while compiling the code (Code 2)\n");
        return 2;
    }

    return 0;
}

// Run a programm and handle the errors
char* runProgramAndCalculateTheScore(int* crashed) {
    // Try to start the programm and throw an error if it crashes
    FILE* pipe = popen("./program", "r");
    if (!pipe) {
        *crashed = 1;
        printf("ERROR: The programm crashed  (Code -3)\n");
        return "-3";
    }

    // Receive the output
    char* result = malloc(2048);
    result[0] = '\0';

    char buffer[256];
    while (fgets(buffer, sizeof(buffer), pipe)) {
        strcat(result, buffer);
    }

    // Quit the programm and receive the exit code
    int status = pclose(pipe);

    // Check whether the programm crashed by checking the exit codes
    if (WIFSIGNALED(status)) {
        *crashed = 1;
        free(result);
        return "-3";
    }

    // If everything is fine return the correct Output
    *crashed = 0;
    return result;
}
