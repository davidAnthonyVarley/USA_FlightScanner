class Map
{
  private PShape shape;
  private PShape state;
  private int x, y, w, h;
  private FlightCount[] data;
  
  private int getMaxFlightCount()
  {
    int maximum = 0;
    for (int i = 0; i < data.length; ++i)
    {
      maximum = max(maximum, data[i].count);
    }
    return maximum;
  }
  
  public Map(String svgPath, int x, int y, int w, int h, Flights flights)
  {
    shape = loadShape(svgPath);
    data = flights.getFlightsByStates();
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h; 
    
    int r=255; int g=0; int b=0;
    for (int i=0; i<data.length; i++)
    {
      String code = data[i].category;
      int flight = data[i].count;
      state = shape.getChild(code);
      
      if (state != null)
      {
        int percent = round((100*flight)/getMaxFlightCount());
        int gAndB= round(percent*4.55);
        gAndB= gAndB-455;
        if (gAndB<0)
        {
          gAndB=gAndB*-1;
        }
        if (gAndB >255 && gAndB<280)
        {
            g=255;
            b=gAndB-255;
        }
        if (gAndB>280)
        {
          g=255;
          b=gAndB-230;
        }
        else
        {
            g=gAndB;
            b=0;
        }
        state.setFill(color(r,g,b));
      }
    }
  }

  public void draw()
  {
    shape(shape, x, y, w, h);  
    //0%==480, 10%== 430, 20%==385,  30%==340,  40%==270,  50%==225, 60%==180,  70%==135,   80==90, 90%==45,   0%==0
    noStroke();
    fill(255);
    rect(MAP_WIDTH-75, MAP_HEIGHT-280, 75, 30);
    fill(255,0,0); rect(MAP_WIDTH-75, MAP_HEIGHT-250, 75, 20); //100%
    fill(255,45,0); rect(MAP_WIDTH-75, MAP_HEIGHT-230, 75, 20); //90&
    fill(255,90,0); rect(MAP_WIDTH-75, MAP_HEIGHT-210, 75, 20); //80%
    fill(255,135,0); rect(MAP_WIDTH-75, MAP_HEIGHT-190, 75, 20); //70%
    fill(255,180,0); rect(MAP_WIDTH-75, MAP_HEIGHT-170, 75, 20); //60%
    fill(255,225,0); rect(MAP_WIDTH-75, MAP_HEIGHT-150, 75, 20); //50%
    fill(255,255,45); rect(MAP_WIDTH-75, MAP_HEIGHT-130, 75, 20); //40%
    fill(255,255,90); rect(MAP_WIDTH-75, MAP_HEIGHT-110, 75, 20); //30%
    fill(255,255,135); rect(MAP_WIDTH-75, MAP_HEIGHT-90, 75, 20); //20%
    fill(255,255,180); rect(MAP_WIDTH-75, MAP_HEIGHT-70, 75, 20); //10%
    fill(255,255,230); rect(MAP_WIDTH-75, MAP_HEIGHT-50, 75, 20); //0%
    
    //textSize(128);
  //  //stroke(0);
  //  rect(MAP_WIDTH-120, MAP_HEIGHT-250, 45, 220);
 //   rect(MAP_WIDTH-120, MAP_HEIGHT-280, 120, 30);
  //  fill(0); rect(MAP_WIDTH-120, MAP_HEIGHT-250, 45, 1);
  //  //noStroke();
    fill(0);
    text("Flights:", MAP_WIDTH-50, MAP_HEIGHT-265);
      text((getMaxFlightCount()/1000)*1000, MAP_WIDTH-50, MAP_HEIGHT-240);
      text(round((getMaxFlightCount()*0.9)/1000)*1000, MAP_WIDTH-50, MAP_HEIGHT-220);
      text(round((getMaxFlightCount()*0.8)/1000)*1000, MAP_WIDTH-50, MAP_HEIGHT-200);
      text(round((getMaxFlightCount()*0.7)/1000)*1000, MAP_WIDTH-50, MAP_HEIGHT-180);
      text(round((getMaxFlightCount()*0.6)/1000)*1000, MAP_WIDTH-50, MAP_HEIGHT-160);
      text(round((getMaxFlightCount()*0.5)/1000)*1000, MAP_WIDTH-50, MAP_HEIGHT-140);
      text(round((getMaxFlightCount()*0.4)/1000)*1000, MAP_WIDTH-50, MAP_HEIGHT-120);
      text(round((getMaxFlightCount()*0.3)/1000)*1000, MAP_WIDTH-50, MAP_HEIGHT-100);
      text(round((getMaxFlightCount()*0.2)/1000)*1000, MAP_WIDTH-50, MAP_HEIGHT-80);
      text(round((getMaxFlightCount()*0.1)/1000)*1000, MAP_WIDTH-50, MAP_HEIGHT-60);
      text(round(getMaxFlightCount()*0), MAP_WIDTH-68, MAP_HEIGHT-40);
      
      

  }
}// C O'Sull implemented heatmap into main 05/04/23
