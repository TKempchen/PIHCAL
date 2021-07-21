//define variables for the dialog box 

title = "PIHCAL viability assay";
fontSize = 60;
Well = "";
Input  = "Must end with /"
Output = "Filepath of output"

//create our user interface/info gathering dialog box

Dialog.create("PIHCAL viability assay"); //Creates dialog box
Dialog.addMessage("Please Provide the Following Information"); //Adds message text
Dialog.addString("Title:", title, 15); //Input for title, which later becomes file name
Dialog.addString("Well:", Well, 15);
Dialog.addString("Input:", Input, 15);
Dialog.addString("Output:", Output, 15);
Dialog.show(); //This opens the dialog box we created

//Below gathers user input from above dialog box and reassigns the relevant variables such that they now carry those values

title = Dialog.getString();
Well = Dialog.getString();
Input = Dialog.getString();
Output = Dialog.getString();

//show reminder
Dialog.create("Welcome! If the macro is not running make sure that your IMPUT-PATH ends with > / <"); 
Dialog.show();

open(Input + "Hoechst-" + Well + ".tif");

selectWindow("Hoechst-" + Well + ".tif");
//run("Brightness/Contrast...");
run("Enhance Contrast", "saturated=0.35");
run("Subtract Background...", "rolling=300");
run("Size...", "width=2000 height=1979 depth=1 constrain average interpolation=Bilinear");
run("8-bit");
run("Auto Threshold", "method=Otsu white");
setOption("BlackBackground", true);
run("Convert to Mask");
run("Create Selection");
run("Measure");
roiManager("Add");
close();
open(Input + "Calcein-" + Well + ".tif");
selectWindow("Calcein-"+ Well + ".tif");
//run("Brightness/Contrast...");
run("Enhance Contrast", "saturated=0.35");
run("Subtract Background...", "rolling=300");
run("Size...", "width=2000 height=1978 depth=1 constrain average interpolation=Bilinear");
run("Duplicate...", "title=Calcein-ForMask.tif");
run("8-bit");
roiManager("Select", 0);
setBackgroundColor(0, 0, 0);
run("Clear Outside");
run("Select None");
run("Auto Threshold", "method=Otsu white");
run("Convert to Mask");
run("Create Selection");
roiManager("Add");
selectWindow("Calcein-"+ Well + ".tif");
run("8-bit");
roiManager("Select", 1);
run("Measure");
open(Input + "PI-" + Well + ".tif");
selectWindow("PI-" + Well + ".tif");
//run("Brightness/Contrast...");
run("Enhance Contrast", "saturated=0.35");
run("Subtract Background...", "rolling=300");
run("Size...", "width=2000 height=1978 depth=1 constrain average interpolation=Bilinear");
run("Duplicate...", "title=PI-ForMask.tif");
run("8-bit");
roiManager("Select", 0);
setBackgroundColor(0, 0, 0);
run("Clear Outside");
run("Select None");
run("Auto Threshold", "method=Otsu white");
run("Convert to Mask");
run("Create Selection");
roiManager("Add");
selectWindow("PI-" + Well + ".tif");
run("8-bit");
roiManager("Select", 2);
run("Measure");
close();
close();
close();
selectWindow("Calcein-ForMask.tif");
close();

Table.rename("Results", "Results-PIHCAL-"+Well);
saveAs("Results", Output+"/Results-PIHCAL-A1.csv");
