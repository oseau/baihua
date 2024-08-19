from pyhanlp import *
import os

def convert_chinese(text):
    """Convert between simplified and traditional Chinese."""
    hk_to_s = HanLP.hk2s(text)
    s_to_hk = HanLP.s2hk(text)
    
    if hk_to_s != text:
        return hk_to_s  # Input was traditional, convert to simplified
    elif s_to_hk != text:
        return s_to_hk  # Input was simplified, convert to traditional
    else:
        return None  # No conversion needed or possible

while True:
    try:
        line = input()
        result = convert_chinese(line)
        if result:
            print(result)
        else:
            print("No conversion needed or text is not Chinese.")
    except EOFError:
        break
