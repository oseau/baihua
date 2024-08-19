from pyhanlp import *
import os

while True:
    try:
        line = input()
        print(HanLP.s2tw(line))
    except EOFError:
        break
