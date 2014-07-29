package test;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.FilenameFilter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class Pinging {

	
	public static void main(String[] args){
	
		
		String path, filename, fullname, path1;
		
		path="/home/jorlu/Escritorio/ping/sum/";
		path1="/home/jorlu/Escritorio/ping/";
  	  	///get the files in a folder
  	  	final String ext="sum"; 
  	  	ArrayList<Integer> arrMax = new ArrayList<Integer>();
  	  	
  	  	FilenameFilter filter = new FilenameFilter() {
  	  		public boolean accept(File dir, String name) {
				String lowercaseName = name.toLowerCase();
				if (lowercaseName.endsWith(ext)) {
					return true;
				} else {
					return false;
				}
			}
		};
  	  	
  	  	File folder = new File(path);

  	    String[] listOfFiles = folder.list(filter);
  	    ArrayList<String> arr = new ArrayList<String>();
  	    
	    for (int i = 0; i < listOfFiles.length; i++) {

	    	filename=listOfFiles[i].toString();
			fullname=path+filename;

			File f = new File(fullname);
	  	  	
			if(f.exists() && !f.isDirectory()) {  
   		  
				try {				//cargamos el fichero en el vector
	   			  	arr=input(fullname);
	   		  	} catch (Exception e) {
	   				e.printStackTrace();
	   		  	}  
	   		
	   			//print the file
//		    	for(int i1 = 0; i1 < arr.size(); i1++) {
//				  System.out.println(arr.get(i1));
//		    	}
				
				/*********
				 * control del contenido del fichero
				 * 
				 * 
				*/

		    	String AP1, AP2;
		    	AP1=arr.get(0);
		    	AP2=arr.get(1);
		    
		    	//Controla el cambio segun la frase
		    	Pattern p1 = Pattern.compile( "Se ha producido un cambio de AP" );
		    	Matcher m1 = p1.matcher( arr.get(4) );

		    	boolean found = false;
		    	while(m1.find()) {
		    		found = true;
		    	}
		    	
		    	//Controla el cambio segun la mac del AP
		    	Pattern p2 = Pattern.compile(AP1);
		    	Matcher m2 = p2.matcher(AP2);
		    	
		    	boolean foundChange = true;
		    	while(m2.find()) {
		    		foundChange = false;
		    	}
		    	
		    	//Verifica que la migracion fue de AP1 a AP2
		    	String macAP1;//, macAP2;
		    	macAP1="64:70:02:B5:DA:FF";
		    	//macAP2="00:0C:42:66:51:93";
		    	
	    		Tokenizer tokenizer = new Tokenizer(arr.get(3));

	    	    int pings_sent = tokenizer.nextInt();
	    	    int pings_received = tokenizer.nextInt();
	    	    int restaPerdidos = pings_sent-pings_received;

	    		boolean migration1 = false;
		    	Pattern p3 = Pattern.compile(macAP1);
		    	Matcher m3 = p3.matcher(AP1);
		    	
		    	while(m3.find()) {
		    		migration1 = true;
		    	}
		    	
		    	if (found && migration1){
		    		System.out.println(filename + " "  + found + " " + foundChange + " " + migration1 + " " + arr.get(3) + " " + restaPerdidos);
		    		arrMax.add(restaPerdidos);
		    		
		    	}
		    		    	
		    	//AP1 -line1
		    	//AP2 -line2
		    	//SI o NO -line5
		    	//SENT RECEIVE LOST -line4
   		  
			 } else {
				 System.out.println("Don't exits");
			 }
			
			
	    }
	    String fileresult=path1+"ping.max";
		saveVectorInFile(arrMax, fileresult);
	}
	
	public static class Tokenizer {

	    private String content;

	    public Tokenizer(String fileContent) {
	        this.content = fileContent.trim();
	    }

	    public char nextChar() {
	        return next().charAt(0);
	    }

	    public int nextInt() {
	        return Integer.parseInt(next());
	    }

	    private String next() {
	        int indexOf = content.indexOf(" ");
	        if (indexOf == -1) {
	            indexOf = content.length();
	        }
	        String substring = content.substring(0, indexOf);
	        content = content.substring(substring.length()).trim();
	        return substring;
	    }
	}
	
	
	/*******************************************************
		 * 						INPUT
		 * 
		 * *****************************************************
		 */
		
		public static ArrayList<String>input(String path){

			BufferedReader br = null;
			ArrayList<String> todo = new ArrayList<String>();

			try {
				 String sCurrentLine;
				 br = new BufferedReader(new FileReader(path));
				 
				 try {
					while((sCurrentLine = br.readLine()) != null){
						 	
//						try{
						    //int val;
						    String val;
						    //val=Integer.valueOf(sCurrentLine);
						    val=String.valueOf(sCurrentLine);
						    //System.out.println(val);
						    todo.add(val);
//					    } catch (NumberFormatException e) {
//					        //not an integer
//					    	System.out.println("not an integer");
//					    }
					 }
				 }catch (IOException e) {
					e.printStackTrace();
				 }finally {
					 try {
						 if (br != null)
			            	br.close();
					 } catch (IOException ex) {
						 ex.printStackTrace();
					 }
				 }
			} catch (IOException e) {
				e.printStackTrace();
			}
			return(todo);
		}

	
		
		/*******************************************************
   		 * 						PRINT  &  SAVE  THE   RESULTS
   		 * 
   		 * *****************************************************
   		 */

   		public static void saveVectorInFile(ArrayList<Integer> vector, String fileName){
   			
//   	        for(int i2 = 0; i2 < maximos.size(); i2++) {
//   				System.out.println(maximos.get(i2));
//   			}
   			
   	        //writing to file 		
   	        String fileOut=fileName;
   	  		BufferedWriter bw3 = null;
   			
   	  		File f = new File(fileOut);
   	    	  
   	  		if(f.exists() && !f.isDirectory()) { /* do something */ 
   	    		  try {
   	    			  //eliminar el fichero que existia previamente
   	    			  f.delete(); 
   	    		  } catch (Exception e) {
   	    				e.printStackTrace();
   	    		  }
   	  		}
   	    	  
   	  		try {
   				bw3 = new BufferedWriter(new FileWriter(fileOut, true));
   			} catch (IOException e) {
   				e.printStackTrace();
   			}
   			for (int a = 0; a < vector.size(); a++) {
   	   			try {
   	   				//bw3.write(a + " " + maximos.get(a) + "\n");
   	   				//sin el identificador
   	   				bw3.write(vector.get(a) + "\n");
   	 			} catch (IOException e) {
   					e.printStackTrace();
   				}
   	  		}
   			try {
   				bw3.close();
   			} catch (IOException e) {
   				e.printStackTrace();
   			}  

   		}
	
}
