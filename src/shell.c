#include <stdio.h>
#include "../include/fs_init.h"

int main(int argc, char *argv[]) {
    restore_file_system();
    return fuse_main(argc, argv, &operations, NULL);
}
