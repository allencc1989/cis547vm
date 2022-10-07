
import math

from typing import Tuple

from delta_debugger import run_target

EMPTY_STRING = b""


def delta_debug(target: str, input: bytes) -> bytes:
    """
    Delta-Debugging algorithm

    TODO: Implement your algorithm for delta-debugging.

    Hint: It may be helpful to use an auxilary function that
    takes as input a target, input string, n and
    returns the next input and n to try.

    :param target: target program
    :param input: crashing input to be minimized
    :return: 1-minimal crashing input.
    """
    n = 2
    
    while len(input)>1:

        is_failing = False
        test_inputs =create_input(n, input)

        for p in test_inputs:

            delta = p[0]
            nebla = p[1]

            if run_target(target,delta)!=0:
                 
                input = delta
                n = 2
                is_failing = True
                break

            if run_target(target, nebla)!=0:
                input = nebla
                n = n-1
                is_failing = True
                break

        if not is_failing:
            if n >= len(input):
                break
            else:
                n=n*2
                
    if len(input)== 1 and run_target(target, EMPTY_STRING)!=0:
            return EMPTY_STRING
   
    return input

def create_input(n: int, input: bytes)->set:
    
    output = set()
    start = 0
    length = len(input)//n
    count = 0
    while count<n:
        count+=1
        end = start+length
        delta = input[start: end]
        nebla = input[:start]+input[end:]
         
        output.add((delta, nebla))
        start += length
         
    return output

    