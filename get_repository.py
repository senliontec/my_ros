
import os

def mkdir(path):
    folder = os.path.exists(path)
    if not folder:
        os.makedirs(path)
        print("Success created new folder")
    else:
        print("folder already exist")


def get_repositoryname(filename):
    with open(filename,'r') as f:
        contents = f.readlines()

        for i in range(7,len(contents) // 4):
            key  = contents[i * 4 + 1].strip()
            directory ='./src/' + key.split('/')[0]
            mkdir(directory)
            type = contents[i * 4 + 2].strip()
            url  = contents[i * 4 + 3].replace('url:','').strip()
            version = contents[i * 4 + 4].replace('version:','').strip()
            command = 'git clone -b {} --recursive {}'.format(version, url) + ' --config "http.proxy=127.0.0.1:7890"'
            retval = os.getcwd()
            os.chdir(directory)
            print('{} :--------------------------'.format(i))
            print(command)
            os.system(command)
            os.chdir(retval)


if __name__=='__main__':
    filename = './ros2.repos'
    address = get_repositoryname(filename)