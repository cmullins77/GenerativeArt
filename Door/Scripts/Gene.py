import random

class Gene:

    def __init__(self, val, num, start, end, ranges):
        self.usesRanges = ranges
        self.geneNum = val

        self.numOptions = num
        self.startRange = start
        self.endRange = end

        rangeIncrements = (self.endRange - self.startRange) / float(self.numOptions)
        if self.usesRanges:
            currStart = self.startRange + (rangeIncrements * self.geneNum)
            currEnd = currStart + rangeIncrements
            self.value = random.uniform(currStart, currEnd)
        else:
            rangeIncrements = (1 + self.endRange - self.startRange) / float(self.numOptions)
            self.value = self.startRange + self.geneNum

    def mutateGene(self):
        num = int(random.uniform(0, self.numOptions-1))

        return num

