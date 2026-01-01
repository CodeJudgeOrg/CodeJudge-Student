#include "judger.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// If called this function receives 3 String and it returns one as soon as it's done
char* run_judge(const char* usersCode, const char* programmingLanguage, const char* solution) {
    char* fileName;
    // Write the users code into a file with the correct ending of the language he used
    fileName = writeFile(usersCode, ".py");
    // TODO Call the compiler and pass the file with the users code
    // TODO Filter the compilers output
    //          - Syntax errors: Return message "Syntax errors. Did you select the correct language?"
    //          - Wrong results: Return message "Wrong results"
    //          - Correct solution: Return message "Succes!"
    // TODO Delete the file with the users Code
    // TODO Quit
}

char* writeFile(char* content, char* ending){
    // Generate the correct file name depending on the langugae the user used
    size_t len = 8 + strlen(ending);
    char* fileName = malloc(len);
    strcpy(fileName, "UserCode");
    strcat(fileName, ending);

    // Generate a new file or override an existing one
    FILE *userFile = fopen("", "w");

    // Return the correct file name
    return fileName;
}
