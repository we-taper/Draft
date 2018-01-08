# assert python 3.5
# assert pandas installed
import pandas as pd
import sys


def print_usage(script_name):
    print("Usage: {} excel_file output_file [sheet_name]".format(script_name))

if __name__ == '__main__':
    argv = sys.argv
    sheet_name = 0 # default, read the 0th sheet
    if len(argv) == 3:
        filename = argv[1]
        outfilename = argv[2]
    elif len(argv) == 4:
        filename = argv[1]
        outfilename = argv[2]
        sheet_name = argv[3]
    else:
        script_name = argv[0]
        print_usage(script_name)
        exit(0)
    excel_f = pd.read_excel(io=filename, sheet_name=sheet_name)
    excel_f.to_latex(outfilename)
