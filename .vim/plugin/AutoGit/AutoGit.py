#!usr/bin/env python


'''

AutoGit.py

by Mitchell Nordine

Super simple script for automating my most common git process.

Usage:
    AutoGit.py [-h | --help] [-v | --version]
    AutoGit.py <path> <message>

Options:
    -h --help           Show this screen.
    -v --version        Show version.

'''


import os, time, sys
from subprocess import PIPE, Popen, call
from docopt import docopt
from pprint import pprint
from threading import Thread
try:
    from Queue import Queue, Empty
except ImportError:
    from queue import Queue, Empty

ON_POSIX = 'posix' in sys.builtin_module_names


def putOutputInQueue(out, q):
    print("Into 'putOutputInQueue'")
    while True:
        print("Into the while loop!")
        for line in iter(lambda:out.readline(), b''):
            print("Into the for loop!")
            q.put(line)
        out.close()
        print("Queue:")
        pprint(q)
        time.sleep(.5)


def callGit(path, message):
    os.system("git add -A .")
    os.system("git commit -m '" + message + "'")
    try:
        p = Popen(['git', 'push', 'origin', 'master'], stdin=PIPE, stdout=PIPE)
        q = Queue()
        t = Thread(target=putOutputInQueue, args=(p.stdout, q))
        t.daemon = True
        t.start()
        while True and t.isAlive():
            try: line = q.get_nowait()
            except Empty:
                print('no output yet')
            else:
                print('else!')
                break
            time.sleep(.5)
        p.wait()
        #c = proc.communicate()
        #pprint(c)
    except Exception, e:
        print(e)
        print("Going to try configure your remote so that I won't require usr/pw in the future...")
        usr = raw_input("Gimme yo github user name = ")
        pwd = raw_input("Now your password = ")
        call("git config remote.origin.url https://"+usr+":"+pwd+"@github.com/mitchmindtree/JenAI.git")
        call("git push origin master")


def cleanMessage(message):
    message.replace("'", "")
    return message


def cleanPath(path):
    while path[-1] is " " or path[-1] is "/":
        path = path[:-1]
    path = os.path.expanduser(path)
    path = os.path.normpath(path)
    if os.path.exists(path):
        return path
    else:
        raise Exception("I can't find the given path! You're not leading me astray... are you?")


def main():
    args = docopt(__doc__, version='AutoGit -- V.MillionThousand')
    path = args['<path>']
    if args['<message>']:
        message = cleanMessage(args['<message>'])
    else:
        message = raw_input("Commit message: ")
    callGit(path, message)
    print("Added, committed and pushed your stuff dawg.")


if __name__ == "__main__":
    main() 

