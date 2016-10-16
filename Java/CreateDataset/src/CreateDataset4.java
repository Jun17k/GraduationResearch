import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.StringTokenizer;

public class CreateDataset4 {
	//鼻の頭（29），アゴの3点(53,54,61,69)の取得
	
	static final int MAX_Num_Dimension = 243;	//元のデータの次元数

	public static void main(String args[]) throws IOException{

		String directory ="C:/Users/Shibasaki/Desktop/StraightNeck/Data/";
		String inputfile[] = {
				directory + "landmark_shibasaki_2015_11_18_13_42_5.csv",
				directory +	"landmark_shibasaki_2015_11_18_13_45_1.csv"
		};

		String outputfile[] = {
				directory + "StraightNeck2_shibasaki_2015_11_18_13_42_5.csv",
				directory +	"StraightNeck2_shibasaki_2015_11_18_13_45_1.csv"
		};

		for(int i=0; i < inputfile.length; i++){
			BufferedReader br = new BufferedReader(new FileReader(inputfile[i]));
			BufferedWriter bw = new BufferedWriter(new FileWriter(outputfile[i],true));
			
			try{
				File file = new File(inputfile[i]);
				FileReader filereader = new FileReader(file);
			}catch(FileNotFoundException e1){
				System.out.println(e1);
			}
			
			int l = 0;	//行数の管理
			String line = "";		//ファイルから読み込んだ1行
			String str;				//書き出すための一行
			String time1 ="";
			
			String label[] = new String[MAX_Num_Dimension +1];
			Double data[] = new Double[MAX_Num_Dimension +1];
			
			int time[] = new int[2];
			
			time[0] = 0;

			//ファイル一行目
			str = "time1,time2,frame,29.x,29.y,29.z,53.x,53.y,53.z,54.x,54.y,54.z,61.x,61.y,61.z,69.x,69.y,69.z,";
			bw.write(str);
			bw.newLine();


			while((line = br.readLine()) != null){
				StringTokenizer st = new StringTokenizer(line, ",");	//1行をカンマで区切る

				int frame;
				l = l +1;
				str = "";
				int n =1;
				
				while(st.hasMoreTokens()){
				//for(int n = 1; n < MAX_Num_Dimension +1 ; n++){					
					
					if(l == 1){
						label[n] = st.nextToken();
					}
					else{
						if(n == 1){
							time1 = st.nextToken();	
						}else if(n==2){
							time[1] = Integer.valueOf(st.nextToken());
						}else{
							data[n] = Double.valueOf(st.nextToken());
						}
					}
					n += 1;
				}
				
				/*
				n=1		tame
				n=97	29.x
				n=169	53.x
				n=172	54.x
				n=193	61.x
				n=217	69.x
				*/
				if(l == 1){
					/*str = label[1] + "," + label[2] + "," + "frame" + ","
							+ label[97] + "," + label[98] + "," + label[99] + ","
							+ label[169] + "," + label[170] + "," + label[171] + ","
							+ label[172] + "," + label[173] + "," + label[174] + ","
							+ label[193] + "," + label[194] + "," + label[195] + ","
							+ label[217] + "," + label[218] + "," + label[219] 
							;*/
				}else{
					if(data[97] != 0 && data[169] != 0 && data[172] != 0 && data[193] != 0 && data[217] != 0){
						frame = time[1]-time[0];
						time[0] = time[1];
						str = time1 + "," + time[1] + "," + frame + ","
								+ data[97] + "," + data[98] + "," + data[99] + ","
								+ 1000*(data[169] - data[97]) + "," + 1000*(data[170] - data[98]) + "," + -1000*(data[171] - data[99]) + ","
								+ 1000*(data[172] - data[97]) + "," + 1000*(data[173] - data[98]) + "," + -1000*(data[174] - data[99]) + ","
								+ 1000*(data[193] - data[97]) + "," + 1000*(data[194] - data[98]) + "," + -1000*(data[195] - data[99]) + ","
								+ 1000*(data[217] - data[97]) + "," + 1000*(data[218] - data[98]) + "," + -1000*(data[219] - data[99]);
					}
				}
				
				if(n == MAX_Num_Dimension +1 && str != ""){
					bw.write(str);
					bw.newLine();
					System.out.println(l);
					l += 1;
				}
			}
			bw.close();
			System.out.println("fileend");
		}
	}
}
