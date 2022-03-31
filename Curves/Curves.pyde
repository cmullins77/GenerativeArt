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
        
        self.generatePointList()
        self.shiftedPoints = []
        
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
    
    def generatePointList(self):
        sX = self.startPosition.x
        sY = self.startPosition.y
        
        points = [PVector(sX,sY)]
        dir = PVector(0,-1)
        pos = PVector(sX, sY)
        for i in range(len(self.rules)):
            c = self.rules[i]
            if c == 'F':
                newX = (self.drawLength) * dir.x + pos.x
                newY = (self.drawLength) * dir.y + pos.y
                
                pos = PVector(newX, newY)
                points.append(pos)    
            elif c == '+':
                dir.rotate(radians(-90))
            elif c == '-':
                dir.rotate(radians(90))
        self.points = points
    def shiftPoints(self, t, maxT):
        shiftedPoints = []
        for i in range(0, len(self.points) - maxT):
            p0Index = floor(t) + i
            p1Index = p0Index + 1 
            
            if p1Index < len(self.points):
                p0 = self.points[p0Index]
                p1 = self.points[p1Index]
                
                tVal = t - (p0Index-i)
                
                newP = PVector(p0.x*(1 - tVal) + p1.x*tVal, p0.y*(1-tVal) + p1.y*tVal)
                #print(p0.x, p0.y, p1.x, p1.y, newP.x, newP.y)
                shiftedPoints.append(newP)
            else:
                shiftedPoints.append(self.points[len(self.points) - 1])
        self.shiftedPoints = shiftedPoints
        
    def render(self):
        noFill()
        strokeWeight(2)
        stroke(self.col)
        
        if len(self.shiftedPoints) == 0:
            self.shiftedPoints = self.points
            
        for i in range(1, len(self.shiftedPoints)):
            p0 = self.shiftedPoints[i-1]
            p1 = self.shiftedPoints[i]
            line(p0.x, p0.y, p1.x, p1.y)
                
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
        numAcross = (pow(2,order))*2
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
    global fCurve, t, imgNum
    imgNum = 1
    t = 0
    fCurve = HilbertCurve(PVector(100,100), PVector(500,500),5, color(0))
    
    # fCurve.shiftPoints(t, 1)
    # fCurve.render()
    
def draw():
    background(0.5)
    global t, imgNum
    fCurve.shiftPoints(t, 1)
    fCurve.render()
    
    t += 0.01
    save("Shift" + str(imgNum) + ".png")
    imgNum+=1
    if t > 1:
        noLoop()
    
       
def mousePressed():
    global imgNum
    save(str(imgNum) + ".png")
    imgNum+=1
    
def keyPressed():
    global fCurve, t
    if key == '1':
        t = 0
        fCurve = HilbertCurve(PVector(100,100), PVector(500,500),5, color(0))
    elif key == '2':
        t = 0
        fCurve = GosperCurve(PVector(50,-100), PVector(400,200),4, color(0))
    elif key == '3':
        t = 0
        fCurve = SierpinskiCurve(PVector(100,100), PVector(500,500),3, color(0))
    elif key == '4':
        t = 0
        fCurve = SierpinskiSquareCurve(PVector(100,100), PVector(500,500),3, color(0))
    elif key == '5':
        t = 0
        fCurve = PeanoCurve(PVector(200,200), PVector(500,500),4, color(0))
    
    # noLoop()
