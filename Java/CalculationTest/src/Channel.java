/*各チャネル用のサーバプログラム*/   
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.Socket;

public class Channel implements Runnable {
	Server server;             // チャットサーバ本体
	Socket socket = null;      // ソケット
	BufferedReader input;      // 入力用ストリーム
	OutputStreamWriter output; // 出力用ストリーム
	public Thread thread;      // チャネルを駆動するためのスレッド
	String user_name;             // クライアントのハンドル

	boolean bl = true;	// ループ用のboolean変数

	int n = 1;	//問題数の管理
	int t = 0;	//正答数の管理

	// 引数はチャネル番号、ソケット、Server.
	Channel(Socket s, Server cs) {
		server = cs;
		socket = s;
		start();
	}

	public void start() {
		thread = new Thread(this);
		thread.start();
	}

	public void stop() {
		thread = null;
	}

	// クライアントへ文字列を出力する
	synchronized void write(String s) {
		try {
			output.write(s + "\r\n");
			output.flush();
		} catch (IOException e) {
			System.out.println("Write Err");
			close(); // エラーを起こしたら、接続を切断する
		}
	}



	//チャネルのメインルーチン。
	// クライアントからの入力を受け付ける
	public void run() {
		String s;
		try {
			// ソケットから入出力ストリームを得る
			input = new BufferedReader(new InputStreamReader(socket.getInputStream()));
			output = new OutputStreamWriter(socket.getOutputStream());

			//welcomeメッセージ
			write("足し算が" + server.MAX_QUESTIONS + "問出題されます。\n");
			write("入力エリアでEnterキーを押してください");      // ハンドル名登録
			user_name = input.readLine();
			write("");
			write("<" + user_name + ">");
			write("");
			write("5秒後に開始されます．");
			write("");

			try{
				Thread.sleep(5000);
			}catch (InterruptedException e){
			}

			server.makeFile(user_name);	//csvファイルの作成

			while (thread != null) {
				//例外処理(数字以外が入力された場合)のループ
					server.makeQuestion(n);	//問題をランダムで作成
					server.writeNowTime(n);	//今の時間をcsvファイルに書き込む

					while(bl){
						try {
							s = input.readLine();  // 文字列入力を待つ
							if (s == null){
								close();
							}else {
								write(s);
								int ans = Integer.parseInt(s);
								server.pw.print(ans + ",");

								if(server.checkAnswer(ans)){
									t += 1;
									write("正解!!         (" + t + "/" + n + ")");
									server.pw.print(1);
									break;
								} else {
									write("不正解です...   (" + t + "/" + n + ")");
									server.pw.print(0);
									break;
								}
							}
						} catch (IOException e) {
							System.out.println(e);
						} catch (NumberFormatException e) {
							write("半角数字で入力してください");
							write("= ");
						}
					}

					//改行
					server.pw.println();

					n += 1;

					if (n <= server.MAX_QUESTIONS){
						continue;
					}else{
						write("+-------------------------+");
						write("お疲れ様でした");
						server.endFile();
						bl = false;
						break;
					}
			}
			close();
		} catch (IOException ex) {
			//例外時処理
			ex.printStackTrace();
		}

	}


	// 接続を切断する
	public void close() {
		try {
			input.close();     // ストリームを閉じる
			output.close();
			socket.close();    // ソケットを閉じる
			socket = null;
			server.endFile();
			server.broadcast("# 回線切断 :" + user_name);
			stop();
		} catch(IOException e) {
			System.out.println("Close Err");
		}
	}

}
