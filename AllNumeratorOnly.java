import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Scanner;

// computes the weights for the quartets
public class AllNumeratorOnly{
	public static void main(String [] args) throws IOException{
		int n=0;
		int numQ=0;
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
						
				//**********integral main program************//
				int k = numQ;
		
				// the base of the weight formula
				double numerator = 	TrapezoidalRule.integrate((1.0/3.0),1,500,k, totaltaxa);
				double partialdenominator = TrapezoidalRule.integrate(0,(1.0/3.0),100,k,totaltaxa);
				double denominator = partialdenominator + numerator;
				double base = numerator/denominator;

				fileWriter.println(quartets + ":" + base);	
			}
			fileWriter.close();
			
		}catch (FileNotFoundException e) {
			System.out.println("Sorry there's a mistake.");
		}
	}
	
	//**** inner class for the integration ****//
	static class TrapezoidalRule{
		/**
		 * standard normal distribution density function.
		 * replace with any sufficiently smooth function
		 * @param x
		 * @return
		 */
		static double f(double p, int k, int totaltaxa){
			// computes p to the exponent of k
			double exponent1 = 1;
			for (int i = 0; i < k; i++){
				exponent1 = exponent1 * p;
			}
			// computes 1-p to the exponent of 1000-k
			double exponent2 = 1;
			for (int j = 0; j < (totaltaxa-k); j++){
				exponent2 = exponent2 * (1-p);
			}
			
			return (exponent1)*(exponent2);
		}
		
		/**
		 * integrate f from a to b using the trapezoidal rule.
		 * increase n for more precision
		 * @param a
		 * @param b
		 * @param N
		 * @return
		 */
		static double integrate(double a, double b, int N, int k, int tot){
			double h = (b-a) / N;
			double sum = 0.5 * (f(a, k, tot) + f(b, k, tot));
		//	System.out.println(f(a,k));
		//	System.out.println(f(b,k));
			for (int i = 1; i < N; i++){
				double x = a + h * i;
				sum = sum + f(x, k, tot);
			//	System.out.println(f(x,k));
			}
			return sum * h;
		}
		
		
	}
}
