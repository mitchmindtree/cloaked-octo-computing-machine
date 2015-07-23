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
from getpass import getpass
import pexpect


def configureGit():
    print("Grabbing URL...")
    child = pexpect.spawn("git config --get remote.origin.url")
    child.expect("\r\n")
    url = child.before
    child.kill(0)
    print("Found URL")
    print(url)
    print("Grabbing Repo name...")
    repo = url.rsplit('/',1)[1]
    print(repo)
    usr = raw_input("Gimme yo github user name: ")
    pwd = getpass("Now your password: ")
    os.system("git config remote.origin.url https://"+usr+":"+pwd+"@github.com/"+usr+"/"+repo)
    os.system("git push origin master")


def callGit(path, message):
    os.system("git add -A .")
    os.system("git commit -m '" + message + "'")
    try:
        child = pexpect.spawn("git push origin master")
        i = child.expect(["Username for 'https://github.com': ", pexpect.EOF], 20)
        if i == 0:
            child.kill(0)
            raise Exception("Github seems to want your user and pw...")
        else:
            print(child.before)
            print("Added, committed and pushed your stuff dawg.")
    except Exception, e:
        print(e)
        print("Going to try configure your remote so that I won't require usr/pw in the future...")
        configureGit()
        print("Added, committed and pushed your stuff dawg.")

        
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


if __name__ == "__main__":
    main() 

