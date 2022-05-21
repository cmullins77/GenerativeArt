PrintWriter output;
PrintWriter colorOutput;
void setup() {
    output = createWriter("UpdatedRules.txt"); 
    colorOutput = createWriter("Colors.txt");
    readRuleFile();
}

void readRuleFile() {
   int colorCount = 0;
   File folder = new File("C:/Users/mulli/OneDrive/Documents/GitHub/GenerativeArt/UpdateRuleFile");
   for (final File fileEntry : folder.listFiles()) {
        if (fileEntry.isDirectory()) {
           ArrayList<String> options = new ArrayList<String>();
           for (File subFile: fileEntry.listFiles()) {
             String name = subFile.getName();
             String[] imgSplitList = name.split("\\.");
             if (imgSplitList.length == 2 && imgSplitList[1].equals("png")) {
               options.add(imgSplitList[0]);
               println(imgSplitList[0]);
             }
           }
           String[] lines = loadStrings(fileEntry.getPath() + "/Rules.txt");
           int lineNum = 0;
           for (String line : lines) {
             if (lineNum == 0) {
               colorOutput.println(line);
             } else{
               String[] separatedLine = line.split(":");
               String ruleNum = separatedLine[0];
               if (options.contains(ruleNum)) {
                 String outputString = colorCount + ":" + separatedLine[1];
                 output.println(outputString);
               }
             }
             lineNum++;
           }
           colorCount++;
        }
        
        
   }
   output.flush(); // Writes the remaining data to the file
    output.close(); // Finishes the file
    colorOutput.flush(); // Writes the remaining data to the file
    colorOutput.close();
    
    println(loadStrings("UpdatedRules.txt").length);
    exit(); 
   //String[] lines = loadStrings("Rules.txt");
   
   //int ruleVersion = 0;
   //for (String line : lines) {
   //  String[] separatedLine = line.split(":");
   //  String[] ruleStrings = separatedLine[1].split(",");
   //  int ruleNum = 0;
   //  for (String rule : ruleStrings) {
   //     ruleOptions[ruleVersion][ruleNum] = Integer.parseInt(rule);
   //     ruleNum++;
   //  }
   //  ruleVersion++;
   //}
   //ruleSet = ruleOptions[chosenRuleSet];
}

void listFilesForFolder(final File folder) {
    for (final File fileEntry : folder.listFiles()) {
        if (fileEntry.isDirectory()) {
            listFilesForFolder(fileEntry);
        } else {
            System.out.println(fileEntry.getName());
        }
    }
}
