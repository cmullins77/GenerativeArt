import hou
from PySide2 import QtCore, QtUiTools, QtWidgets

from Gene import *
from Door import *

import random

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
            transform.parm("tx").set(i*3)

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
        currentGeneration = []
        for i in range(3):
            doorObj = base.mutate(mutationVal)
            door = self.makeDoorAsset(self.geo, doorObj)
            transform = self.makeNode(self.geo, "xform", "transform", door)
            transform.parm("tx").set(i*3)

            self.merge.setInput(i, transform)
            currentGeneration.append(doorObj)
        self.currentGeneration = currentGeneration

    def displayFinal(self):
        x = 0
        y = 0
        for i in range(len(self.allSelected)):
            current = self.allSelected[i]

            door = self.makeDoorAsset(self.geo, current)
            transform = self.makeNode(self.geo, "xform", "transform", door)
            transform.parm("tx").set(x*4)
            transform.parm("ty").set(y*10)

            self.merge.setInput(i, transform)
            x += 1
            if x % 10 == 0:
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
        door.parm("BrickBevel").set(obj.brickBevel.value)
        door.parm("ArchType").set(int(obj.archType.value))
        door.parmTuple("ScaleBits").set((obj.scaleBitsX.value, obj.scaleBitsY.value))
        door.parm("FirstSection").set(obj.firstSection.value)
        door.parm("LastSection").set(obj.lastSection.value)
        door.parm("NumArchBits").set(int(obj.numArchBits.value))
        door.parmTuple("ArchBit1").set((obj.archBits11, obj.archBits12, obj.archBits13, obj.archBits14, obj.archBits15, obj.archBits16, obj.archBits17, obj.archBits18))
        door.parmTuple("ArchBit2").set((obj.archBits21, obj.archBits22, obj.archBits23, obj.archBits24, obj.archBits25, obj.archBits26, obj.archBits27, obj.archBits28))
        door.parmTuple("ArchBit3").set((obj.archBits31, obj.archBits32, obj.archBits33, obj.archBits34, obj.archBits35, obj.archBits36, obj.archBits37, obj.archBits38))
        door.parmTuple("ArchBit4").set((obj.archBits41, obj.archBits42, obj.archBits43, obj.archBits44, obj.archBits45, obj.archBits46, obj.archBits47, obj.archBits48))
        door.parmTuple("ArchBit5").set((obj.archBits51, obj.archBits52, obj.archBits53, obj.archBits54, obj.archBits55, obj.archBits56, obj.archBits57, obj.archBits58))
        door.parmTuple("ArchBit6").set((obj.archBits61, obj.archBits62, obj.archBits63, obj.archBits64, obj.archBits65, obj.archBits66, obj.archBits67, obj.archBits68))
        door.parmTuple("ArchBit7").set((obj.archBits71, obj.archBits72, obj.archBits73, obj.archBits74, obj.archBits75, obj.archBits76, obj.archBits77, obj.archBits78))
        door.parmTuple("ArchBit8").set((obj.archBits81, obj.archBits82, obj.archBits83, obj.archBits84, obj.archBits85, obj.archBits86, obj.archBits87, obj.archBits88))
        door.parmTuple("ArchBit9").set((obj.archBits91, obj.archBits92, obj.archBits93, obj.archBits94, obj.archBits95, obj.archBits96, obj.archBits97, obj.archBits98))
        door.parmTuple("ArchBit10").set((obj.archBits101, obj.archBits102, obj.archBits103, obj.archBits104, obj.archBits105, obj.archBits106, obj.archBits107, obj.archBits108))
        door.parm("UseBits").set(int(obj.useBits.value))
        door.parm("HasSectionAboveDoor").set(int(obj.hasSectionAboveDoor.value))
        door.parm("AboveDoorHeight").set(obj.aboveDoorHeight.value)
        door.parm("SeparatorSize").set(obj.separatorSize.value)
        door.parm("AboveVersion").set(int(obj.aboveVersion.value))
        door.parm("NumWindowsTop").set(int(obj.NumWindowsTop.value))

        return door

def run():
    win = GeneticUI()
    win.show()