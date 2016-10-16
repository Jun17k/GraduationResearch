import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.Calendar;

public class Server implements Runnable {
	final int MAX_CHANNELS = 1; // 最大チャネル数
	Channel channel[] = new Channel[MAX_CHANNELS];
	ServerSocket serversocket;    // 接続受け付け用ServerSocket
	int port;                     // ポート番号
	Thread thread;

	public static final int MAX_QUESTIONS = 50;	//問題数

	//日時の取得
	Calendar calendar = Calendar.getInstance();
	int year = calendar.get(Calendar.YEAR);
	int month = calendar.get(Calendar.MONTH) + 1;
	int day = calendar.get(Calendar.DATE);
	int hour = calendar.get(Calendar.HOUR_OF_DAY);
	int minute = calendar.get(Calendar.MINUTE);
	int second = calendar.get(Calendar.SECOND);
	int millisecond = calendar.get(Calendar.MILLISECOND);

	String hour_min = "";
	int msec;

	//足し算問題用変数
	int i;
	int j;

//	public static void main(String args[]) {
//		if (args.length < 1) 
//			System.out.println("%java Server port_number");
//		else  {
//			int p = Integer.parseInt(args[0]);
//			new Server(p);
//		}
//	}

	public Server(int port) {
		this.port = port;
		this.start();
	}

	// メインサーバーの切断を行なう
	public void serverClose() {
		try {
			System.out.println("Server#Close()");
			serversocket.close();
			serversocket = null;
		} catch (IOException e) {e.printStackTrace(System.err);}
	}

	// 全チャネルの切断を行なう
	public void clientClose() {
		System.out.println("Server#Close "+channel.length);
		for (int i = 0; i < channel.length; i++) {
			System.out.println("Server#Close("+i+")");
			channel[i].close();
			channel[i] = null;
		}
	}

	public void quit() {
		clientClose();
		serverClose();
		System.exit(1);
	}

	public void start() {
		if (thread == null) {
			thread = new Thread(this);
			thread.start();
		}
	}

	public void stop() {
		if (thread != null) {
			thread.stop();
			thread = null;
		}
	}

	public void run() {
		int i;

		try {
			serversocket = new ServerSocket(port);   // メインサーバー開放
			while (true) {                     // 空いているチャネルを探す
				for (i = 0; i < MAX_CHANNELS; i++) {
					if (channel[i] == null || channel[i].thread == null) {
						break;
					}
				}
				if (i == MAX_CHANNELS){      // 最大のクライアント数なら終了
					return;
				}
				Socket socket = serversocket.accept();    // 接続待ち
				channel[i] = new Channel(socket, this);  // 新チャネル作成	
			}

		} catch(IOException e) {
			System.out.println("Server Err!");
			return;
		}
	}

	// 全チャネルへブロードキャスト
	synchronized void broadcast(String message) {
		for (int i = 0; i < MAX_CHANNELS; i++) {
			if (channel[i] != null && channel[i].socket != null) {
				channel[i].write(message);
			}
		}
	}

	FileWriter fw;
	PrintWriter pw;
	public void makeFile(String user_name){
		try {
			//出力先を作成する
			String startdate = "";
			startdate = startdate + year;

			if(month < 10){
				startdate += "0" + month;
			}else{
				startdate += month;
			}

			if(day < 10){
				startdate += "0" + day;
			}else{
				startdate += day;
			}

			startdate += "_";

			if(hour < 10){
				startdate += "0" + hour;
			}else{
				startdate += hour;
			}

			if(minute < 10){
				startdate += "0" + minute;
			}else{
				startdate += minute;
			}

//			fw = new FileWriter(".\\keisan_csv\\keisan_" + handle + "_" + year + "_" + month + "_" + day + "_" + hour + "_" + minute + "_" + second +  ".csv", false);  //※１
			fw = new FileWriter("..\\keisan_csv\\" + user_name + "_" +  startdate + "keisan.csv", false);  //※１
			pw = new PrintWriter(new BufferedWriter(fw));
			pw.print("hour-min,");
			pw.print("msec,");
			pw.print("n,i,j,ans,check");
			pw.println();
		} catch (IOException ex) {
			//例外時処理
			ex.printStackTrace();
		}
	}

	public void endFile(){
		calendar = Calendar.getInstance();
		hour = calendar.get(Calendar.HOUR_OF_DAY);
		minute = calendar.get(Calendar.MINUTE);
		second = calendar.get(Calendar.SECOND);
		millisecond = calendar.get(Calendar.MILLISECOND);

		hour_min = "";

		if(hour < 10){
			hour_min += "0" + hour;
		}else{
			hour_min += hour;
		}

		if(minute < 10){
			hour_min += "0" + minute;
		}else{
			hour_min += minute;
		}

		msec = second *1000 + millisecond;

		pw.print(hour_min + ",");
		pw.print(msec + ",");
		pw.print("0,0,0,0,0");
		pw.println();
		pw.close();
	}

	public void writeNowTime(int n){
		calendar = Calendar.getInstance();
		hour = calendar.get(Calendar.HOUR_OF_DAY);
		minute = calendar.get(Calendar.MINUTE);
		second = calendar.get(Calendar.SECOND);
		millisecond = calendar.get(Calendar.MILLISECOND);

		hour_min = "";

		if(hour < 10){
			hour_min += "0" + hour;
		}else{
			hour_min += hour;
		}

		if(minute < 10){
			hour_min += "0" + minute;
		}else{
			hour_min += minute;
		}

		msec = second *1000 + millisecond;

		pw.print(hour_min + ",");
		pw.print(msec + ",");
		pw.print(n + ",");
		pw.print(i + "," + j + ",");
	}

	public void makeQuestion(int n){
		// ランダムで1から100までの数字を1つ抽選
		i = (int)(Math.random() * 100) + 1;
		j = (int)(Math.random() * 100) + 1;


		broadcast("+-------------------------+");
		broadcast("第 " + n + "問");
		broadcast(i + "+"  + j  + "= ");
	}

	public boolean checkAnswer(int ans){
		if(i+j == ans)return true;
		return false;
	}

}





