import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Scanner;

// computes the weights for the quartets
public class AllWeightKOverN{
	public static void main(String [] args) throws IOException{
		int n=0;
		int numQ=0;
		double weight = 0.0;
		String numberOnly ="";
		String quartets="";
		String [] leaves = new String [4];
		int totaltaxa;
		File inputFile = new File(args[0]);	// open the file (ETreeQ or TTreeQ)
		FileWriter outputFile = new FileWriter(args[1]); // file we're writing to
		Scanner fileReader;
		PrintWriter fileWriter;

		try {
			fileReader=new Scanner (inputFile);
			fileWriter = new PrintWriter (outputFile);
			
			// reads through every line in the file
			while(fileReader.hasNextLine()){
				String numsTrees=fileReader.nextLine();
				
				// computes the weight
				String[] sections = numsTrees.split(":");
				quartets = sections[0];
				numQ = Integer.parseInt(sections[1]);
				totaltaxa = Integer.parseInt(sections[2]);
				weight = (double)numQ / totaltaxa;
				fileWriter.println(quartets + ":" + weight);	
			}
			fileWriter.close();
			
		}catch (FileNotFoundException e) {
			System.out.println("Sorry there's a mistake.");
		}
	}
	
}
