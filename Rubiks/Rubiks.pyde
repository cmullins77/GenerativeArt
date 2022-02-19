cube = [[ #White
            [0, 0, 0],
             [0, 0, 0],
             [0, 0, 0]
             ],[ #Blue
             [1, 1, 1],
             [1, 1, 1],
             [1, 1, 1]
             ],[ #Orange
             [2, 2, 2],
             [2, 2, 2],
             [2, 2, 2]
             ],[ #Green
             [3, 3, 3],
             [3, 3, 3],
             [3, 3, 3]
             ],[ #Red
             [4, 4, 4],
             [4, 4, 4],
             [4, 4, 4]
             ],[ #Yellow
             [5, 5, 5],
             [5, 5, 5],
             [5, 5, 5]
             ]
            ]
initcube = [[ #White
            [0, 0, 0],
             [0, 0, 0],
             [0, 0, 0]
             ],[ #Blue
             [1, 1, 1],
             [1, 1, 1],
             [1, 1, 1]
             ],[ #Orange
             [2, 2, 2],
             [2, 2, 2],
             [2, 2, 2]
             ],[ #Green
             [3, 3, 3],
             [3, 3, 3],
             [3, 3, 3]
             ],[ #Red
             [4, 4, 4],
             [4, 4, 4],
             [4, 4, 4]
             ],[ #Yellow
             [5, 5, 5],
             [5, 5, 5],
             [5, 5, 5]
             ]
            ]

def rotateClockwise(face):
    s00 = face[2][0]
    s01 = face[1][0]
    s02 = face[0][0]
    s10 = face[2][1]
    s11 = face[1][1]
    s12 = face[0][1]
    s20 = face[2][2]
    s21 = face[1][2]
    s22 = face[0][2]
    
    newFace = [[s00, s01, s02],[s10, s11, s12],[s20, s21, s22]]
    return newFace

def rotateEdgeClockwise(r1f, r1, c1f, c1, r2f, r2, c2f, c2):
    fir = [cube[r1f][r1][0], cube[r1f][r1][1], cube[r1f][r1][2]]
    sec = [cube[c1f][0][c1], cube[c1f][1][c1], cube[c1f][2][c1]]
    thi = [cube[r2f][r2][2], cube[r2f][r2][1], cube[r2f][r2][0]]
    fou = [cube[c2f][2][c2], cube[c2f][1][c2], cube[c2f][0][c2]]
    
    cube[r1f][r1][0] = fou[0]
    cube[r1f][r1][1] = fou[1]
    cube[r1f][r1][2] = fou[2]
    
    cube[c1f][0][c1] = fir[0]
    cube[c1f][1][c1] = fir[1]
    cube[c1f][2][c1] = fir[2]
    
    cube[r2f][r2][2] = sec[0]
    cube[r2f][r2][1] = sec[1]
    cube[r2f][r2][0] = sec[2]
    
    cube[c2f][2][c2] = thi[0]
    cube[c2f][1][c2] = thi[1]
    cube[c2f][0][c2] = thi[2]
    
def rotateEdgeClockwise2(c1f, c1, c2f, c2, c3f, c3, c4f, c4):
    fir = [cube[c1f][2][c1], cube[c1f][1][c1], cube[c1f][0][c1]]
    sec = [cube[c2f][0][c2], cube[c2f][1][c2], cube[c2f][2][c2]]
    thi = [cube[c3f][2][c3], cube[c3f][1][c3], cube[c3f][0][c3]]
    fou = [cube[c4f][2][c4], cube[c4f][1][c4], cube[c4f][0][c4]]
    
    cube[c1f][2][c1] = fou[0]
    cube[c1f][1][c1] = fou[1]
    cube[c1f][0][c1] = fou[2]
    
    cube[c2f][0][c2] = fir[0]
    cube[c2f][1][c2] = fir[1]
    cube[c2f][2][c2] = fir[2]
    
    cube[c3f][2][c3] = sec[0]
    cube[c3f][1][c3] = sec[1]
    cube[c3f][0][c3] = sec[2]
    
    cube[c4f][2][c4] = thi[0]
    cube[c4f][1][c4] = thi[1]
    cube[c4f][0][c4] = thi[2]
    
def rotateEdgeClockwise3(r1f, r1, r2f, r2, r3f, r3, r4f, r4):
    fir = [cube[r1f][r1][2], cube[r1f][r1][1], cube[r1f][r1][0]]
    sec = [cube[r2f][r2][2], cube[r2f][r2][1], cube[r2f][r2][0]]
    thi = [cube[r3f][r3][2], cube[r3f][r3][1], cube[r3f][r3][0]]
    fou = [cube[r4f][r4][2], cube[r4f][r4][1], cube[r4f][r4][0]]
    
    cube[r1f][r1][2] = fou[0]
    cube[r1f][r1][1] = fou[1]
    cube[r1f][r1][0]= fou[2]
    
    cube[r2f][r2][2] = fir[0]
    cube[r2f][r2][1] = fir[1]
    cube[r2f][r2][0] = fir[2]
    
    cube[r3f][r3][2] = sec[0]
    cube[r3f][r3][1] = sec[1]
    cube[r3f][r3][0] = sec[2]
    
    cube[r4f][r4][2] = thi[0]
    cube[r4f][r4][1] = thi[1]
    cube[r4f][r4][0] = thi[2]
    
def rotateCounterClockwise(face):
    s00 = face[0][2]
    s01 = face[1][2]
    s02 = face[2][2]
    s10 = face[0][1]
    s11 = face[1][1]
    s12 = face[2][1]
    s20 = face[0][0]
    s21 = face[1][0]
    s22 = face[2][0]
    
    newFace = [[s00, s01, s02],[s10, s11, s12],[s20, s21, s22]]
    return newFace

def rotateEdgeCounterClockwise(r1f, r1, c1f, c1, r2f, r2, c2f, c2):
    fir = [cube[r1f][r1][0], cube[r1f][r1][1], cube[r1f][r1][2]]
    sec = [cube[c1f][0][c1], cube[c1f][1][c1], cube[c1f][2][c1]]
    thi = [cube[r2f][r2][2], cube[r2f][r2][1], cube[r2f][r2][0]]
    fou = [cube[c2f][2][c2], cube[c2f][1][c2], cube[c2f][0][c2]]
    
    cube[r1f][r1][0] = sec[0]
    cube[r1f][r1][1] = sec[1]
    cube[r1f][r1][2] = sec[2]
    
    cube[c1f][0][c1] = thi[0]
    cube[c1f][1][c1] = thi[1]
    cube[c1f][2][c1] = thi[2]
    
    cube[r2f][r2][2] = fou[0]
    cube[r2f][r2][1] = fou[1]
    cube[r2f][r2][0] = fou[2]
    
    cube[c2f][2][c2] = fir[0]
    cube[c2f][1][c2] = fir[1]
    cube[c2f][0][c2] = fir[2]
    
def rotateEdgeCounterClockwise2(c1f, c1, c2f, c2, c3f, c3, c4f, c4):
    fir = [cube[c1f][2][c1], cube[c1f][1][c1], cube[c1f][0][c1]]
    sec = [cube[c2f][0][c2], cube[c2f][1][c2], cube[c2f][2][c2]]
    thi = [cube[c3f][2][c3], cube[c3f][1][c3], cube[c3f][0][c3]]
    fou = [cube[c4f][2][c4], cube[c4f][1][c4], cube[c4f][0][c4]]
    
    cube[c1f][2][c1] = sec[0]
    cube[c1f][1][c1] = sec[1]
    cube[c1f][0][c1] = sec[2]
    
    cube[c2f][0][c2] = thi[0]
    cube[c2f][1][c2] = thi[1]
    cube[c2f][2][c2] = thi[2]
    
    cube[c3f][2][c3] = fou[0]
    cube[c3f][1][c3] = fou[1]
    cube[c3f][0][c3] = fou[2]
    
    cube[c4f][2][c4] = fir[0]
    cube[c4f][1][c4] = fir[1]
    cube[c4f][0][c4] = fir[2]
    
def rotateEdgeCounterClockwise3(r1f, r1, r2f, r2, r3f, r3, r4f, r4):
    fir = [cube[r1f][r1][2], cube[r1f][r1][1], cube[r1f][r1][0]]
    sec = [cube[r2f][r2][2], cube[r2f][r2][1], cube[r2f][r2][0]]
    thi = [cube[r3f][r3][2], cube[r3f][r3][1], cube[r3f][r3][0]]
    fou = [cube[r4f][r4][2], cube[r4f][r4][1], cube[r4f][r4][0]]
    
    cube[r1f][r1][2] = sec[0]
    cube[r1f][r1][1] = sec[1]
    cube[r1f][r1][0] = sec[2]
    
    cube[r2f][r2][2] = thi[0]
    cube[r2f][r2][1] = thi[1]
    cube[r2f][r2][0] = thi[2]
    
    cube[r3f][r3][2] = fou[0]
    cube[r3f][r3][1] = fou[1]
    cube[r3f][r3][0] = fou[2]
    
    cube[r4f][r4][2] = fir[0]
    cube[r4f][r4][1] = fir[1]
    cube[r4f][r4][0] = fir[2]

def F():
    global cube
    face = cube[1]
    newFace = rotateClockwise(face)
    cube[1] = newFace
    rotateEdgeClockwise(5, 2, 4, 0, 0, 0, 2, 2)
    
def FPrime():
    global cube
    face = cube[1]
    newFace = rotateCounterClockwise(face)
    cube[1] = newFace
    rotateEdgeCounterClockwise(5, 2, 4, 0, 0, 0, 2, 2)
    
def B():
    global cube
    face = cube[3]
    newFace = rotateClockwise(face)
    cube[3] = newFace
    rotateEdgeClockwise(5, 0, 2, 0, 0, 2, 4, 2)
    
def BPrime():
    global cube
    face = cube[3]
    newFace = rotateCounterClockwise(face)
    cube[3] = newFace
    rotateEdgeCounterClockwise(5, 0, 2, 0, 0, 2, 4, 2)

def R():
    global cube
    face = cube[4]
    newFace = rotateClockwise(face)
    cube[4] = newFace
    rotateEdgeClockwise2(5, 2, 3, 0, 0, 2, 1, 2)
    
def RPrime():
    global cube
    face = cube[4]
    newFace = rotateCounterClockwise(face)
    cube[4] = newFace
    rotateEdgeCounterClockwise2(5, 2, 3, 0, 0, 2, 1, 2)
    
def L():
    global cube
    face = cube[2]
    newFace = rotateClockwise(face)
    cube[2] = newFace
    rotateEdgeClockwise2(5, 0, 1, 0, 0, 0, 3, 2)
    
def LPrime():
    global cube
    face = cube[2]
    newFace = rotateCounterClockwise(face)
    cube[2] = newFace
    rotateEdgeCounterClockwise2(5, 0, 1, 0, 0, 0, 3, 2)
    
def U():
    global cube
    face = cube[5]
    newFace = rotateClockwise(face)
    cube[5] = newFace
    rotateEdgeClockwise3(3, 0, 4, 0, 1, 0, 2, 0)
    
def UPrime():
    global cube
    face = cube[5]
    newFace = rotateCounterClockwise(face)
    cube[5] = newFace
    rotateEdgeCounterClockwise3(3, 0, 4, 0, 1, 0, 2, 0)
    
def D():
    global cube
    face = cube[0]
    newFace = rotateClockwise(face)
    cube[0] = newFace
    rotateEdgeClockwise3(1, 2, 4, 2, 3, 2, 2, 2)
    
def DPrime():
    global cube
    face = cube[0]
    newFace = rotateCounterClockwise(face)
    cube[0] = newFace
    rotateEdgeCounterClockwise3(1, 2, 4, 2, 3, 2, 2, 2)
    
    
def doMove(num):
    if num == 0:
        F()
    elif num == 1:
        FPrime()
    elif num == 2:
        B()
    elif num == 3:
        BPrime()
    elif num == 4:
        R()
    elif num == 5:
        RPrime()
    elif num == 6:
        L()
    elif num == 7:
        LPrime()
    elif num == 8:
        U()
    elif num == 9:
        UPrime()
    elif num == 10:
        D()
    else:
        DPrime()
        
def checkSolve(c):
    wrongSquares = 0
    for i in range(len(c)):
        f = c[i]
        gf = initcube[i]
        for j in range(len(f)):
            r = f[j]
            gr = gf[j]
            for k in range(len(r)):
                 s = r[k]
                 gs = gr[k]
                 if s != gs:
                     wrongSquares += 1
    return wrongSquares     

def generateNextCubes():
    global cube, moves
    global movesV1, movesV2, num1, num2
    
    
    movesV1 = moves
    numChanges = int(random(1,6))
    for i in range(0, numChanges):
        changeIndex = int(random(0, len(moves)-1))
        newMove = int(random(0,11))
        movesV1[changeIndex] = newMove
        
    cube = copyCube(startCube)
    print("Current Cube: " + str(checkSolve(cube)))
    for m in movesV1:
        doMove(m)
        ws = checkSolve(cube)
        # print("Current State: " + str(ws))
    num1 = ws
    
    movesV2 = moves
    numChanges = int(random(1,6))
    for i in range(0, numChanges):
        changeIndex = int(random(0, len(moves)-1))
        newMove = int(random(0,11))
        movesV2[changeIndex] = newMove
        
    cube = copyCube(startCube)
    for m in movesV2:
        doMove(m)
        ws = checkSolve(cube)
        # print("Current State: " + str(ws))
    num2 = ws
    
    if (num1 < num2):
        moves = movesV1
    else:
        moves = movesV2
    
    setCurrState()
        
def setCurrState():
    global moves, cube, startCube, imgNum
    cube = copyCube(startCube)
    for m in moves:
        doMove(m)
    renderCube()
    save("Cube" + str(imgNum) + ".jpg")
    imgNum += 1
    
def setup():
    global imgNum
    global startCube, cube, moves
    global movesV1, movesV2, num1, num2
    
    imgNum = 1
    
    size(900, 600)
    colorMode(RGB,1)
    for i in range(20):
        doMove(int(random(0,11)))
    print("WS " + str(checkSolve(cube)))    
    renderCube()
    save("Cube" + str(imgNum) + ".jpg")
    imgNum += 1
    
    frameRate(10)
    
    startCube = copyCube(cube)
    print(cube)
    movesV1 = []
    for i in range(20):
        move = int(random(0, 11))
        movesV1.append(move)
        doMove(move)
        ws = checkSolve(cube)
        print("Current State: " + str(ws))
    num1 = ws
    
    cube = copyCube(startCube)
    print(cube)
    print("RESTART!")
    print("Start State: " + str(checkSolve(cube)))
    movesV2 = []
    for i in range(20):
        move = int(random(0, 11))
        movesV2.append(move)
        doMove(move)
        ws = checkSolve(cube)
        print("Current State: " + str(ws))
    num2 = ws
    
    if (num1 < num2):
        moves = movesV1
    else:
        moves = movesV2
    
    setCurrState()
    
    global time
    time = 0
   
def copyCube(c):
    newC = []
    for f in c:
        newF = []
        for r in f:
            newR = []
            for s in r:
                newR.append(s)
            newF.append(newR)
        newC.append(newF)
    return newC


def draw():
    generateNextCubes()
    
def keyPressed():
    generateNextCubes()
    
def renderCube():
    x = 0
    y = 15
    faceCount = 0
    for face in cube:
        for row in face:
            x = 15
            if faceCount == 1 or faceCount == 4:
                x = 315
            elif faceCount == 2 or faceCount == 5:
                x = 615
            for squ in row:
                if squ == 0:
                    fill(1,1,1)
                elif squ == 1:
                    fill(.2,.24,.61)
                elif squ == 2:
                    fill(.73,0.47,.2)
                elif squ == 3:
                    fill(.54,.95,.54)
                elif squ == 4:
                    fill(.7,.2,.2)
                else:
                    fill(1,.98,.4)
                rect(x,y,90,90)
                x += 90
            y += 90
            
        faceCount+=1
        x = 15
        if faceCount == 1 or faceCount == 4:
            x = 315
        elif faceCount == 2 or faceCount == 5:
            x = 615
        y = 15
        if faceCount > 2:
            y = 315
        
    
