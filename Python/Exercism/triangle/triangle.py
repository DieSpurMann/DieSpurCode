#Test
def equilateral(sides):
    if isListContains0(sides):
        return False
    if max(sides) == min(sides):
        return True
    return False

def isosceles(sides):
    res = False
    if (len(sides) != len(set(sides))) and isValidTriangle(sides):
        res = True
    return res

def isListContains0(lst):
    for item in lst:
        if item == 0:
            return True
    return False

def scalene(sides):
    if not isValidTriangle(sides):
        return False
    return not(equilateral(sides)) and not(isosceles(sides))

def isValidTriangle(sides):
    if len(sides) != 3 or isListContains0(sides):
        return False
    lst = sorted(sides)
    return lst[0] + lst[1] > lst[2]
    
lst = [5, 5, 5]
print(isValidTriangle([3, 4, 4]))