import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.StringTokenizer;

public class CreateDataset2 {
	//Yaw,Pitch,Rollの移動量計測用データセット

	static final int MAX_Num_Dimension = 4;	//元のデータの次元数

	public static void main(String args[]) throws IOException{

		String directory ="C:/Users/Shibasaki/Desktop/DataSet/YawPitchRoll/";
		String inputfile[] = {
//				directory + "landmark_shibasaki_2015_10_28_11_35_54.csv",
//				directory + "landmark_shibasaki_2015_10_28_20_44_3.csv",
//				directory + "landmark_shibasaki_2015_11_4_10_42_52.csv",
//				directory + "landmark_shibasaki_2015_11_6_11_47_28.csv",
//				directory + "landmark_shibasaki_2015_11_6_17_33_12.csv",
				directory + "landmark_shibasaki_2015_11_9_18_57_49.csv",
				directory + "landmark_shibasaki_2015_11_10_11_7_17.csv"
		};
		
		String outputfile[] = {
//				directory + "landmark2_shibasaki_2015_10_28_11_35_54.csv",
//				directory + "landmark2_shibasaki_2015_10_28_20_44_3.csv",
//				directory + "landmark2_shibasaki_2015_11_4_10_42_52.csv",
//				directory + "landmark2_shibasaki_2015_11_6_11_47_28.csv",
//				directory + "landmark2_shibasaki_2015_11_6_17_33_12.csv",
				directory + "landmark2_shibasaki_2015_11_9_18_57_49.csv",
				directory + "landmark2_shibasaki_2015_11_10_11_7_17.csv"
		};
		
		for(int i=0; i < inputfile.length; i++){
			BufferedReader br = new BufferedReader(new FileReader(inputfile[i]));
			BufferedWriter bw = new BufferedWriter(new FileWriter(outputfile[i],true));

			String line = "";		//ファイルから読み込んだ1行
			String str;				//書き出すための一行

//			int n;		//次元数の管理
			int l = 0;	//行数の管理

			try{
				File file = new File(inputfile[i]);
				FileReader filereader = new FileReader(file);
			}catch(FileNotFoundException e1){
				System.out.println(e1);
			}
			
			String time1;
			int time[] = new int[2];
			double yaw[] = new double[2];
			double pitch[] = new double[2];
			double roll[] = new double[2];

			time[0] = 0;
			yaw[0] = 0;
			pitch[0] = 0;
			roll[0] = 0;

			while((line = br.readLine()) != null){
				StringTokenizer st = new StringTokenizer(line, ",");	//1行をカンマで区切る

				int frame;
				BigDecimal ymove;
				BigDecimal pmove;
				BigDecimal rmove;

//				n= 1;
				l = l +1;
				str = "";
				
//				for(int n = 1; n < MAX_Num_Dimension + 1; n++){
				while(st.hasMoreTokens()){

					if(l == 1){
						str = "time1,time2,yaw,pitch,roll,frame,Y_move,P_move,R_move";
						bw.write(str);
						bw.newLine();
						System.out.println(l);
						break;
					}
					time1 = st.nextToken();
					time[1] = Integer.valueOf(st.nextToken());
					yaw[1] = Double.valueOf(st.nextToken());
					pitch[1] = Double.valueOf(st.nextToken());
					roll[1] = Double.valueOf(st.nextToken());

					if(yaw[1] == 0){
						break;
					}

					frame = time[1]-time[0];

					ymove = new BigDecimal(yaw[1] - yaw[0]);
					ymove = ymove.setScale(4,BigDecimal.ROUND_DOWN);
					ymove = ymove.abs();

					pmove = new BigDecimal(pitch[1] - pitch[0]);
					pmove = pmove.setScale(4,BigDecimal.ROUND_DOWN);
					pmove = pmove.abs();

					rmove = new BigDecimal(roll[1] - roll[0]);
					rmove = rmove.setScale(4,BigDecimal.ROUND_DOWN);
					rmove = rmove.abs();

					str = time1 + "," + time[1] + "," + yaw[1] + "," + pitch[1] + "," + roll[1] + "," + frame + "," + ymove + "," + pmove + "," + rmove;

					bw.write(str);
					bw.newLine();
					System.out.println(l);

					time[0] = time[1];
					yaw[0] = yaw[1];
					pitch[0] = pitch[1];
					roll[0] = roll[1];
				}
			}
			bw.close();
		}
	}
}
