import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.StringTokenizer;

public class CreateDataset {
	//svm用データセット
	
	static final int MAX_Num_Dimension = 241;	//元のデータの次元数

	public static void main(String args[]) throws IOException{
		
		String directory ="C:/Users/Shibasaki/Desktop/DataSet/YawPitchRoll/";
		String inputfile = directory + "landmark_shibasaki_2015_11_6_11_53_37.csv";
		String outputfile = directory + "dataset_landmark_shibasaki_2015_11_6_11_53_37.txt";

		BufferedReader br = new BufferedReader(new FileReader(inputfile));
		BufferedWriter bw = new BufferedWriter(new FileWriter(outputfile,true));

		String line = "";		//ファイルから読み込んだ1行
		String label = args[0];	//ラベル 疲れているとき１ 元気な時0
		String str;				//書き出すための一行

		int n;		//次元数の管理
		int l = 0;	//行数の管理

		try{
			File file = new File(inputfile);
			FileReader filereader = new FileReader(file);
		}catch(FileNotFoundException e1){
			System.out.println(e1);
		}


		while((line = br.readLine()) != null){
			StringTokenizer st = new StringTokenizer(line, ",");	//1行をカンマで区切る
			String data;	//ファイルから読み込んだデータ
			BigDecimal bd;
			double doubledata;

			n= 1;
			l = l +1;
			str = label;

			while(st.hasMoreTokens()){
				data = st.nextToken();
				
				//dataをdouble型に変換
				doubledata = Double.valueOf(data);
				
				if(doubledata == 0){
					break;
				}
				
				//nが8以上かつdoubledataの値が絶対値1以上の時，
				if(n>=8 && Math.abs(doubledata)>1){
					//xは-1/1000倍，yzは1/1000倍
					if(n%3 == 2){
						doubledata = doubledata * -1/1000;
					}else{
						doubledata = doubledata * 1/1000;
					}
				}
				
				bd = new BigDecimal(doubledata);
				bd = bd.setScale(4,BigDecimal.ROUND_DOWN);
				
				str = str + " " + n + ":" + bd ;
				n += 1;
			}

			if(n == MAX_Num_Dimension +1){
				bw.write(str);
				bw.newLine();
				System.out.println(l);
			}
		}
		bw.close();
	}

}
