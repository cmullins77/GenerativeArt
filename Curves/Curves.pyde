class FractalCurve: 
    def __init__(self, areaStart, areaEnd, order, col):
        self.drawLength = 1
        self.startPosition = areaEnd
        self.rules = ""
        self.col = col
        
    def getStep(self, currStr, num):
        return ""
    
    def render(self):
        return
    
class HilbertCurve(FractalCurve):
    def __init__(self, areaStart, areaEnd, order, col):
        numAcross = (pow(2, order) - 1)
        wid = areaEnd.x - areaStart.x
        hei = areaEnd.y - areaStart.y
        minSize = min(wid, hei)
        self.drawLength = minSize/numAcross
        self.startPosition = areaEnd
        self.rules = self.getStep("A", order)
        println(self.rules)
        self.col = col
        
    def getStep(self, currStr, num):
        if num == 0:
            return currStr
        newStr = ""
        for c in currStr:
            if c == 'A':
                newStr += "+BF-AFA-FB+"
            elif c == 'B':
                newStr += "-AF+BFB+FA-"
            else:
                newStr += c
        return self.getStep(newStr, num - 1)
    
    def render(self):
        translate(self.startPosition.x, self.startPosition.y)
        noFill()
        strokeWeight(2)
        stroke(self.col)
        for i in range(len(self.rules)):
            c = self.rules[i]
            if c == 'F':
                line(0, 0, 0, -self.drawLength)
                translate(0, -self.drawLength)
            
            elif c == '+':
                rotate(radians(-90))
            elif c == '-':
                rotate(radians(90))
                
class GosperCurve(FractalCurve):
    def __init__(self, areaStart, areaEnd, order, col):
        numAcross = (pow(2, order) - 1)
        wid = areaEnd.x - areaStart.x
        hei = areaEnd.y - areaStart.y
        minSize = min(wid, hei)
        self.drawLength = (minSize/numAcross)*0.4
        self.startPosition = PVector(areaStart.x, areaEnd.y)
        self.rules = self.getStep("A", order)
        println(self.rules)
        self.col = col
        
    def getStep(self, currStr, num):
        if num == 0:
            return currStr
        newStr = ""
        for c in currStr:
            if c == 'A':
                newStr += "A-B--B+A++AA+B-"
            elif c == 'B':
                newStr += "+A-BB--B-A++A+B"
            else:
                newStr += c
        return self.getStep(newStr, num - 1)
    
    def render(self):
        translate(self.startPosition.x, self.startPosition.y)
        noFill()
        strokeWeight(2)
        stroke(self.col)
        for i in range(len(self.rules)):
            c = self.rules[i]
            if c == 'A' or c == 'B':
                line(0, 0, 0, -self.drawLength)
                translate(0, -self.drawLength)
            
            elif c == '+':
                rotate(radians(-60))
            elif c == '-':
                rotate(radians(60))
                
class TwindragonCurve(FractalCurve):
    def __init__(self, areaStart, areaEnd, order, col):
        numAcross = pow(2,order*0.5)
        wid = areaEnd.x - areaStart.x
        hei = areaEnd.y - areaStart.y
        minSize = min(wid, hei)
        self.drawLength = (minSize/numAcross)
        self.startPosition = PVector(areaStart.x*0.5+areaEnd.x*0.5, areaStart.y*0.5+areaEnd.y*0.5)
        self.rules = self.getStep("FX+FX+", order)
        println(self.rules)
        self.col = col
        
    def getStep(self, currStr, num):
        if num == 0:
            return currStr
        newStr = ""
        for c in currStr:
            if c == 'X':
                newStr += "X+YF"
            elif c == 'Y':
                newStr += "FX-Y"
            else:
                newStr += c
        return self.getStep(newStr, num - 1)
    
    def render(self):
        translate(self.startPosition.x, self.startPosition.y)
        noFill()
        strokeWeight(2)
        stroke(self.col)
        for i in range(len(self.rules)):
            c = self.rules[i]
            if c == 'F':
                line(0, 0, 0, -self.drawLength)
                translate(0, -self.drawLength)
            
            elif c == '+':
                rotate(radians(-90))
            elif c == '-':
                rotate(radians(90))
                
                
class TerdragonCurve(FractalCurve):
    def __init__(self, areaStart, areaEnd, order, col):
        numAcross = pow(2,order*0.5)*5
        wid = areaEnd.x - areaStart.x
        hei = areaEnd.y - areaStart.y
        minSize = min(wid, hei)
        self.drawLength = (minSize/numAcross)
        self.startPosition = PVector(areaStart.x, areaStart.y)
        self.rules = self.getStep("F", order)
        println(self.rules)
        self.col = col
        
    def getStep(self, currStr, num):
        if num == 0:
            return currStr
        newStr = ""
        for c in currStr:
            if c == 'F':
                newStr += "F+F-F"
            else:
                newStr += c
        return self.getStep(newStr, num - 1)
    
    def render(self):
        translate(self.startPosition.x, self.startPosition.y)
        noFill()
        strokeWeight(2)
        stroke(self.col)
        for i in range(len(self.rules)):
            c = self.rules[i]
            if c == 'F':
                line(0, 0, 0, -self.drawLength)
                translate(0, -self.drawLength)
            
            elif c == '+':
                rotate(radians(-120))
            elif c == '-':
                rotate(radians(120))
                
class SierpinskiCurve(FractalCurve):
    def __init__(self, areaStart, areaEnd, order, col):
        numAcross = (pow(2,order)-1)*2
        wid = areaEnd.x - areaStart.x
        hei = areaEnd.y - areaStart.y
        minSize = min(wid, hei)
        self.drawLength = (minSize/numAcross)
        self.startPosition = PVector(areaStart.x, areaStart.y*0.5+areaEnd.y*0.5)
        self.rules = self.getStep("F--XF--F--XF", order)
        println(self.rules)
        self.col = col
        
    def getStep(self, currStr, num):
        if num == 0:
            return currStr
        newStr = ""
        for c in currStr:
            if c == 'X':
                newStr += "XF+G+XF--F--XF+G+X"
            else:
                newStr += c
        return self.getStep(newStr, num - 1)
    
    def render(self):
        translate(self.startPosition.x, self.startPosition.y)
        noFill()
        strokeWeight(2)
        stroke(self.col)
        for i in range(len(self.rules)):
            c = self.rules[i]
            if c == 'G':
                line(0, 0, 0, -self.drawLength)
                translate(0, -self.drawLength)
            elif c == 'F':
                line(0, 0, 0, -self.drawLength/3)
                translate(0, -self.drawLength/3)
            elif c == '+':
                rotate(radians(-45))
            elif c == '-':
                rotate(radians(45))
                
class ReverseSierpinskiCurve(FractalCurve):
    def __init__(self, areaStart, areaEnd, order, col):
        numAcross = (pow(2,order)-1)*2
        wid = areaEnd.x - areaStart.x
        hei = areaEnd.y - areaStart.y
        minSize = min(wid, hei)
        self.drawLength = (minSize/numAcross)
        self.startPosition = PVector(areaStart.x, areaStart.y*0.5+areaEnd.y*0.5)
        self.rules = self.getStep("F--XF--F--XF", order)
        println(self.rules)
        self.col = col
        
    def getStep(self, currStr, num):
        if num == 0:
            return currStr
        newStr = ""
        for c in currStr:
            if c == 'X':
                newStr += "XF+G+XF--F--XF+G+X"
            else:
                newStr += c
        return self.getStep(newStr, num - 1)
    
    def render(self):
        translate(self.startPosition.x, self.startPosition.y)
        noFill()
        strokeWeight(2)
        stroke(self.col)
        for i in range(len(self.rules)):
            c = self.rules[i]
            if c == 'G':
                line(0, 0, 0, -self.drawLength)
                translate(0, -self.drawLength)
            elif c == 'F':
                line(0, 0, 0, -self.drawLength/3)
                translate(0, -self.drawLength/3)
            elif c == '+':
                rotate(radians(-45))
            elif c == '-':
                rotate(radians(45))
                
class SierpinskiSquareCurve(FractalCurve):
    def __init__(self, areaStart, areaEnd, order, col):
        numAcross = (pow(2,order)-1)
        wid = areaEnd.x - areaStart.x
        hei = areaEnd.y - areaStart.y
        minSize = min(wid, hei)
        self.drawLength = (minSize/numAcross)/5
        self.startPosition = PVector(areaEnd.x, areaStart.y*0.5+areaEnd.y*0.5+self.drawLength/2)
        self.rules = self.getStep("F+XF+F+XF", order)
        println(self.rules)
        self.col = col
        
    def getStep(self, currStr, num):
        if num == 0:
            return currStr
        newStr = ""
        for c in currStr:
            if c == 'X':
                newStr += "XF-F+F-XF+F+XF-F+F-X"
            else:
                newStr += c
        return self.getStep(newStr, num - 1)
    
    def render(self):
        translate(self.startPosition.x, self.startPosition.y)
        noFill()
        strokeWeight(2)
        stroke(self.col)
        for i in range(len(self.rules)):
            c = self.rules[i]
            if c == 'F':
                line(0, 0, 0, -self.drawLength)
                translate(0, -self.drawLength)
            elif c == '+':
                rotate(radians(-90))
            elif c == '-':
                rotate(radians(90))
                
            
                
class PeanoCurve(FractalCurve):
    def __init__(self, areaStart, areaEnd, order, col):
        numAcross = (pow(2,order))
        wid = areaEnd.x - areaStart.x
        hei = areaEnd.y - areaStart.y
        minSize = min(wid, hei)
        self.drawLength = (minSize/numAcross)/2
        self.startPosition = PVector(areaEnd.x, areaEnd.y)
        self.rules = self.getStep("X", order)
        println(self.rules)
        self.col = col
        
    def getStep(self, currStr, num):
        if num == 0:
            return currStr
        newStr = ""
        for c in currStr:
            if c == 'X':
                newStr += "XFYFX+F+YFXFY-F-XFYFX"
            elif c== 'Y':
                newStr += "YFXFY-F-XFYFX+F+YFXFY"
            else:
                newStr += c
        return self.getStep(newStr, num - 1)
    
    def render(self):
        translate(self.startPosition.x, self.startPosition.y)
        noFill()
        strokeWeight(2)
        stroke(self.col)
        for i in range(len(self.rules)):
            c = self.rules[i]
            if c == 'F':
                line(0, 0, 0, -self.drawLength)
                translate(0, -self.drawLength)
            elif c == '+':
                rotate(radians(-90))
            elif c == '-':
                rotate(radians(90))

def setup():
    size(600,600)
    colorMode(RGB, 1.0)
    fCurve = ReverseSierpinskiCurve(PVector(100,100), PVector(500,500),1, color(1,0.5,0.75))
    fCurve.render()
    
def draw():
    pass
