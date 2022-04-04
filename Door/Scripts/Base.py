import sys
path = 'C:/Users/mulli/OneDrive/Documents/GitHub/GenerativeArt/Door/Scripts'
sys.path.append(path)

import GeneticUI
import Door
import Gene
reload(Door)
reload(Gene)
reload(GeneticUI)
GeneticUI.run()