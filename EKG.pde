import controlP5.*;
import java.util.*;

ControlP5 Group;
ControlTimer c;
Textlabel t;
ControlP5 cp5;
RadioButton r1;
DropdownList l1;
List l = Arrays.asList("ECG", "EEG", "EMG", "CP");
Chart myChart;

int selectedImage1;
int selectedImage2;
int selectedImage3;
String selectedGroup = "ImageSelect1";
int selectedImage;
int selectedItem;
Button b1, b2;
PImage img;  

PImage[] images = new PImage[3]; // array of images


void setup() {
  size(400, 800);
  cp5 = new ControlP5(this);
  r1 = cp5.addRadioButton("Mode")
    .setPosition(300, 600)
    .setSize(50, 50)
    .setColorActive(color(255))
    .setColorLabel(color(153,0,0))
    .setColorForeground(color(102,178,255))
    .addItem("Start", 1)
    .addItem("Stop", 2);


  l1 = cp5.addDropdownList("Type of signal", width/2-50, 100, 100, 120).setPosition(100, 600);
  l1.setBackgroundColor(color(250));
  l1.setItemHeight(20);
  l1.setBarHeight(20);
  l1.setLabel("Type of signal");
  l1.setColorCaptionLabel(color(153,0,0));

  l1.addItem("ecg", 0); // remove .setId(0); we can use the value 0 as identifier 
  l1.addItem("eeg", 1); // remove .setId(1); we can use the value 1 as identifier
  l1.addItem("emg", 2); // remove .setId(2); we can use the value 2 as identifier
  l1.setColorBackground(color(102,178,255));
  l1.setColorActive(color(255, 128));

  images[0] = loadImage("image1.jpg"); 
  images[1] = loadImage("image2.jpg");
  images[2]= loadImage("image3.jpg");
  
  c = new ControlTimer();
  t = new Textlabel(cp5, "--", 100, 100);
  c.setSpeedOfTime(1);
  
  myChart = cp5.addChart("dataflow")
               .setPosition(20, 350)
               .setSize(350, 200)
               .setRange(-20, 20)
               .setView(Chart.LINE) // use Chart.LINE, Chart.PIE, Chart.AREA, Chart.BAR_CENTERED
               .setStrokeWeight(1.5)
               .setColorCaptionLabel(color(40))
               ;

  myChart.addDataSet("incoming");
  myChart.setData("incoming", new float[100]);
  

}


void draw() {
  background(220);
  fill(127,0,0);

  image(images[selectedImage], 20, 70, 350, 200); // show the selected image
  
  t.setValue(c.toString());
  t.draw(this);
  t.setPosition(200, 300);
  
  t.setFont(createFont("Georgia",30));
  
  myChart.push("incoming", (sin(frameCount*0.1)*10));
}


void controlEvent(ControlEvent theEvent) {

  if (theEvent.isGroup()) {
    // if the name of the event is equal to ImageSelect (aka the name of our dropdownlist)
    if (theEvent.group().getName() == "ImageSelect") {
      // then do stuff, in this case: set the variable selectedImage to the value associated
      // with the item from the dropdownlist (which in this case is either 0 or 1)
      selectedImage = int(theEvent.group().getValue());
    }
  } else if (theEvent.isController()) {
    // not used in this sketch, but has to be included
  }
}
