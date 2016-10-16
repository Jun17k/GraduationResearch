import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.StringTokenizer;

public class R_CreateDataset {
	//R用にデータセットをそろえる
	//null値を含む行の削除
	//0値を含む行の削除
	
	
	static final int MAX_Num_Dimension = 243;	//元のデータの次元数

	public static void main(String args[]) throws IOException{
		
		//入力ファイルの読み込み
		String input_directory = "C:/Users/Shibasaki/Desktop/DataFile0122/kakou_landmark_csv_0122/";
		String inputfile[] = {
				input_directory + "inoue_20151211_1450landmark.csv",
				input_directory + "inoue_20151216_1857landmark.csv",
				input_directory + "inoue_20151222_1308landmark.csv",
				input_directory + "inoue_20151223_1235landmark.csv",
				input_directory + "inoue_20151223_2051landmark.csv",
				input_directory + "inoue_20151225_0913landmark.csv",
				input_directory + "inoue_20160113_1310landmark.csv",
				input_directory + "inoue_20160113_1918landmark.csv",
				input_directory + "kanomata_20151217_1959landmark.csv",
				input_directory + "kanomata_20151222_1112landmark.csv",
				input_directory + "kanomata_20151223_1241landmark.csv",
				input_directory + "kanomata_20151223_2115landmark.csv",
				input_directory + "kanomata_20160120_1146landmark.csv",
				input_directory + "kanomata_20160120_1149landmark.csv",
				input_directory + "kanomata_20160120_1958landmark.csv",
				input_directory + "kanomata_20160120_2000landmark.csv",
				input_directory + "minami_20151211_1445landmark.csv",
				input_directory + "minami_20151212_0155landmark.csv",
				input_directory + "minami_20151214_1534landmark.csv",
				input_directory + "minami_20151218_1248landmark.csv",
				input_directory + "minami_20151220_1905landmark.csv",
				input_directory + "minami_20151220_2051landmark.csv",
				input_directory + "minami_20151222_1900landmark.csv",
				input_directory + "minami_20151222_2149landmark.csv",
				input_directory + "shibasaki_20151216_1043landmark.csv",
				input_directory + "shibasaki_20151217_1127landmark.csv",
				input_directory + "shibasaki_20151218_1109landmark.csv",
				input_directory + "shibasaki_20151221_2047landmark.csv",
				input_directory + "shibasaki_20151225_0907landmark.csv",
				input_directory + "shibasaki_20160106_1250landmark.csv",
				input_directory + "shibasaki_20160111_1158landmark.csv",
				input_directory + "shibasaki_20160112_1744landmark.csv"
		};
		
		//出力ファイルの作成
		String output_directory = "C:/Users/Shibasaki/Desktop/DataFile0122/java_landmark_0122/";
		String outputfile[] = {
				output_directory + "java_inoue_20151211_1450landmark.csv",
				output_directory + "java_inoue_20151216_1857landmark.csv",
				output_directory + "java_inoue_20151222_1308landmark.csv",
				output_directory + "java_inoue_20151223_1235landmark.csv",
				output_directory + "java_inoue_20151223_2051landmark.csv",
				output_directory + "java_inoue_20151225_0913landmark.csv",
				output_directory + "java_inoue_20160113_1310landmark.csv",
				output_directory + "java_inoue_20160113_1918landmark.csv",
				output_directory + "java_kanomata_20151217_1959landmark.csv",
				output_directory + "java_kanomata_20151222_1112landmark.csv",
				output_directory + "java_kanomata_20151223_1241landmark.csv",
				output_directory + "java_kanomata_20151223_2115landmark.csv",
				output_directory + "java_kanomata_20160120_1146landmark.csv",
				output_directory + "java_kanomata_20160120_1149landmark.csv",
				output_directory + "java_kanomata_20160120_1958landmark.csv",
				output_directory + "java_kanomata_20160120_2000landmark.csv",
				output_directory + "java_minami_20151211_1445landmark.csv",
				output_directory + "java_minami_20151212_0155landmark.csv",
				output_directory + "java_minami_20151214_1534landmark.csv",
				output_directory + "java_minami_20151218_1248landmark.csv",
				output_directory + "java_minami_20151220_1905landmark.csv",
				output_directory + "java_minami_20151220_2051landmark.csv",
				output_directory + "java_minami_20151222_1900landmark.csv",
				output_directory + "java_minami_20151222_2149landmark.csv",
				output_directory + "java_shibasaki_20151216_1043landmark.csv",
				output_directory + "java_shibasaki_20151217_1127landmark.csv",
				output_directory + "java_shibasaki_20151218_1109landmark.csv",
				output_directory + "java_shibasaki_20151221_2047landmark.csv",
				output_directory + "java_shibasaki_20151225_0907landmark.csv",
				output_directory + "java_shibasaki_20160106_1250landmark.csv",
				output_directory + "java_shibasaki_20160111_1158landmark.csv",
				output_directory + "java_shibasaki_20160112_1744landmark.csv"
		};
		
		//入力ファイル群を順番に処理
		for(int i=0; i < inputfile.length; i++){	
			
			//入力ファイルを1行読み込む
			BufferedReader br = new BufferedReader(new FileReader(inputfile[i]));
			
			//出力ファイルへ1行書き込む
			BufferedWriter bw = new BufferedWriter(new FileWriter(outputfile[i],true));
			
			//入力ファイルの例外処理
			try{
				File file = new File(inputfile[i]);
				FileReader filereader = new FileReader(file);
			}catch(FileNotFoundException e1){
				System.out.println(e1);
			}
			
			int l = 0;	//行数の管理
			String line = "";		//ファイルから読み込んだ1行
			String str;				//書き出すための一行
			
			String label[] = new String[MAX_Num_Dimension +1];	//1行目のヘッダーを格納

			String realtime ="";	//1列目の日時時間
			int frametime[] = new int[2];	//2列目の経過フレーム数
			Double data[] = new Double[MAX_Num_Dimension +1];	//3列目以降の値を格納
			
			frametime[0] = 0;

			//1行ずつすべての行に対して処理を行う
			while((line = br.readLine()) != null){
				
				//1行をカンマで区切る
				StringTokenizer st = new StringTokenizer(line, ",");	

				//int frame;
				l = l +1;
				str = "";
				int n =1;
				
				//ここから読み込み
				//改行まで一つずつ区切る
				while(st.hasMoreTokens()){		
					
					if(l == 1){	//1行目はラベル
						label[n] = st.nextToken();
					}else{
						if(n == 1){	//1列目は日時
							realtime = st.nextToken();	
						}else if(n==2){	//2列目は経過フレーム数
							frametime[1] = Integer.valueOf(st.nextToken());
						}else{
							data[n] = Double.valueOf(st.nextToken());
						}
					}
					n += 1;
				}
				
				//ここから書き込み
				//書き込み用のstrを作成
				if(l == 1){	//1行目はラベル
					for(int j=1; j <= MAX_Num_Dimension; j++){
						str += label[j];
						if(j < MAX_Num_Dimension){
							str += ",";
						}
					}
				}else{
					if(data[3] != 0 && data[4] != 0 && data[5] != 0){	//顔を認識している時
//						frame = frametime[1]-frametime[0];
						frametime[0] = frametime[1];
						
						for(int j=1; j <= MAX_Num_Dimension; j++){
							if(j == 1){
								str += realtime;
							}else if(j == 2){
								str += frametime[1];
							}else{
								str += data[j];
							}
							
							if(j < MAX_Num_Dimension) str += ",";
						}
					}
				}
				
				//strを出力ファイルに書き込む
				if(n == MAX_Num_Dimension +1 && str != ""){
					bw.write(str);
					bw.newLine();
					//System.out.println(l);
					l += 1;
				}
			}
			bw.close();
			System.out.println("File[" + i + "]end (line=" + l + ")");
		}
	}
}
