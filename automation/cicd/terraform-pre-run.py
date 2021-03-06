import fileinput
import os
from pathlib import Path

print("Starting Python script")

# Required file with the files to be imported
imports_file = '../../terraform/implementations/imports.txt'

# The file imports contains the list of files that will be included
# it excludes the lines starting with #
def read_import_files(name_filter = 'template'):
    joined_paths = os.path.join(os.path.dirname(__file__),imports_file)
    absolut_path = os.path.abspath(joined_paths)
    try:
        if os.path.isfile(absolut_path) != '':
            items = []
            with open(absolut_path) as f:
                for file_name in f.readlines():
                    if not str(file_name).startswith('#'):
                        if str(file_name).find(name_filter) != -1 :
                            items.append(file_name)
            return items
        else:
            print('WARNING Import file does not exist !!!')
    except Exception as err:
        print(type(err))
        print(err)


# This functions returns the path of the files that were included in the imports file
# import_file is the parameter to find the path
cwd = os.getcwd()
def search_file_path(import_file):
    for root, dirs, files in os.walk(cwd, topdown=False):
        #print(f' :: root {root} dirs {dirs}')
        for name in files:
            #print(f'>>> root {root} dirs {dirs} files {name}')
            head, tail = os.path.split(import_file)
            if name == tail:
                #print(f'||| head {head} tail {tail} file-name {name}')
                return(os.path.join(root, name))

# This function lists the files to be generated: main, variables and output
# It gets the file and the path from search_file_path(file)
def merge_files():
    files_merged = ['main.tf','variables.tf','outputs.tf']
    file_filter_names = ['template','variables','outputs']
    for item in files_merged:
        item_index = files_merged.index(item)
        import_list = read_import_files(file_filter_names[item_index])
        with open('./terraform/'+item, 'w') as fout:
            for line in iter(import_list):
                file_name = line.rstrip()                                               # This gets the filename from the list
                absolut_path = search_file_path(file_name)                              # This returns the path and the filename
                if os.path.isfile(absolut_path):
                    fout.write(f'\n ####### START FILE {file_name} #####  \n')                   
                    with open(absolut_path) as finput:
                        fout.write(finput.read())                            
                    fout.write(f'\n ####### END FILE {file_name} #####  \n')
                else:
                    print(f'\n WARNING : File with name {file_name} does not exist in path {absolut_path}  \n')   
        fout.close()


if __name__== "__main__":
    merge_files()