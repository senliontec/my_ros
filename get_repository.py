
import os


def get_repositoryname(filename):
    with open(filename,'r') as f:
        contents = f.readlines()
        for i in range(0,len(contents)):
            str = contents[i]
            if str.find("url") != -1:
                str = str.replace("url:","").strip()
                command = 'git clone -b humble --recursive ' + str
                retval = os.getcwd()
                os.chdir('./src/')
                os.system(command)
                os.chdir(retval)




if __name__=='__main__':
    filename = './ros2.repos'
    address = get_repositoryname(filename)