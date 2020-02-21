import fileinput
import os
from pathlib import Path

print("Starting Python script")


# The file imports contains the list of files that will be included
def read_import_files(name_filter = 'template'):
    path_import_file = '../../terraform/templates/imports.txt'
    joined_paths = os.path.join(os.path.dirname(__file__),path_import_file)
    absolut_path = os.path.abspath(joined_paths)
    try:
        #print(joined_paths)
        if os.path.isfile(absolut_path) != '':
            #print('File path :' + os.path.abspath(absolut_path))
            items = []
            with open(absolut_path) as f:
                for file_name in f.readlines():
                    if not str(file_name).startswith('#'):
                        if str(file_name).find(name_filter) != -1 :
                            #print(file_name)
                            items.append(file_name)
            return items
        else:
            print('WARNING Import file does not exist !!!')
    except Exception as err:
        print(type(err))
        print(err)


def merge_files():
    files_merged = ['main.tf','variables.tf','outputs.tf']
    file_filter_names = ['template','variables','outputs']
    for item in files_merged:
        item_index = files_merged.index(item)
        import_list = read_import_files(file_filter_names[item_index])
        with open('./terraform/'+item, 'w') as fout:
            for line in iter(import_list):
                file_name = line.rstrip()
                joined_paths = os.path.join(os.curdir,"./terraform/templates/"+file_name)
                absolut_path = os.path.abspath(joined_paths)
                if os.path.isfile(absolut_path):
                    fout.write(f'\n ####### START FILE {file_name} #####  \n')
                    with open(absolut_path) as finput:
                        lines = finput.readlines()
                        first_line = lines[0]
                        if "#multiregion" in first_line:
                            second_line = lines[1]
                            second_line_format = second_line.replace('#','')
                            regions = second_line_format.split(",")
                            for region in regions:
                                if len(region) > 1:
                                    for line in lines:
                                        if line.startswith("module"):
                                            line = line.replace("REGION",region)
                                        elif "providers = {aws = aws.alias}" in line:
                                            line = line.replace("alias",region)
                                        if line != first_line and line != second_line:
                                            fout.write(line)
                        else:
                            fout.write(f'\n #######NOT MULTIREGION  \n')                            
                            fout.write(finput.read())
                    fout.write(f'\n ####### END FILE {file_name} #####  \n')
                    finput.close()
                else:
                    print(f'\n WARNING : File with name {file_name} does not exist in path {absolut_path}  \n')   
        fout.close()


if __name__== "__main__":
    merge_files()
    
