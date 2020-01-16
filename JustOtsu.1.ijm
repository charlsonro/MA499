/* This routine will read a series of image files, threshold them according to Yen's method,
 *  record the threshold values, calculate the binary histogram values of the thresholded image,
 *  calcluate the vol% of thresholded phase, and save everything in an output .txt file.  
 *  
 *  A. DiGiovanni - October 3, 2018
 *  Ver2.2
*/
setBatchMode(true);

// f = File.open(""); // display file open dialog
nBins = 256;
dir = getDirectory("Choose the directory with images to be analyzed: ");
list = getFileList(dir);
dir2 = getDirectory("Choose the directory for the analyzed output: ");

for (i=0; i<list.length; i++)
{
//  if (endsWith(list[i], ".tif")) 
	if (endsWith(list[i], ".tiff"))
   {
        open(dir + list[i]);
        run("8-bit");
        run("Properties...", "channels=1 slices=1 frames=1 unit=pixels pixel_width=1 pixel_height=1 voxel_depth=1");
        run("Invert");        
    	title = getTitle();
    	dotIndex = indexOf(title, ".");
		basename = substring(title, 0, dotIndex);
		print(basename);


// Begin analytics
//		setAutoThreshold("Yen dark");
//		setAutoThreshold("Yen");
        setAutoThreshold("Otsu");
//		setAutoThreshold("MaxEntropy");
//		setAutoThreshold("Huang");
        getThreshold(lower,upper);
//        print(lower);
//        print(upper);
        setOption("BlackBackground", false);
        run("Convert to Mask");
// Brought over from "Grain Details 10_includeedges3.ijm"
// ****** MOVE THE thv ASSIGNMENT TO HERE AND HAVE IT EQUAL 'upper'. IT SHOULD SAVE APPROPRIATELY
//		getHistogram(values, counts, nBins);
//		print(counts[0]);
//		print(counts[255]);
//		volfi=counts[255]/(counts[0]+counts[255]);
//		volfi=counts[0]/(counts[0]+counts[255]);
//		print(volfi);
//		print("******");

//   		print(f, list[i] + "  \t" + lower + " \t" + upper + " \t" + counts[0] + " \t" + counts[255] + " \t" + d2s(volfi,6));       
//        close();

/*		thv=upper;
		if (thv<10)
		   thv="00"+thv;
		else if (thv>9 && thv<100)
		   thv="0"+thv;
		else if (i>99)
		   thv=thv; 
		basename2 = basename + "#T" + thv + ".tif";
		basename3 = basename + "#T" + thv + "_AOM.tif"; //AOM = Analyze Overlay Masks - change appropriately
		basename4 = basename + "#T" + thv + "_AOM.jpg";
		basename5 = basename + "#T" + thv + "_AOM_#gr.csv";
*/

//		saveAs("tiff", dir2+basename2);
		saveAs("tiff", dir2+basename);
//	    run("Analyze Particles...", "size=25-Infinity show=[Overlay Masks] display clear"); //If you change this, consider modifying the savefile extenstion above.
// Need to have a resolution-based justification for the cutoff # (i.e. - size=20) => using 5x pixels
//	    saveAs("Tiff", dir2+basename3);
//	    run("Flatten");
//	    saveAs("Jpeg", dir2+basename4);
//	    selectWindow("Results");
//	    saveAs("Results", dir2+basename5);
// End analytics from other file 
		close();
    }
}