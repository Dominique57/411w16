import matplotlib.pyplot as plt
import os 
import sys

directory="output/"
if not os.path.exists(directory):
    os.makedirs(directory)

argc = len(sys.argv)
if argc < 2:
    print("File not specified")
    exit()

loadfile = sys.argv[1]
name = (loadfile.split("."))[0]

def tryOpen(path, settings):
    try:
        f = open(path, settings)
    except FileNotFoundError:
        return None
    return f

def tryGetLine(file):
    l = file.readline().strip()
    return l

def addArray(tup, label, values):
    length = len(tup[0])
    lenData = len(label)
    if lenData == 0:
        label.append(tup[0])
        values.append([tup[1]])
    else:
        for i in range(len(label)):
            val = label[i]
            if tup[0] == val:
                values[i].append(tup[1])
                return
            else:
                lenVal = len(val)
                if lenVal < length:
                    continue
                elif lenVal == length:
                    if tup[0] < val:
                        label.insert(i, tup[0])
                        values.insert(i, [tup[1]])
                        return
                    else:
                        continue
                else:
                    label.insert(i, tup[0])
                    values.insert(i, [tup[1]])
                    return
        label.append(tup[0])
        values.append([tup[1]])


def byteToRead(string):
    typ = ["", "k", "m", "g", "t", "p"]
    length = len(typ)
    try:
        val = int(string)
    except:
        raise Exception("invalid size")
    i = 0
    while val // 1000 > 0:
        val = val // 1000
        i+= 1
    return str(val)+typ[i]


def main():
    f = tryOpen(loadfile, "r+")
    if not f:
        print("file does not exist")
        exit()
    line = tryGetLine(f)
    size, value = [], []
    while line:
        lineData = line.split(' ')
        try:
            lineData = (str(lineData[0]), float(lineData[1]))
        except:
            print("error occured when reading")
            exit()
        addArray(lineData, size, value)
        line = tryGetLine(f)
    # create boxplot
    label = []
    for i in range(len(size)):
        string = byteToRead(size[i])
        label.append(string)
    
    plt.title('Boxplot of '+ name + ' data gathered')
    plt.ylabel('volume')
    plt.xlabel('time (s)')
    plt.boxplot(value, meanline=True, showmeans=True)
    plt.xticks(range(1, len(label) + 1), label)
    plt.savefig(directory + "DATA-" + name + "-boxplot.png")
    
    # create average plot
    avg = []
    for val in value:
        summ, i, length = 0, 0, len(val)
        for elt in val:
            summ += elt
            i += 1
        avg.append(summ / i)

    newLabel = label.copy()
    newLabel.insert(0, " ")
    newAvg = avg.copy()
    newAvg.insert(0, 0)

    plt.plot(newLabel, newAvg)
    plt.savefig(directory + "DATA-" + name + "-boxplot-mean.png")
    plt.close()

    plt.title('Plot of average of '+ name + ' data gathered')
    plt.ylabel('volume')
    plt.xlabel('time (s)')
    plt.plot(label, avg)
    plt.savefig(directory + "DATA-" + name + "-mean.png")

main()
