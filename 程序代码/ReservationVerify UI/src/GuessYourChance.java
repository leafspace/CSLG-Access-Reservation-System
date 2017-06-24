/**
 * Created by Administrator on 2017/6/24.
 */

import java.awt.FlowLayout;
import java.awt.GridLayout;
import java.awt.HeadlessException;
import javax.swing.ButtonGroup;
import javax.swing.JButton;
import javax.swing.JCheckBox;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JTextField;

public class GuessYourChance extends JFrame {
    JPanel row1 = new JPanel();
    ButtonGroup btgOption = new ButtonGroup();
    JCheckBox quickPick = new JCheckBox("快速选择", false);
    JCheckBox personal = new JCheckBox("个人的" , true);

    JPanel row2 = new JPanel();
    JLabel numbersLabel = new JLabel("你的输入" , JLabel.RIGHT);
    JTextField[] numbers = new JTextField[6];
    JLabel winnersLabel = new JLabel("中奖数" , JLabel.RIGHT);
    JTextField[] winners = new JTextField[6];

    JPanel row3 = new JPanel();
    JButton stop = new JButton("停止");
    JButton play = new JButton("开始");
    JButton reset = new JButton("重置");

    JPanel row4 = new JPanel();
    JLabel got3Label = new JLabel("6中3" , JLabel.RIGHT);
    JTextField got3 = new JTextField("0");
    JLabel got4Label = new JLabel("6中4" , JLabel.RIGHT);
    JTextField got4 = new JTextField("0");
    JLabel got5Label = new JLabel("6中5" , JLabel.RIGHT);
    JTextField got5 = new JTextField("0");
    JLabel got6Label = new JLabel("6中36" , JLabel.RIGHT);
    JTextField got6 = new JTextField("0");
    JLabel drawingsLabel = new JLabel("Drawing" , JLabel.RIGHT);
    JTextField drawings = new JTextField("0");
    JLabel yearsLabel = new JLabel("Years" , JLabel.RIGHT);
    JTextField years = new JTextField("0");

    public GuessYourChance() throws HeadlessException {
        super("看看你滴运气咋样");
        setSize(500 , 400);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        GridLayout gridLayout = new GridLayout(5, 1, 10, 10);
        setLayout(gridLayout);

        FlowLayout flowLayout1 = new FlowLayout(FlowLayout.CENTER , 10 , 10);
        btgOption.add(quickPick);
        btgOption.add(personal);
        row1.setLayout(flowLayout1);
        row1.add(quickPick);
        row1.add(personal);
        add(row1);

        GridLayout gridLayout1 = new GridLayout(2, 7, 10, 10);
        row2.setLayout(gridLayout1);
        row2.add(numbersLabel);

        for (int i = 0; i < 6; i++) {
            numbers[i] = new JTextField();
            row2.add(numbers[i]);
        }

        row2.add(winnersLabel);
        for (int i = 0; i < 6; i++) {
            winners[i] = new JTextField();
            winners[i].setEditable(true);
            row2.add(winners[i]);
        }
        add(row2);

        FlowLayout flowLayout2 = new FlowLayout(FlowLayout.CENTER);
        row3.setLayout(flowLayout2);
        stop.setEnabled(false);
        row3.add(stop);
        row3.add(play);
        row3.add(reset);
        add(row3);

        GridLayout gridLayout2 = new GridLayout(2, 3, 20, 10);
        row4.setLayout(gridLayout2);
        row4.add(got3Label);
        row4.add(got3);
        row4.add(got4Label);
        row4.add(got4);
        row4.add(got5Label);
        row4.add(got5);
        row4.add(got6Label);
        row4.add(got6);
        row4.add(drawingsLabel);
        row4.add(drawings);
        drawings.setEditable(false);
        row4.add(yearsLabel);
        row4.add(years);
        years.setEditable(false);
        add(row4);
        setVisible(true);
    }

    public static void main(String[] args) {
        GuessYourChance guessYourChance = new GuessYourChance();
    }
}