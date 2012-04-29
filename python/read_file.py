def read_tsv_file(file):
    f = open(file)
    for line in f.readlines():
        id, obj = map(lambda x: int(x), line.rstrip('\n').split('\t'))
