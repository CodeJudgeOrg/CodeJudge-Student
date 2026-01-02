#ifndef JUDGER_H
#define JUDGER_H

#ifdef __cplusplus
extern "C" {
#endif

// Main function of my library: Returns a String in C => Flutter can read it via FFI
char* runJudge(const char* usersCode, const char* programmingLanguage, const char* solution);

// Internal helper functions
char* writeFile(const char* content, const char* ending);
int callCompiler(char* fileName, char* instruction);
char* runProgramAndCalculateTheScore(char* correctSolution, char* instruction);
void trimNewline(char* s);

#ifdef __cplusplus
}
#endif
#endif
