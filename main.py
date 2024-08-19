from pyhanlp import *
import os

def is_traditional(text):
    """Check if the input text is traditional Chinese."""
    return text == HanLP.tw2s(text)

while True:
    try:
        line = input()
        if is_traditional(line):
            print(HanLP.tw2s(line))  # Convert traditional to simplified
        else:
            print(HanLP.s2tw(line))  # Convert simplified to traditional
    except EOFError:
        break
