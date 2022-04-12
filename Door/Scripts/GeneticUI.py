import hou
from PySide2 import QtCore, QtUiTools, QtWidgets

from Gene import *
from Door import *

import random

IS_TESTING_MODE = True
NUM_TESTING_TIMES = 60
TESTING_MUTATION_VALUE = 50
DOORS_SPREAD = True

SAVE_MODELS = False

class GeneticUI(QtWidgets.QWidget):
    def __init__(self):
        super(GeneticUI,self).__init__()
        ui_file = 'C:/temp/genetic.ui'
        self.ui = QtUiTools.QUiLoader().load(ui_file, parentWidget=self)
        self.setParent(hou.ui.mainQtWindow(), QtCore.Qt.Window)
        
        self.ui.generate_new.clicked.connect(self.createNewButtonClicked)
        self.ui.option_1.clicked.connect(self.option1ButtonClicked)
        self.ui.option_2.clicked.connect(self.option2ButtonClicked)
        self.ui.option_3.clicked.connect(self.option3ButtonClicked)
        self.ui.display_final.clicked.connect(self.displayFinal)

        if hou.node('/obj/doors'):
            hou.node('/obj/doors').destroy()

        self.obj = hou.node('/obj')
        self.geo = self.obj.createNode('geo', 'doors')
        self.merge = self.makeNode(self.geo, "merge", "merge")
        self.merge.setDisplayFlag(True)
        self.merge.setRenderFlag(True)

        self.createRandomOptions()
        self.allSelected = []

        if IS_TESTING_MODE:
            for i in range(NUM_TESTING_TIMES):
                print(i)
                self.option1ButtonClicked()
            self.displayFinal()
        
    def createNewButtonClicked(self):
        self.createRandomOptions()

    def option1ButtonClicked(self):
        self.selectOption(0)

    def option2ButtonClicked(self):
        self.selectOption(1)

    def option3ButtonClicked(self):
        self.selectOption(2)

    def selectOption(self, option):
        selected = self.currentGeneration[option]
        self.allSelected.append(selected)
        self.generateNew(selected)
    
    def createGeoNode(self, geometryName):
        # Get scene root node
        sceneRoot = hou.node('/obj/')
        # Create empty geometry node in scene root
        geometry = sceneRoot.createNode('geo', run_init_scripts=False)
        # Set geometry node name
        geometry.setName(geometryName)
        # Display creation message
        hou.ui.displayMessage('{} node created!'.format(geometryName))

    def createRandomOptions(self):
        self.allSelected = []
        currentGeneration = []
        for i in range(3):
            doorGeneList = DoorGeneGenerator()
            doorObj = Door(doorGeneList.geneList)
            door = self.makeDoorAsset(self.geo, doorObj)
            transform = self.makeNode(self.geo, "xform", "transform", door)
            transform.parm("tx").set(i*4)

            self.merge.setInput(i, transform)
            currentGeneration.append(doorObj)
        self.currentGeneration = currentGeneration

    def generateNew(self, base):
        hou.node('/obj/doors/Door').destroy()
        hou.node('/obj/doors/Door1').destroy()
        hou.node('/obj/doors/Door2').destroy()
        hou.node('/obj/doors/transform').destroy()
        hou.node('/obj/doors/transform1').destroy()
        hou.node('/obj/doors/transform2').destroy()

        mutationVal = self.ui.mutation_percent.value()

        if IS_TESTING_MODE:
            mutationVal = TESTING_MUTATION_VALUE

        currentGeneration = []
        for i in range(3):
            doorObj = base.mutate(mutationVal)
            door = self.makeDoorAsset(self.geo, doorObj)
            transform = self.makeNode(self.geo, "xform", "transform", door)
            transform.parm("tx").set(i*4)

            self.merge.setInput(i, transform)
            currentGeneration.append(doorObj)
        self.currentGeneration = currentGeneration

    def displayFinal(self):
        x = 0
        y = 0

        numToUse = 75
        colNum = 15

        if DOORS_SPREAD:
            numToUse = numToUse - colNum

        if len(self.allSelected) < numToUse:
            numToUse = len(self.allSelected)

        interval = len(self.allSelected)/float(numToUse)
        for i in range(numToUse):
            curri = int(interval *  i)
            if i == numToUse - 1:
                curri = len(self.allSelected) - 1
            current = self.allSelected[curri]

            door = self.makeDoorAsset(self.geo, current)
            transform = self.makeNode(self.geo, "xform", "transform", door)
            xPosition = x*2.5
            yPosition = y*4
            zMultiplier = 0.75
            if DOORS_SPREAD:
                xPosition = x*4.5
                yPosition = y*7.5
                zMultiplier = 0
            transform.parm("tx").set(xPosition)
            transform.parm("ty").set(yPosition)
            zBasePos = (y % 2 != 0) * 0.5
            zAddedPos = (x % 2 == 0) * zMultiplier
            transform.parm("tz").set(zBasePos + zAddedPos)

            if SAVE_MODELS:
                cache = self.makeNode(self.geo, "filecache", "filecache", transform)
                cache.parm("file").set("C:/Users/mulli/Downloads/Doors/Door" + str(i) + ".obj")
                cache.parm("trange").set("off")
                cache.parm("execute").pressButton()

                
            
            self.merge.setInput(i, transform)

            x += 1
            if x % colNum == 0:
                y += 1
                x = 0


    def makeNode(self, where, type, name, input = None):
        newnode = where.createNode(type, name)
        if isinstance(input, list):
            for i in range(len(input)):
                newnode.setInput(i, input[i])
        elif input != None:
            newnode.setFirstInput(input)
        newnode.moveToGoodPosition()
        return newnode

    def makeDoorAsset(self, where, obj):
        door = self.makeNode(where, "Door", "Door")

        door.parm("Twists").set(int(obj.twists.value))
        door.parm("DoorKnobVersion").set(int(obj.twists.value))
        door.parmTuple("KnobPosition").set((obj.knobPositionX.value, obj.knobPositionY.value))
        door.parmTuple("KnobBaseSize").set((obj.knobBaseSizeX.value, obj.knobBaseSizeY.value, obj.knobBaseSizeZ.value))
        door.parmTuple("KnobStemSize").set((obj.knobStemSizeX.value, obj.knobStemSizeY.value))
        door.parmTuple("RoundKnobSize").set((obj.knobRoundSizeX.value, obj.knobRoundSizeY.value))
        door.parm("KnobStemOverlap").set(obj.knobStemOverlap.value)
        door.parmTuple("KnobExtrusionSize").set((obj.knobExtrusionSizeX.value, obj.knobExtrusionSizeY.value))
        door.parmTuple("KnobBevel").set((obj.knobBevel1.value, obj.knobBevel2.value))

        door.parm("TotalDoorHeight").set(obj.totalDoorHeight.value)
        door.parm("Color_M").set(obj.color_M.value)
        door.parm("FirstSectionPercentage").set(obj.firstSectionPercentage.value)
        door.parm("FirstSectionType").set(int(obj.firstSectionType.value))
        door.parm("SecondSectionType").set(int(obj.secondSectionType.value))
        door.parmTuple("DoorSize").set((obj.doorSizeX.value, 0, obj.doorSizeZ.value))
        door.parm("NumPanels").set(int(obj.numPanels.value))
        door.parmTuple("PanelGrooveSize").set((obj.panelGrooveSizeX.value, obj.panelGrooveSizeY.value))
        door.parm("StileWidth").set(obj.stileWidth.value)
        door.parm("MidMullionWidth").set(obj.midMullWidth.value)
        door.parmTuple("PanelSize").set((obj.panelSizeX.value, 0.1))
        door.parm("GrooveAngle").set(obj.grooveAngle.value)
        door.parmTuple("VerticalSpacing").set((obj.verticalSpacingX.value, obj.verticalSpacingY.value, obj.verticalSpacingZ.value))
        door.parmTuple("VerticalPanelSizes").set((obj.verticalPanelSizesX.value, obj.verticalPanelSizesY.value, obj.verticalPanelSizesZ.value, obj.verticalPanelSizesW.value))
        door.parm("NumVerticalPanels").set(int(obj.numberVerticalPanels.value))
        door.parm("haspanelborders").set(int(obj.hasPanelBorders.value))
        door.parmTuple("borderSize").set((obj.panelBorderSizeX.value, obj.panelBorderSizeY.value, obj.panelBorderSizeZ.value))
        door.parm("SecondGoesAcross").set(int(obj.secondGoesAcross.value))
        door.parmTuple("numwindows").set((int(obj.numWindowsX.value), int(obj.numWindowsY.value)))
        door.parmTuple("WindowGap").set((obj.windowGapX.value, obj.windowGapY.value, obj.windowGapZ.value))
        door.parm("NumberPlanks").set(int(obj.numPlanks.value))


        door.parm("ArchShape").set(int(obj.archShape.value))
        door.parm("DoorwaySizex").set(obj.doorwaySizeX.value)
        door.parm("NumBricks").set(int(obj.numBricks.value))
        door.parm("BrickSize").set(obj.brickSize.value)
        door.parm("brickbevel").set(obj.brickBevel.value)
        door.parm("ArchType").set(int(obj.archType.value))
        door.parmTuple("ScaleBits").set((obj.scaleBitsX.value, obj.scaleBitsY.value))
        door.parm("FirstSection").set(obj.firstSection.value)
        door.parm("LastSection").set(obj.lastSection.value)
        door.parm("NumArchBits").set(int(obj.numArchBits.value))
        door.parmTuple("ArchBit1").set((obj.archBits11.value, obj.archBits12.value, obj.archBits13.value, obj.archBits14.value, obj.archBits15.value, obj.archBits16.value, obj.archBits17.value, obj.archBits18.value))
        door.parmTuple("ArchBit2").set((obj.archBits21.value, obj.archBits22.value, obj.archBits23.value, obj.archBits24.value, obj.archBits25.value, obj.archBits26.value, obj.archBits27.value, obj.archBits28.value))
        door.parmTuple("ArchBit3").set((obj.archBits31.value, obj.archBits32.value, obj.archBits33.value, obj.archBits34.value, obj.archBits35.value, obj.archBits36.value, obj.archBits37.value, obj.archBits38.value))
        door.parmTuple("ArchBit4").set((obj.archBits41.value, obj.archBits42.value, obj.archBits43.value, obj.archBits44.value, obj.archBits45.value, obj.archBits46.value, obj.archBits47.value, obj.archBits48.value))
        door.parmTuple("ArchBit5").set((obj.archBits51.value, obj.archBits52.value, obj.archBits53.value, obj.archBits54.value, obj.archBits55.value, obj.archBits56.value, obj.archBits57.value, obj.archBits58.value))
        door.parmTuple("ArchBit6").set((obj.archBits61.value, obj.archBits62.value, obj.archBits63.value, obj.archBits64.value, obj.archBits65.value, obj.archBits66.value, obj.archBits67.value, obj.archBits68.value))
        door.parmTuple("ArchBit7").set((obj.archBits71.value, obj.archBits72.value, obj.archBits73.value, obj.archBits74.value, obj.archBits75.value, obj.archBits76.value, obj.archBits77.value, obj.archBits78.value))
        door.parmTuple("ArchBit8").set((obj.archBits81.value, obj.archBits82.value, obj.archBits83.value, obj.archBits84.value, obj.archBits85.value, obj.archBits86.value, obj.archBits87.value, obj.archBits88.value))
        door.parmTuple("ArchBit9").set((obj.archBits91.value, obj.archBits92.value, obj.archBits93.value, obj.archBits94.value, obj.archBits95.value, obj.archBits96.value, obj.archBits97.value, obj.archBits98.value))
        door.parmTuple("ArchBit10").set((obj.archBits101.value, obj.archBits102.value, obj.archBits103.value, obj.archBits104.value, obj.archBits105.value, obj.archBits106.value, obj.archBits107.value, obj.archBits108.value))
        door.parm("UseBits").set(int(obj.useBits.value) > 0)
        num = int(obj.hasSectionAboveDoor.value) > 0
        door.parm("HasSectionAboveDoor").set(num)
        door.parm("AboveDoorHeight").set(obj.aboveDoorHeight.value)
        door.parm("SeparatorSize").set(obj.separatorSize.value)
        door.parm("AboveVersion").set(int(obj.aboveVersion.value))
        door.parm("NumWindowsTop").set(int(obj.numWindows.value))

        return door

def run():
    win = GeneticUI()
    win.show()