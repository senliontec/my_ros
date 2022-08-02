
import os


def get_repositoryname(filename):
    with open(filename,'r') as f:
        contents = f.readlines()

        for i in range(0,len(contents) // 4):
            key  = contents[i * 4 + 1].strip()
            type = contents[i * 4 + 2].strip()
            url  = contents[i * 4 + 3].replace('url:','').strip()
            version = contents[i * 4 + 4].replace('version:','').strip()
            command = 'git clone -b {} --recursive {}'.format(version, url)
            retval = os.getcwd()
            os.chdir('./src/')
            print('{} :--------------------------'.format(i))
            print(command)
            os.system(command)
            os.chdir(retval)


if __name__=='__main__':
    filename = './ros2.repos'
    address = get_repositoryname(filename)