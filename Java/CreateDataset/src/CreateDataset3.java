import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.StringTokenizer;

public class CreateDataset3 {
	//鼻の頭（29）の移動量の計測

	static final int MAX_Num_Dimension = 4;	//元のデータの次元数

	public static void main(String args[]) throws IOException{

		String directory ="C:/Users/Shibasaki/Desktop/DataSet/NoseTop/";
		String inputfile[] = {
				directory + "landmark_shibasaki_2015_10_28_11_35_54.csv",
				directory + "landmark_shibasaki_2015_10_28_20_44_3.csv",
				directory + "landmark_shibasaki_2015_11_4_10_42_52.csv",
				directory + "landmark_shibasaki_2015_11_6_11_47_28.csv",
				directory + "landmark_shibasaki_2015_11_6_17_33_12.csv",
				directory + "landmark_shibasaki_2015_11_9_18_57_49.csv",
				directory + "landmark_shibasaki_2015_11_10_11_7_17.csv"
		};

		String outputfile[] = {
				directory + "NoseTop_shibasaki_2015_10_28_11_35_54.csv",
				directory + "NoseTop_shibasaki_2015_10_28_20_44_3.csv",
				directory + "NoseTop_shibasaki_2015_11_4_10_42_52.csv",
				directory + "NoseTop_shibasaki_2015_11_6_11_47_28.csv",
				directory + "NoseTop_shibasaki_2015_11_6_17_33_12.csv",
				directory + "NoseTop_shibasaki_2015_11_9_18_57_49.csv",
				directory + "NoseTop_shibasaki_2015_11_10_11_7_17.csv"
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
			String data;
			String time1 ="";
			
			int time[] = new int[2];
			double x29[] = new double[2];
			double y29[] = new double[2];
			double z29[] = new double[2];

			time[0] = 0;
			x29[0] = 0;
			y29[0] = 0;
			z29[0] = 0;

			//ファイル一行目
			str = "time1,time2,29.x,29.y,29.z,frame,X_move,Y_move,Z_move";
			bw.write(str);
			bw.newLine();


			while((line = br.readLine()) != null){
				StringTokenizer st = new StringTokenizer(line, ",");	//1行をカンマで区切る

				int frame;
				BigDecimal xmove;
				BigDecimal ymove;
				BigDecimal zmove;

				int n=1;	//次元数の管理
				l = l +1;
				str = "";

				//for(int n = 1; n < MAX_Num_Dimension + 1; n++){
				while(st.hasMoreTokens()){					
					if(l == 1){
						System.out.println(l);
						l += 1;
						break;
					}else if(n==1){
						time1 = st.nextToken();
					}else if(n==2){
						time[1] = Integer.valueOf(st.nextToken());
					}else if(n==97){
						x29[1] = Double.valueOf(st.nextToken());
					}else if(n==98){
						y29[1] = Double.valueOf(st.nextToken());
					}else if(n==99){
						z29[1] = Double.valueOf(st.nextToken());
					}else{
						data = st.nextToken();
					}
					n += 1;
				}

				if(x29[1] != 0 && y29[1] != 0 && z29[1] != 0){
					
					if(Math.abs(x29[1]) > 1){
						x29[1] = x29[1] * -1/1000;
					}
					
					if(Math.abs(y29[1]) > 1){
						y29[1] = y29[1] * 1/1000;
					}
					
					if(Math.abs(z29[1]) > 1){
						z29[1] = z29[1] * 1/1000;
					}
					
					frame = time[1]-time[0];

					xmove = new BigDecimal(x29[1] - x29[0]);
					xmove = xmove.setScale(4,BigDecimal.ROUND_DOWN);
					xmove = xmove.abs();

					ymove = new BigDecimal(y29[1] - y29[0]);
					ymove = ymove.setScale(4,BigDecimal.ROUND_DOWN);
					ymove = ymove.abs();

					zmove = new BigDecimal(z29[1] - z29[0]);
					zmove = zmove.setScale(4,BigDecimal.ROUND_DOWN);
					zmove = zmove.abs();
					
					
					str = time1 + "," + time[1] + "," + x29[1] + "," + y29[1] + "," + z29[1] + "," + frame + "," + xmove + "," + ymove + "," + zmove;

					bw.write(str);
					bw.newLine();
					System.out.println(l);

					time[0] = time[1];
					x29[0] = x29[1];
					y29[0] = y29[1];
					z29[0] = z29[1];

				}
			}
			bw.close();
			System.out.println("fileend");
		}
	}
}
