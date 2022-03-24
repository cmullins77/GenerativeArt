W, H = 1000, 600 #Dimensions of canvas
N = 10 #Number of cells

NW = 2
NH = 1

iN = 0

choice = 0


def setup():
    size(1000, 600, P3D)
    ortho(-W>>1, W>>1, -H>>1, H>>1)
    noStroke()
    smooth(8)
    
    global cells, R, time, ptList1, ptList2
    
    R = dist(0, 0, W, H) #Maximum radius
    time = 0
    
def keyPressed():
    global iN, ptList1, ptList2, cells, choice
    if key == "1":
        background(255)
        global time, cells
        cells = [] #Array list containing cell objects
        numPts = 6
        changeAmt = 1
        change = []
        for i in range(numPts):
            change.append((random(-changeAmt, changeAmt), random(-changeAmt, changeAmt)))
        for i in range(NW+4):
            for j in range(NH+4):
                ptList = []
                
                if (choice == 0):
                    p1 = Point(W/(NW+1) * (i-1), H/(NH+1) * (j-1))
                    ptList.append(p1)
                    for k in range(numPts-1):
                        p2 = Point(p1.pos.x + change[k][0], p1.pos.y + change[k][1])
                        ptList.append(p2)
                        p1 = p2
                elif choice == 1:
                    for k in range(numPts):
                        p = Point(ptList1[k].pos.x + change[k][0] + W/(NW+1) * (i-1) - W/(NW+1) * (-1), ptList1[k].pos.y + change[k][1]+ H/(NH+1) * (j-1) - H/(NH+1) * (-1))
                        ptList.append(p)
                else:
                    for k in range(numPts):
                        p = Point(ptList2[k].pos.x + change[k][0] + W/(NW+1) * (i-1) - W/(NW+1) * (-1), ptList2[k].pos.y + change[k][1]+ H/(NH+1) * (j-1) - H/(NH+1) * (-1))
                        ptList.append(p)
                cell = Cell(ptList)
                if i == 0 and j == 0:
                    ptList1 = ptList
                cells.append(cell)
        for c in cells:
            c.render()
        iN += 1
        save("VoronoiCellsV" + str(iN) + "A.png")
        
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
                
                if (choice == 0):
                    p1 = Point(W/(NW+1) * (i-1), H/(NH+1) * (j-1))
                    ptList.append(p1)
                    for k in range(numPts-1):
                        p2 = Point(p1.pos.x + change[k][0], p1.pos.y + change[k][1])
                        ptList.append(p2)
                        p1 = p2
                elif choice == 1:
                    for k in range(numPts):
                        p = Point(ptList1[k].pos.x + change[k][0] + W/(NW+1) * (i-1) - W/(NW+1) * (-1), ptList1[k].pos.y + change[k][1]+ H/(NH+1) * (j-1) - H/(NH+1) * (-1))
                        ptList.append(p)
                else:
                    for k in range(numPts):
                        p = Point(ptList2[k].pos.x + change[k][0] + W/(NW+1) * (i-1) - W/(NW+1) * (-1), ptList2[k].pos.y + change[k][1]+ H/(NH+1) * (j-1) - H/(NH+1) * (-1))
                        ptList.append(p)
                cell = Cell(ptList)
                if i == 0 and j == 0:
                    ptList2 = ptList
                cells.append(cell)
        for c in cells:
            c.render()
        save("VoronoiCellsV" + str(iN) + "B.png")
    elif key == "2":
        edgeDetection()
    elif key == "3":
        pass
    elif key == "a":
        choice = 1
        println("A")
    elif key == "b":
        choice = 2
        println("B")
    
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
        # pushStyle()
        # strokeWeight(8)
        # stroke(0)
        # point(0, 0, 0)
        # popStyle()
        
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
        
        # pushStyle()
        # strokeWeight(2)
        # stroke(0)
        # line(x1,y1,0,x2,y2,0);
        # popStyle()
        
        popMatrix()
        
def edgeDetection():
    h = 1;
    thetas = [0, 90, 45, 135]
    img = loadImage("VoronoiCellsV" + str(iN) + "A.png")
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

    save("EdgesV" + str(iN) + "A.jpg")
    
    img = loadImage("VoronoiCellsV" + str(iN) + "B.png")
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

    save("EdgesV" + str(iN) + "B.jpg")
