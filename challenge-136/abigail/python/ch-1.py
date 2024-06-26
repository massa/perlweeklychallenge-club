#!/opt/local/bin/python

#
# See ../README.md
#

#
# Run as: python ch-1.py < input-file
#

import fileinput
import math

def is_power_of_n (number, n):
    if number < 1:
        return False
    if number == 1:
        return True
    if number % n:
        return False
    return is_power_of_n (number / n, n)

def is_power_of_2 (number):
    return is_power_of_n (number, 2)

for line in fileinput . input ():
    m, n = line . strip () . split (' ')
    m = int (m)
    n = int (n)
    if m % 2 or n % 2:
        print (0)
    else:
        r = math . gcd (m, n)
        if r > 1 and is_power_of_2 (r):
            print (1)
        else:
            print (0)
