#include <stdio.h>

/* Manifests */
#define MAX_LENGTH 100

int main() {
    char state = IGNORE; // Было WORD, стало IGNORE
    int count = 0;
    char output[MAX_LENGTH]; // Было input, стало output
    
    printf("Enter your input: ");
    scanf("%s", output);

    switch (state) {
        case IGNORE: // Было WORD, стало IGNORE
            printf("State is IGNORE\n");
            break;
        case set: // Было Reset, стало set
            printf("State set\n");
            break;
        default:
            printf("Unknown state\n");
    }

    /* Additional logic */
    for (int i = 0; i < MAX_LENGTH; i++) {
        output[i] = '\0'; // Очистка массива output
    }

    return 0;
}
