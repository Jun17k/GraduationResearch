/* チャット用アプレットプログラム */

import java.awt.Color;
import java.awt.Container;
import java.awt.Dimension;
import java.awt.FlowLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.IOException;

import javax.swing.BoxLayout;
import javax.swing.JApplet;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTextArea;
import javax.swing.JTextField;

/*
<applet code="CalculationTest.class" width="500" height="400"></applet>
 */

public class CalculationTest extends JApplet implements Runnable {
	JTextField answer_area;
	JTextArea question_area = new JTextArea(){
		//@Override
		public void append(String str){
			super.append(str);
			question_area.setCaretPosition(question_area.getText().length());
		}
	};

	Client client = null;    // Client クラス
	String host = "localhost";
	static int port = 28000;
	Thread thread = null;
	String user_name;

	public static void main(String args[]) {
		Server server = new Server(port);
		JFrame frame = new JFrame("ChatApplet");
		CalculationTest calculationtest = new CalculationTest();
		calculationtest.init();
		frame.add("Center", calculationtest);
		frame.setBounds(800, 100, 500, 500);
		//		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		frame.setDefaultCloseOperation(JFrame.DO_NOTHING_ON_CLOSE);
		frame.setExtendedState(JFrame.MAXIMIZED_BOTH);	//ウィンドウの最大化
		frame.setVisible(true);
	}

	/* (非 Javadoc)
	 * @see java.applet.Applet#init()
	 */
	public void init() {
		// アプレットのレイアウト
		setLayout(new FlowLayout());

		//上段パネル
		//問題数と計算問題の表示
		question_area.setEditable(false);
		question_area.setText("□■足し算問題■□\n");
		JScrollPane scrollpane = new JScrollPane(question_area,JScrollPane.VERTICAL_SCROLLBAR_ALWAYS,JScrollPane.HORIZONTAL_SCROLLBAR_NEVER);
		scrollpane.setPreferredSize(new Dimension(200, 400));

		//中段パネル
		//解答入力インプットエリア
		JPanel middle_panel = new JPanel();
		answer_area = new JTextField("",30);
		answer_area.setText("");
		answer_area.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				client.write((String)answer_area.getText());
				answer_area.setText("");
			}
		});
		middle_panel.add(answer_area);


		//下段パネル
		//ボタンエリア
		JPanel lower_panel = new JPanel();
		lower_panel.setSize(10,20);
		JButton startButton = new JButton("Start");
		startButton.setSize(30,20);
		startButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				if(user_name == null){
					user_name = JOptionPane.showInputDialog("名前を入力してください（半角英数）");
					try{
						Runtime rt = Runtime.getRuntime();
						//rt.exec(".\\RSTest0915.exe");
						//rt.exec(".\\RSTest1027.exe " + user_name);
						rt.exec(".\\RealSense_FaceData_Record.exe " + user_name);
						answer_area.setText(user_name);
					}catch(IOException ex){
						ex.printStackTrace();
					}
					if(clientOpen()) start();
				}
			}
		});

		JButton quitButton = new JButton("Quit");
		quitButton.setSize(30,20);
		quitButton.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent e) {
				clientClose();
				System.exit(1);
			}
		});

		lower_panel.add(startButton);
		lower_panel.add(quitButton);


		JPanel panel = new JPanel();
		panel.setLayout(new BoxLayout(panel,BoxLayout.Y_AXIS));
		panel.add(scrollpane);
		panel.add(middle_panel);
		panel.add(lower_panel);

		Container contentPane = getContentPane();
		contentPane.setBackground(Color.darkGray);
		contentPane.add(panel);
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

	// クライアントのメインルーチン
	public void run(){
		String s = null;
		while(thread != null) {
			s = client.read();
			if(s == null){
				clientClose();
			}
			else{
				question_area.append(s + "\n");
			}
		}
	}

	// 回線の接続を実行
	public boolean clientOpen(){
		if(client == null){
			client = new Client(host, port);  // Clientクラスの呼び出し
			if(client.socket == null) {       // 接続失敗？
				System.out.println("Connect Err");
				client = null;
				return false;
			}
			else return true;
		}
		else return false;
	}

	// 接続の切断を行なう
	public void clientClose(){
		if(client != null){
			client.close();
			client = null;
			thread = null;
		}
	}

}
