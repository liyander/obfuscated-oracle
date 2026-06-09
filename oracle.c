#include <stdio.h>
#include <string.h>

int main() {
    char encoded_flag[] = "YmxhY2twZXJse3N0cjFuZ3NfYjY0X2QzYzBkM2R9";
    
    printf("========================================\n");
    printf("    THE OBFUSCATED ORACLE v1.1\n");
    printf("========================================\n\n");
    printf("The flag is hidden in this binary.\n");
    printf("Use the 'strings' command to find it.\n\n");
    printf("But wait... the flag is encoded!\n");
    printf("You'll need to decode it after finding it.\n\n");
    printf("Hint: strings oracle | grep -E '^[A-Za-z0-9+/=]{20,}$'\n");
    
    return 0;
}
