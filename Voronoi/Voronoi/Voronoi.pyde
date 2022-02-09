W, H = 1000, 600 #Dimensions of canvas
N = 10 #Number of cells

NW = 2
NH = 1

iN = 0


def setup():
    size(1000, 600, P3D)
    ortho(-W>>1, W>>1, -H>>1, H>>1)
    noStroke()
    smooth(8)
    
    global cells, R, time
    
    R = dist(0, 0, W, H) #Maximum radius
    time = 0
    
def keyPressed():
    if key == "1":
        background(255)
        global time, cells
        cells = [] #Array list containing cell objects
        numPts = 6
        changeAmt = 50
        change = []
        for i in range(numPts):
            change.append((random(-changeAmt, changeAmt), random(-changeAmt, changeAmt)))
        for i in range(NW+4):
            for j in range(NH+4):
                ptList = []
                p1 = Point(W/(NW+1) * (i-1), H/(NH+1) * (j-1))
                ptList.append(p1)
                for k in range(numPts-1):
                    p2 = Point(p1.pos.x + change[k][0], p1.pos.y + change[k][1])
                    ptList.append(p2)
                    p1 = p2
                cell = Cell(ptList)
                cells.append(cell)
        for c in cells:
            c.render()
        iN += 1
        save("VoronoiCells" + str(iN) + ".png")
    elif key == "2":
        edgeDetection()
    
def draw():
    pass


class Cell(object):
    def __init__(self, points):
        self.col = (random(255), random(255), random(255)) #random color
        
        self.points = points
        p1 = points[0]
        
        self.lines = []
        for p2 in points[1:]:
            p1.setColor(self.col)
            p2.setColor(self.col)
            l = Line(p1,p2)
            l.setColor(self.col)
            
            self.lines.append(l)
            p1 = p2
            
    
    def render(self):
        for p in self.points:
            p.render()
        for l in self.lines:
            l.render()
        
class Point:
    def __init__(self, x, y):
        self.pos = PVector(x, y)
        self.S = 60
        self.R = dist(0, 0, W, H)
        self.theta = radians(360)/self.S
    
    def setColor(self, col):
        self.col = col
        
    def render(self):
        # Translating coordinates
        pushMatrix()
        translate(self.pos.x, self.pos.y, 0)
        # Drawing a Cone (3D)
        fill(self.col[0], self.col[1], self.col[2])
        beginShape(TRIANGLE_STRIP)
        for i in xrange(self.S):
            vertex(0, 0, 0)
            vertex(self.R * cos(self.theta*i), self.R * sin(self.theta*i), -self.R)
            vertex(self.R * cos(self.theta*(i+1)), self.R * sin(self.theta*(i+1)), -self.R)
        endShape()
        
        # Drawing point at its center
        pushStyle()
        strokeWeight(8)
        stroke(0)
        point(0, 0, 0)
        popStyle()
        
        popMatrix()

class Line:
    def __init__(self, p1, p2):
        self.p1 = p1
        self.p2 = p2
        
        
    def setColor(self, col):
        self.col = col
        
    def render(self):
        x1 = self.p1.pos.x
        y1 = self.p1.pos.y
        x2 = self.p2.pos.x
        y2 = self.p2.pos.y
        
        xDiff = x2 - x1
        yDiff = y2 - y1
        
        d = dist(0, 0, W, H)
        
        ySlope = d
        xSlope = 0
        
        if (ySlope != 0):
            slope = xDiff/yDiff * -1
            theta = atan(slope)
            ySlope = sin(theta)*d
            xSlope = cos(theta)*d
        newX1 = x1 + xSlope
        newY1 = y1 + ySlope
    
        newPos1 = (newX1,newY1,-d)
    
        newX2 = x1 - xSlope
        newY2 = y1 - ySlope
    
        newPos2 = (newX2,newY2,-d)

        newX3 = x2 + xSlope 
        newY3 = y2 + ySlope
    
        newPos3 = (newX3,newY3,-d)
    
        newX4 = x2 - xSlope
        newY4 = y2 - ySlope
    
        newPos4 = (newX4,newY4,-d)
        
        # Translating coordinates
        pushMatrix()
        translate(0,0,0)
        # Drawing a Tent
        fill(self.col[0], self.col[1], self.col[2])
        beginShape()
        vertex(self.p1.pos.x,self.p1.pos.y,0)
        vertex(newPos1[0],newPos1[1],newPos1[2]);
        vertex(newPos3[0],newPos3[1],newPos3[2]);
        vertex(self.p2.pos.x, self.p2.pos.y,0)
        endShape()
        
        beginShape()
        vertex(self.p1.pos.x,self.p1.pos.y,0)
        vertex(newPos2[0],newPos2[1],newPos2[2]);
        vertex(newPos4[0],newPos4[1],newPos4[2]);
        vertex(self.p2.pos.x, self.p2.pos.y,0)
        endShape()
        
        pushStyle()
        strokeWeight(2)
        stroke(0)
        line(x1,y1,0,x2,y2,0);
        popStyle()
        
        popMatrix()
        
def edgeDetection():
    h = 1;
    thetas = [0, 90, 45, 135]
    img = loadImage("VoronoiCells" + str(iN) + ".png")
    for x in range(width):
        for y in range(height):
            neighbors = []
            if (x > 0 ):
                neighbors.append(img.get(x-1, y))
            if (x < width - 1):
                neighbors.append(img.get(x+1,y))
            if (y > 0 ):
                neighbors.append(img.get(x, y-1))
            if (y < height - 1):
                neighbors.append(img.get(x,y+1))
            
            currCol = img.get(x,y)
            edge = False
            for col in neighbors:
                if red(col) != red(currCol) or green(col) != green(currCol) or blue(col) != blue(currCol):
                    edge = True
                    break
            if edge:
                set(x,y,color(0))
            else:
                set(x,y,color(255))
            # maxDerivX = 0;
            # maxDerivY = 0;
      
            # for i in range(len(thetas)):
            #     theta = radians(thetas[i])
                
            #     x0 = abs(x - h * cos(theta))
            #     x1 = x + h * cos(theta)
            #     if (x1 >= width):
            #         x1 = width - 1
            #     y0 = abs(y - h * sin(theta))
            #     y1 = y + h * sin(theta)
            #     if (y1 >= height):
            #         y1 = height - 1
                
            #     c = get(int(x0), y)
            #     rX0 = red(c)
            #     gX0 = green(c)
            #     bX0 = blue(c)
            #     cX0 = (rX0 + gX0 + bX0)/3.0
            #     c = get(int(x1), y)
            #     rX1 = red(c)
            #     gX1 = green(c)
            #     bX1 = blue(c)
            #     cX1 = (rX1 + gX1 + bX1)/3.0
            #     c = get(int(x), int(y0))
            #     rY0 = red(c)
            #     gY0 = green(c)
            #     bY0 = blue(c)
            #     cY0 = (rY0 + gY0 + bY0)/3.0
            #     c = get(x, int(y1))
            #     rY1 = red(c)
            #     gY1 = green(c)
            #     bY1 = blue(c)
            #     cY1 = (rY1 + gY1 + bY1)/3.0
                
            #     derivX = abs(cX1 - cX0)
            #     derivY = abs(cY1 - cY0)
            #     derivX = (derivX + 1)/2.0
            #     derivY = (derivY + 1)/2.0
            #     maxDerivX = max(derivX, maxDerivX)
            #     maxDerivY = max(derivY, maxDerivY)
            # col = (maxDerivX + maxDerivY)/2.0;
            # if (col > 0.54):
            #     col = 0
            # else:
            #     col = 1
            # set(x,y, color(col,col,col))
    save("Edges" + str(iN) + ".jpg")
