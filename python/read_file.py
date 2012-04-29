def read_sep_file(file, sep):
    f = open(file)
    for line in f.readlines():
        id, obj = map(lambda x: int(x), line.rstrip('\n').split(sep))
