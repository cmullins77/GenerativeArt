from pickletools import pylong
import random
from Gene import Gene
import math

class Door:
    #Genes
    #0: Twists: 0 - 7
    #1: Knob Version: 0 - 9
    #2: Knob Position X: 0.0 - 0.1
    #3: Knob Position Y: -0.1 - 0.1
    #4: Knob Base Size X: 0.05 - 0.12
    #5: Knob Base Size Y: KnobStemSizeX*KnobBaseSizeX - KnobBaseSizeX*2
    #6: Knob Base Size Z: 0.0 - 0.07
    #7: Knob Stem Size X: 0.2 - 0.6
    #8: Knob Stem Size Y: 0.03 - 0.15
    #9: Knob Round Size X: 1.5 - 3.0
    #10: Knob Round Size Y: 0.15 - 0.5
    #11: Knob Stem Overlap: 0.0 - 1.0
    #12: Knob Extrusion Size X: 0.0 - 1.0
    #13: Knob Extrusion Size Y: 0.0 - 1.0
    #14: Knob Bevel 1: 0.0 - 1.0
    #15: Knob Bevel 2: 0.0 - 1.0

    #16: Total Door Height: 3.0 - 5.0
    #17: Color_M: 0.0 - 1.0
    #18: First Section Percentage: 1 if Second Section Type == 0, else 0.25 - 0.75
    #19: First Section Type: 0 - 2
    #20: Second Section Type: 0 - 1 (higher change of 0)
    #21: Door Size X: 1.75 - 2.5
    #22: Door Size Z: 0.05 - 0.2
    #23: Num Panels: 1 - 4
    # 24: Panel Groove Size X: 0.005 - 0.055
    # 25: Panel Groove Size Y: 0.0 - 0.9
    # 26: Stile Width: 0.015 - 0.2 
    # 27: Mid Mull Width: 0.015 - 0.2
    # 28: Panel Size X: 0.005 - 0.2
    # 29: Groove Angle: -1.0 - 1.0
    # 30: Vertical Spacing X: 0.05 - 1
    # 31: Vertical Spacing Y: 0.05 - 1
    # 32: Vertical Spacing Z: 0.05 - 1
    # 33: Vertical Panel Sizes X: 0.1 - 2.5
    # 34: Vertical Panel Sizes Y: 0.1 - 2.5
    # 35: Vertical Panel Sizes Z: 0.1 - 2.5
    # 36: Vertical Panel Sizes W: 0.1 - 2.5
    # 37: Number Vertical Panels: 1 - 4
    # 38: Has Panel Borders: 0 - 1 (higher chance of 0)
    # 39: Panel Border Size X: 0.015 - 0.075
    # 40: Panel Border Size Y: 0 - 0.1
    # 41: Panel Border Size Z: 0 - 0.05
    # 42: Second Goes Across: 0 - 1 (higher change of 0)
    # 43: Number Windows X: 1 - 8
    # 44: Number Windows Y: 1 - 6
    # 45: Window Gap X: 0.01 - 0.12
    # 46: Window Gap Y: 0 - 0.2
    # 47: Window Gap Z: 0.1 - 0.4
    # 48: Number of Planks: 1 - 30
    
    # 49: Arch Shape: 0 - 1
    # 50: Doorway Size X: 0.0 - 0.6
    # 51: Num Bricks: 3 - 10
    # 52: Brick Size: 0.5 - 1.0
    # 53: Brick Bevel: .015 - .09
    # 54: Arch Type: 0 - 4
    # 55: Scale Bits X: 0.4 - 1.2
    # 56: Scale Bits Y: .02 - .3
    # 57: First Section: .1 - .5
    # 58: Last Section: .1 - .5
    # 59: Num Arch Bits: 1 - 10
    # 60 - 69: Arch Bit: 8 Nums each: 0.01 - .4
    # 70: Use Bits: 0 - 1
    # 71: Has Section Above Door: 0 - 1
    # 72: Above Door Height: DoorSizeX*0.5 - DoorSizeX*1.5
    # 73: Separator Size: 0.02 - 0.14
    # 74: Above Version: 0 - 2
    # 75: Num Windows Top: 2 - 8

    def __init__(self, geneList):

        ###################### Knob Genes ##########################################

        self.twists = Gene(geneList[0], 8, 0, 7, False)

        self.knobVersion = Gene(geneList[1], 10, 0, 9, False)

        self.knobPositionX = Gene(geneList[2], 3, 0, 0.1, True)
        self.knobPositionY = Gene(geneList[3], 3, -.1, .1, True)

        self.knobBaseSizeX = Gene(geneList[4], 3, 0.05, 0.12, True)
        self.knobBaseSizeZ = Gene(geneList[6], 3, 0, 0.07, True)

        self.knobStemSizeX = Gene(geneList[7], 3, 0.2, 0.6, True)
        self.knobStemSizeY = Gene(geneList[8], 3, 0.03, 0.15, True)

        self.knobRoundSizeX = Gene(geneList[9], 3, 1.5, 3, True)
        self.knobRoundSizeY = Gene(geneList[10], 3, .15, .5, True)

        self.knobStemOverlap = Gene(geneList[11], 3, 0, 1, True)

        self.knobExtrusionSizeX = Gene(geneList[12], 3, 0, 1, True)
        self.knobExtrusionSizeY = Gene(geneList[13], 3, 0, 1, True)

        self.knobBevel1 = Gene(geneList[14], 3, 0, 1, True)
        self.knobBevel2 = Gene(geneList[15], 3, 0, 1, True)

        self.knobBaseSizeY = Gene(geneList[5], 3, self.knobStemSizeX.value*self.knobBaseSizeX.value, self.knobBaseSizeX.value*2, True)



        ###################### Door Genes #############################################

        self.totalDoorHeight = Gene(geneList[16], 3, 3.5, 4.5, True)

        self.color_M = Gene(geneList[17], 6, 0, 1, True)

        self.firstSectionPercentage = Gene(geneList[18], 3, 0.25, 0.75, True)

        self.firstSectionType = Gene(geneList[19], 4, 0, 3, False)
        self.secondSectionType = Gene(geneList[20], 2, 0, 1, False)

        if geneList[20] == 0:
            self.firstSectionPercentage.value = 1

        self.doorSizeX = Gene(geneList[21], 3, 1.75, 2.25, True)
        self.doorSizeZ = Gene(geneList[22], 3, 0.2, .5, True)

        self.numPanels = Gene(geneList[23], 4, 1, 4, False)

        self.panelGrooveSizeX = Gene(geneList[24], 3, 0.005, 0.055, True)
        self.panelGrooveSizeY = Gene(geneList[25], 3, .5, .9, True)

        self.stileWidth = Gene(geneList[26], 3, 0.015, .2, True)

        self.midMullWidth = Gene(geneList[27], 3, 0.015, 0.2, True)

        self.panelSizeX = Gene(geneList[28], 3, 0.005, .2, True)

        self.grooveAngle = Gene(geneList[29], 3, -1, 1, True)



        self.verticalSpacingX = Gene(geneList[30], 3, 0.05, 1, True)
        self.verticalSpacingY = Gene(geneList[31], 3, 0.05, 1, True)
        self.verticalSpacingZ = Gene(geneList[32], 3, 0.05, 1, True)

        self.verticalPanelSizesX = Gene(geneList[33], 3, .1, 2.5, True)
        self.verticalPanelSizesY = Gene(geneList[34], 3, .1, 2.5, True)
        self.verticalPanelSizesZ = Gene(geneList[35], 3, .1, 2.5, True)
        self.verticalPanelSizesW = Gene(geneList[36], 3, .1, 2.5, True)

        self.numberVerticalPanels = Gene(geneList[37], 4, 1, 4, False)

        self.hasPanelBorders = Gene(geneList[38], 2, 0, 1, False)

        self.panelBorderSizeX = Gene(geneList[39], 3, 0.015, 0.075, True)
        self.panelBorderSizeY = Gene(geneList[40], 3, 0, .1, True)
        self.panelBorderSizeZ = Gene(geneList[41], 3, 0, 0.05, True)

        self.secondGoesAcross = Gene(geneList[42], 2, 0, 1, False)
 


        self.numWindowsX = Gene(geneList[43], 8, 1, 8, False)
        self.numWindowsY = Gene(geneList[44], 6, 1, 6, False)

        self.windowGapX = Gene(geneList[45], 3, 0.01, 0.12, True)
        self.windowGapY = Gene(geneList[46], 3, 0, 0.2, True)
        self.windowGapZ = Gene(geneList[47], 3, 0.1, .4, True)

        self.numPlanks = Gene(geneList[48], 10, 1, 30, True)



        ###################### Arch Genes #############################################

        self.archShape = Gene(geneList[49], 2, 0, 1, False)

        self.doorwaySizeX = Gene(geneList[50], 3, 0, 0.6, True)

        self.numBricks = Gene(geneList[51], 4, 3, 10, True)
        self.brickSize = Gene(geneList[52], 3, 0.5, 1, True)
        self.brickBevel = Gene(geneList[53], 3, 0.015, 0.09, True)

        self.archType = Gene(geneList[54], 5, 0, 4, False)

        self.scaleBitsX = Gene(geneList[55], 3, 0.4, 1.2, True)
        self.scaleBitsY = Gene(geneList[56], 3, 0.02, .3, True)

        self.firstSection = Gene(geneList[57], 3, 0.1, .5, True)
        self.lastSection = Gene(geneList[58], 3, 0.1, .5, True)

        self.numArchBits = Gene(geneList[59], 5, 1, 10, True)



        self.archBits11 = Gene(geneList[60][0], 3, 0.01, 0.4, True)
        self.archBits12 = Gene(geneList[60][1], 3, 0.01, 0.4, True)
        self.archBits13 = Gene(geneList[60][2], 3, 0.01, 0.4, True)
        self.archBits14 = Gene(geneList[60][3], 3, 0.01, 0.4, True)
        self.archBits15 = Gene(geneList[60][4], 3, 0.01, 0.4, True)
        self.archBits16 = Gene(geneList[60][5], 3, 0.01, 0.4, True)
        self.archBits17 = Gene(geneList[60][6], 3, 0.01, 0.4, True)
        self.archBits18 = Gene(geneList[60][7], 3, 0.01, 0.4, True)

        self.archBits21 = Gene(geneList[61][0], 3, 0.01, 0.4, True)
        self.archBits22 = Gene(geneList[61][1], 3, 0.01, 0.4, True)
        self.archBits23 = Gene(geneList[61][2], 3, 0.01, 0.4, True)
        self.archBits24 = Gene(geneList[61][3], 3, 0.01, 0.4, True)
        self.archBits25 = Gene(geneList[61][4], 3, 0.01, 0.4, True)
        self.archBits26 = Gene(geneList[61][5], 3, 0.01, 0.4, True)
        self.archBits27 = Gene(geneList[61][6], 3, 0.01, 0.4, True)
        self.archBits28 = Gene(geneList[61][7], 3, 0.01, 0.4, True)

        self.archBits31 = Gene(geneList[62][0], 3, 0.01, 0.4, True)
        self.archBits32 = Gene(geneList[62][1], 3, 0.01, 0.4, True)
        self.archBits33 = Gene(geneList[62][2], 3, 0.01, 0.4, True)
        self.archBits34 = Gene(geneList[62][3], 3, 0.01, 0.4, True)
        self.archBits35 = Gene(geneList[62][4], 3, 0.01, 0.4, True)
        self.archBits36 = Gene(geneList[62][5], 3, 0.01, 0.4, True)
        self.archBits37 = Gene(geneList[62][6], 3, 0.01, 0.4, True)
        self.archBits38 = Gene(geneList[62][7], 3, 0.01, 0.4, True)

        self.archBits41 = Gene(geneList[63][0], 3, 0.01, 0.4, True)
        self.archBits42 = Gene(geneList[63][1], 3, 0.01, 0.4, True)
        self.archBits43 = Gene(geneList[63][2], 3, 0.01, 0.4, True)
        self.archBits44 = Gene(geneList[63][3], 3, 0.01, 0.4, True)
        self.archBits45 = Gene(geneList[63][4], 3, 0.01, 0.4, True)
        self.archBits46 = Gene(geneList[63][5], 3, 0.01, 0.4, True)
        self.archBits47 = Gene(geneList[63][6], 3, 0.01, 0.4, True)
        self.archBits48 = Gene(geneList[63][7], 3, 0.01, 0.4, True)

        self.archBits51 = Gene(geneList[64][0], 3, 0.01, 0.4, True)
        self.archBits52 = Gene(geneList[64][1], 3, 0.01, 0.4, True)
        self.archBits53 = Gene(geneList[64][2], 3, 0.01, 0.4, True)
        self.archBits54 = Gene(geneList[64][3], 3, 0.01, 0.4, True)
        self.archBits55 = Gene(geneList[64][4], 3, 0.01, 0.4, True)
        self.archBits56 = Gene(geneList[64][5], 3, 0.01, 0.4, True)
        self.archBits57 = Gene(geneList[64][6], 3, 0.01, 0.4, True)
        self.archBits58 = Gene(geneList[64][7], 3, 0.01, 0.4, True)

        self.archBits61 = Gene(geneList[65][0], 3, 0.01, 0.4, True)
        self.archBits62 = Gene(geneList[65][1], 3, 0.01, 0.4, True)
        self.archBits63 = Gene(geneList[65][2], 3, 0.01, 0.4, True)
        self.archBits64 = Gene(geneList[65][3], 3, 0.01, 0.4, True)
        self.archBits65 = Gene(geneList[65][4], 3, 0.01, 0.4, True)
        self.archBits66 = Gene(geneList[65][5], 3, 0.01, 0.4, True)
        self.archBits67 = Gene(geneList[65][6], 3, 0.01, 0.4, True)
        self.archBits68 = Gene(geneList[65][7], 3, 0.01, 0.4, True)

        self.archBits71 = Gene(geneList[66][0], 3, 0.01, 0.4, True)
        self.archBits72 = Gene(geneList[66][1], 3, 0.01, 0.4, True)
        self.archBits73 = Gene(geneList[66][2], 3, 0.01, 0.4, True)
        self.archBits74 = Gene(geneList[66][3], 3, 0.01, 0.4, True)
        self.archBits75 = Gene(geneList[66][4], 3, 0.01, 0.4, True)
        self.archBits76 = Gene(geneList[66][5], 3, 0.01, 0.4, True)
        self.archBits77 = Gene(geneList[66][6], 3, 0.01, 0.4, True)
        self.archBits78 = Gene(geneList[66][7], 3, 0.01, 0.4, True)

        self.archBits81 = Gene(geneList[67][0], 3, 0.01, 0.4, True)
        self.archBits82 = Gene(geneList[67][1], 3, 0.01, 0.4, True)
        self.archBits83 = Gene(geneList[67][2], 3, 0.01, 0.4, True)
        self.archBits84 = Gene(geneList[67][3], 3, 0.01, 0.4, True)
        self.archBits85 = Gene(geneList[67][4], 3, 0.01, 0.4, True)
        self.archBits86 = Gene(geneList[67][5], 3, 0.01, 0.4, True)
        self.archBits87 = Gene(geneList[67][6], 3, 0.01, 0.4, True)
        self.archBits88 = Gene(geneList[67][7], 3, 0.01, 0.4, True)

        self.archBits91 = Gene(geneList[68][0], 3, 0.01, 0.4, True)
        self.archBits92 = Gene(geneList[68][1], 3, 0.01, 0.4, True)
        self.archBits93 = Gene(geneList[68][2], 3, 0.01, 0.4, True)
        self.archBits94 = Gene(geneList[68][3], 3, 0.01, 0.4, True)
        self.archBits95 = Gene(geneList[68][4], 3, 0.01, 0.4, True)
        self.archBits96 = Gene(geneList[68][5], 3, 0.01, 0.4, True)
        self.archBits97 = Gene(geneList[68][6], 3, 0.01, 0.4, True)
        self.archBits98 = Gene(geneList[68][7], 3, 0.01, 0.4, True)

        self.archBits101 = Gene(geneList[69][0], 3, 0.01, 0.4, True)
        self.archBits102 = Gene(geneList[69][1], 3, 0.01, 0.4, True)
        self.archBits103 = Gene(geneList[69][2], 3, 0.01, 0.4, True)
        self.archBits104 = Gene(geneList[69][3], 3, 0.01, 0.4, True)
        self.archBits105 = Gene(geneList[69][4], 3, 0.01, 0.4, True)
        self.archBits106 = Gene(geneList[69][5], 3, 0.01, 0.4, True)
        self.archBits107 = Gene(geneList[69][6], 3, 0.01, 0.4, True)
        self.archBits108 = Gene(geneList[69][7], 3, 0.01, 0.4, True)


        self.useBits = Gene(geneList[70], 6, 0, 5, False)

        self.hasSectionAboveDoor = Gene(geneList[71], 5, 0, 4, False)
        self.aboveDoorHeight = Gene(geneList[72], 3, self.doorSizeX.value*0.5, self.doorSizeX.value*1.5, True)

        self.separatorSize = Gene(geneList[73], 3, 0.02, 0.14, True)

        self.aboveVersion = Gene(geneList[74], 3, 0, 2, False)

        self.numWindows = Gene(geneList[75], 7, 2, 8, False)

        self.firstSectionType2 = Gene(geneList[76], 4, 0, 3, False)

        self.geneList = [self.twists, self.knobVersion, self.knobPositionX, self.knobPositionY, self.knobBaseSizeX, self.knobBaseSizeY, self.knobBaseSizeZ, self.knobStemSizeX, self.knobStemSizeY, self.knobRoundSizeX, self.knobRoundSizeY, self.knobStemOverlap, self.knobExtrusionSizeX, self.knobExtrusionSizeY, self.knobBevel1, self.knobBevel2, self.totalDoorHeight, self.color_M, self.firstSectionPercentage, self.firstSectionType, self.secondSectionType, self.doorSizeX, self.doorSizeZ, self.numPanels, self.panelGrooveSizeX, self.panelGrooveSizeY, self.stileWidth, self.midMullWidth, self.panelSizeX, self.grooveAngle, self.verticalSpacingX, self.verticalSpacingY, self.verticalSpacingZ, self.verticalPanelSizesX, self.verticalPanelSizesY, self.verticalPanelSizesZ, self.verticalPanelSizesW, self.numberVerticalPanels, self.hasPanelBorders, self.panelBorderSizeX, self.panelBorderSizeY, self.panelBorderSizeZ, self.secondGoesAcross, self.numWindowsX, self.numWindowsY, self.windowGapX, self.windowGapY, self.windowGapZ, self.numPlanks, self.archShape, self.doorwaySizeX, self.numBricks, self.brickSize, self.brickBevel, self.archType, self.scaleBitsX, self.scaleBitsY, self.firstSection, self.lastSection, self.numArchBits, [self.archBits11, self.archBits12, self.archBits13, self.archBits14, self.archBits15, self.archBits16, self.archBits17, self.archBits18], [self.archBits21, self.archBits22, self.archBits23, self.archBits24, self.archBits25, self.archBits26, self.archBits27, self.archBits28], [self.archBits31, self.archBits32, self.archBits33, self.archBits34, self.archBits35, self.archBits36, self.archBits37, self.archBits38], [self.archBits41, self.archBits42, self.archBits43, self.archBits44, self.archBits45, self.archBits46, self.archBits47, self.archBits48], [self.archBits51, self.archBits52, self.archBits53, self.archBits54, self.archBits55, self.archBits56, self.archBits57, self.archBits58], [self.archBits61, self.archBits62, self.archBits63, self.archBits64, self.archBits65, self.archBits66, self.archBits67, self.archBits68], [self.archBits71, self.archBits72, self.archBits73, self.archBits74, self.archBits75, self.archBits76, self.archBits77, self.archBits78], [self.archBits81, self.archBits82, self.archBits83, self.archBits84, self.archBits85, self.archBits86, self.archBits87, self.archBits88], [self.archBits91, self.archBits92, self.archBits93, self.archBits94, self.archBits95, self.archBits96, self.archBits97, self.archBits98], [self.archBits101, self.archBits102, self.archBits103, self.archBits104, self.archBits105, self.archBits106, self.archBits107, self.archBits108], self.useBits, self.hasSectionAboveDoor, self.aboveDoorHeight, self.separatorSize, self.aboveVersion, self.numWindows, self.firstSectionType2]


    def mutate(self, percent):
        numGenes = len(self.geneList)
        
        geneValueList = []
        for i in range(numGenes):
            if (random.random() <= percent/100.0):
                if isinstance(self.geneList[i], list):
                    newList = []
                    for j in range(len(self.geneList[i])):
                        value = self.geneList[i][j].mutateGene()
                        newList.append(value)
                    geneValueList.append(newList)
                else:
                    value = self.geneList[i].mutateGene()
                    geneValueList.append(value)
            else:
                if isinstance(self.geneList[i], list):
                    newList = []
                    for j in range(len(self.geneList[i])):
                        value = self.geneList[i][j].geneNum
                        newList.append(value)
                    geneValueList.append(newList)
                else:
                    value = self.geneList[i].geneNum
                    geneValueList.append(value)

        return Door(geneValueList)
        

class DoorGeneGenerator:
    def __init__(self):

        ###################### Knob Genes ##########################################

        self.twists = random.randint(0,7)

        self.knobVersion = random.randint(0,9)

        self.knobPositionX = random.randint(0,2)
        self.knobPositionY = random.randint(0,2)

        self.knobBaseSizeX = random.randint(0,2)
        self.knobBaseSizeZ = random.randint(0,2)

        self.knobStemSizeX = random.randint(0,2)
        self.knobStemSizeY = random.randint(0,2)

        self.knobRoundSizeX = random.randint(0,2)
        self.knobRoundSizeY = random.randint(0,2)

        self.knobStemOverlap = random.randint(0,2)

        self.knobExtrusionSizeX = random.randint(0,2)
        self.knobExtrusionSizeY = random.randint(0,2)

        self.knobBevel1 = random.randint(0,2)
        self.knobBevel2 = random.randint(0,2)

        self.knobBaseSizeY = random.randint(0,2)



        ###################### Door Genes #############################################

        self.totalDoorHeight = random.randint(0,2)

        self.color_M = random.randint(0,5)

        self.firstSectionPercentage = random.randint(0,2)

        self.firstSectionType = random.randint(0,3)
        self.firstSectionType2 = random.randint(0,3)
        self.secondSectionType = random.randint(0,1)

        self.doorSizeX = random.randint(0,2)
        self.doorSizeZ = random.randint(0,2)

        self.numPanels = random.randint(0,3)

        self.panelGrooveSizeX = random.randint(0,2)
        self.panelGrooveSizeY = random.randint(0,2)

        self.stileWidth = random.randint(0,2)

        self.midMullWidth = random.randint(0,2)

        self.panelSizeX = random.randint(0,2)

        self.grooveAngle = random.randint(0,2)



        self.verticalSpacingX = random.randint(0,2)
        self.verticalSpacingY = random.randint(0,2)
        self.verticalSpacingZ = random.randint(0,2)

        self.verticalPanelSizesX = random.randint(0,2)
        self.verticalPanelSizesY = random.randint(0,2)
        self.verticalPanelSizesZ = random.randint(0,2)
        self.verticalPanelSizesW = random.randint(0,2)

        self.numberVerticalPanels = random.randint(0,3)

        self.hasPanelBorders = random.randint(0,1)

        self.panelBorderSizeX = random.randint(0,2)
        self.panelBorderSizeY = random.randint(0,2)
        self.panelBorderSizeZ = random.randint(0,2)

        self.secondGoesAcross = random.randint(0,1)
 


        self.numWindowsX = random.randint(0,7)
        self.numWindowsY = random.randint(0,5)

        self.windowGapX = random.randint(0,2)
        self.windowGapY = random.randint(0,2)
        self.windowGapZ = random.randint(0,2)

        self.numPlanks = random.randint(0,9)



        ###################### Arch Genes #############################################

        self.archShape = random.randint(0,1)

        self.doorwaySizeX = random.randint(0,2)

        self.numBricks = random.randint(0,3)
        self.brickSize = random.randint(0,2)
        self.brickBevel = random.randint(0,2)

        self.archType = random.randint(0,4)

        self.scaleBitsX = random.randint(0,2)
        self.scaleBitsY = random.randint(0,2)

        self.firstSection = random.randint(0,2)
        self.lastSection = random.randint(0,2)

        self.numArchBits = random.randint(0,4)


        self.archBits11 = random.randint(0,2)
        self.archBits12 = random.randint(0,2)
        self.archBits13 = random.randint(0,2)
        self.archBits14 = random.randint(0,2)
        self.archBits15 = random.randint(0,2)
        self.archBits16 = random.randint(0,2)
        self.archBits17 = random.randint(0,2)
        self.archBits18 = random.randint(0,2)

        self.archBits21 = random.randint(0,2)
        self.archBits22 = random.randint(0,2)
        self.archBits23 = random.randint(0,2)
        self.archBits24 = random.randint(0,2)
        self.archBits25 = random.randint(0,2)
        self.archBits26 = random.randint(0,2)
        self.archBits27 = random.randint(0,2)
        self.archBits28 = random.randint(0,2)

        self.archBits31 = random.randint(0,2)
        self.archBits32 = random.randint(0,2)
        self.archBits33 = random.randint(0,2)
        self.archBits34 = random.randint(0,2)
        self.archBits35 = random.randint(0,2)
        self.archBits36 = random.randint(0,2)
        self.archBits37 = random.randint(0,2)
        self.archBits38 = random.randint(0,2)

        self.archBits41 = random.randint(0,2)
        self.archBits42 = random.randint(0,2)
        self.archBits43 = random.randint(0,2)
        self.archBits44 = random.randint(0,2)
        self.archBits45 = random.randint(0,2)
        self.archBits46 = random.randint(0,2)
        self.archBits47 = random.randint(0,2)
        self.archBits48 = random.randint(0,2)

        self.archBits51 = random.randint(0,2)
        self.archBits52 = random.randint(0,2)
        self.archBits53 = random.randint(0,2)
        self.archBits54 = random.randint(0,2)
        self.archBits55 = random.randint(0,2)
        self.archBits56 = random.randint(0,2)
        self.archBits57 = random.randint(0,2)
        self.archBits58 = random.randint(0,2)

        self.archBits61 = random.randint(0,2)
        self.archBits62 = random.randint(0,2)
        self.archBits63 = random.randint(0,2)
        self.archBits64 = random.randint(0,2)
        self.archBits65 = random.randint(0,2)
        self.archBits66 = random.randint(0,2)
        self.archBits67 = random.randint(0,2)
        self.archBits68 = random.randint(0,2)

        self.archBits71 = random.randint(0,2)
        self.archBits72 = random.randint(0,2)
        self.archBits73 = random.randint(0,2)
        self.archBits74 = random.randint(0,2)
        self.archBits75 = random.randint(0,2)
        self.archBits76 = random.randint(0,2)
        self.archBits77 = random.randint(0,2)
        self.archBits78 = random.randint(0,2)

        self.archBits81 = random.randint(0,2)
        self.archBits82 = random.randint(0,2)
        self.archBits83 = random.randint(0,2)
        self.archBits84 = random.randint(0,2)
        self.archBits85 = random.randint(0,2)
        self.archBits86 = random.randint(0,2)
        self.archBits87 = random.randint(0,2)
        self.archBits88 = random.randint(0,2)

        self.archBits91 = random.randint(0,2)
        self.archBits92 = random.randint(0,2)
        self.archBits93 = random.randint(0,2)
        self.archBits94 = random.randint(0,2)
        self.archBits95 = random.randint(0,2)
        self.archBits96 = random.randint(0,2)
        self.archBits97 = random.randint(0,2)
        self.archBits98 = random.randint(0,2)

        self.archBits101 = random.randint(0,2)
        self.archBits102 = random.randint(0,2)
        self.archBits103 = random.randint(0,2)
        self.archBits104 = random.randint(0,2)
        self.archBits105 = random.randint(0,2)
        self.archBits106 = random.randint(0,2)
        self.archBits107 = random.randint(0,2)
        self.archBits108 = random.randint(0,2)

        
        self.useBits = random.randint(0,5)

        self.hasSectionAboveDoor = random.randint(0,4)
        self.aboveDoorHeight = random.randint(0,2)

        self.separatorSize = random.randint(0,2)

        self.aboveVersion = random.randint(0,2)

        self.numWindows = random.randint(0,6)

        self.geneList = [self.twists, self.knobVersion, self.knobPositionX, self.knobPositionY, self.knobBaseSizeX, self.knobBaseSizeY, self.knobBaseSizeZ, self.knobStemSizeX, self.knobStemSizeY, self.knobRoundSizeX, self.knobRoundSizeY, self.knobStemOverlap, self.knobExtrusionSizeX, self.knobExtrusionSizeY, self.knobBevel1, self.knobBevel2, self.totalDoorHeight, self.color_M, self.firstSectionPercentage, self.firstSectionType, self.secondSectionType, self.doorSizeX, self.doorSizeZ, self.numPanels, self.panelGrooveSizeX, self.panelGrooveSizeY, self.stileWidth, self.midMullWidth, self.panelSizeX, self.grooveAngle, self.verticalSpacingX, self.verticalSpacingY, self.verticalSpacingZ, self.verticalPanelSizesX, self.verticalPanelSizesY, self.verticalPanelSizesZ, self.verticalPanelSizesW, self.numberVerticalPanels, self.hasPanelBorders, self.panelBorderSizeX, self.panelBorderSizeY, self.panelBorderSizeZ, self.secondGoesAcross, self.numWindowsX, self.numWindowsY, self.windowGapX, self.windowGapY, self.windowGapZ, self.numPlanks, self.archShape, self.doorwaySizeX, self.numBricks, self.brickSize, self.brickBevel, self.archType, self.scaleBitsX, self.scaleBitsY, self.firstSection, self.lastSection, self.numArchBits, [self.archBits11, self.archBits12, self.archBits13, self.archBits14, self.archBits15, self.archBits16, self.archBits17, self.archBits18], [self.archBits21, self.archBits22, self.archBits23, self.archBits24, self.archBits25, self.archBits26, self.archBits27, self.archBits28], [self.archBits31, self.archBits32, self.archBits33, self.archBits34, self.archBits35, self.archBits36, self.archBits37, self.archBits38], [self.archBits41, self.archBits42, self.archBits43, self.archBits44, self.archBits45, self.archBits46, self.archBits47, self.archBits48], [self.archBits51, self.archBits52, self.archBits53, self.archBits54, self.archBits55, self.archBits56, self.archBits57, self.archBits58], [self.archBits61, self.archBits62, self.archBits63, self.archBits64, self.archBits65, self.archBits66, self.archBits67, self.archBits68], [self.archBits71, self.archBits72, self.archBits73, self.archBits74, self.archBits75, self.archBits76, self.archBits77, self.archBits78], [self.archBits81, self.archBits82, self.archBits83, self.archBits84, self.archBits85, self.archBits86, self.archBits87, self.archBits88], [self.archBits91, self.archBits92, self.archBits93, self.archBits94, self.archBits95, self.archBits96, self.archBits97, self.archBits98], [self.archBits101, self.archBits102, self.archBits103, self.archBits104, self.archBits105, self.archBits106, self.archBits107, self.archBits108], self.useBits, self.hasSectionAboveDoor, self.aboveDoorHeight, self.separatorSize, self.aboveVersion, self.numWindows, self.firstSectionType2]
