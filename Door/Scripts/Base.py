import sys
import importlib
#path = 'C:/Users/mulli/OneDrive/Documents/GitHub/GenerativeArt/Door/Scripts'
path = 'C:/Users/Cassie/Documents/GitHub/GenerativeArt/Door/Scripts'
sys.path.append(path)

import GeneticUI
import Door
import Gene
importlib.reload(Door)
importlib.reload(Gene)
importlib.reload(GeneticUI)
GeneticUI.run()