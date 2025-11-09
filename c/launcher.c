// Copyright © 2025 CToID <funk443@icloud.com>
//
// This program is free software. It comes without any warranty, to the
// extent permitted by applicable law. You can redistribute it and/or
// modify it under the terms of the Do What The Fuck You Want To Public
// License, Version 2, as published by Sam Hocevar. See the COPYING file
// for more details.

#include <string.h>
#include <stdlib.h>

#include <scheme.h>

int main(int argc, char *argv[]) {
    Sscheme_init(NULL);

    char *boot_file_name = malloc(strlen(argv[0]) + strlen(".boot") + 1);
    if (boot_file_name) {
        boot_file_name[0] = '\0';
        strcat(boot_file_name, argv[0]);
        strcat(boot_file_name, ".boot");
        Sregister_boot_relative_file(boot_file_name);
    } else {
        Sregister_boot_relative_file("main.boot");
    }
    Sbuild_heap(NULL, NULL);

    Scall1(Stop_level_value(Sstring_to_symbol("suppress-greeting")), Strue);
    int return_status = Sscheme_program(argv[0], argc, argv);

    Sscheme_deinit();
    free(boot_file_name);
    return return_status;
}
