from stdlib cimport system

cdef compiler():
    # Flipent micro compiler
    methods = [
        "_start:",
        "func?:".format("main"),
        "push",
        "call?:".format("main"),
        "pop",
        "exit",
        "main:",
        "#import",
        "if",
    ]

    functions = [
        "print",
        "input",
        "int",
        "str",
        "float",
        "bool",
        "list",
        "dict",
        "tuple",
        "set",
        "frozenset",
        "range",
        "len",
        "type",
        "dir",
        "vars",
        "locals",
        "globals",
        "eval",
        "exec",
        "compile",
        "open",
        "read",
        "write",
        "close",
        "flush",
        "seek",
        "tell",
        "readline",
        "readlines",
        "writelines",
        "split",
        "join",
        "replace",
        "strip",
        "lstrip",
        "rstrip",
        "upper",
        "lower",
        "title",
        "capitalize",
        "swapcase",
        "center",
        "ljust",
        "rjust",
        "zfill",
        "count",
        "find",
        "index",
        "rfind",
        "rindex",
        "startswith",
        "endswith",
        "isalnum",
        "isalpha",
        "isdigit",
        "islower",
        "isupper",
        "istitle",
        "isspace",
        "isnumeric",
        "isdecimal",
        "isidentifier",
        "isprintable",
        "isascii",
        "isalnum",
        "isalpha",
        "isdigit",
        "islower",
        "isupper",
        "istitle",
        "isspace",
        "isnumeric",
        "isdecimal",
        "isidentifier",
        "isprintable",
        "isascii",
        "isalnum",
        "isalpha",
        "isdigit",
        "islower",
        "isupper",
        "istitle",
        "isspace",
        "isnumeric",
        "isdecimal",
        "isidentifier",
        "isprintable",
        "isascii",
        "isalnum",
        "isalpha",
        "isdigit",
        "islower",
        "isupper",
        "istitle",
        "isspace",
        "isnumeric",
        "isdecimal",
        "isidentifier",
        "isprintable",
        "isascii",
        "isalnum",
        "isalpha",
        "isdigit",
        "islower",
        "isupper",
        "istitle",
        "isspace",
        "is",
    ]

    