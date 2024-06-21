import java.util.HashMap;

class AirportPicker
{
  private final String[] codes = {
    "LAX","JFK","DEN","ORD","MCO","ATL","DFW","AUS","CLT","LGA","PHX","LAS","SEA","DCA","IAH","EWR",
    "DTW","MIA","BOS","SFO","MSP","KOA","HNL","LIH","OGG","ITO","PDX","LGB","MYR","FLL","AEX","TPA",
    "RSW","MCI","MSY","SJU","PHL","BWI","IND","OAK","BZN","BOI","CPR","MOT","FSD","OMA","ICT","OKC",
    "LIT","XNA","SLC","ABQ","ANC","JAN","PWM","CMH","CRW","SDF","BNA","BHM"
  };

  private final float[] xCoordinates = {
    0.061, 0.8525, 0.34167, 0.6175, 0.771, 0.7008, 0.4696, 0.4456, 0.7632, 0.856, 0.1872, 0.1408, 0.0944,
    0.8088, 0.5024, 0.844, 0.6904, 0.8016, 0.888, 0.028, 0.5312, 0.3232, 0.2824, 0.2512, 0.316, 0.3416,
    0.0824, 0.0744, 0.7936, 0.8008, 0.5472, 0.7512, 0.7744, 0.5048, 0.5992, 0.8056, 0.8312, 0.812, 0.648,
    0.0368, 0.2448, 0.1696, 0.3152, 0.4016, 0.4728, 0.4792, 0.4648, 0.4496, 0.556, 0.5176, 0.204, 0.2904,
    0.12, 0.596, 0.8888, 0.704, 0.736, 0.6672, 0.6424, 0.6496
  };

  private final float[] yCoordinates = {
    0.567, 0.359, 0.44, 0.375, 0.835, 0.6627, 0.7133, 0.8307, 0.5973, 0.3467, 0.6733, 0.5373, 0.0707, 0.44,
    0.8173, 0.352, 0.352, 0.92, 0.283, 0.443, 0.2853, 0.9533, 0.8973, 0.8747, 0.9147, 0.9533, 0.0973, 0.5907,
    0.6387, 0.9013, 0.78, 0.8573, 0.9227, 0.4773, 0.8133, 0.9893, 0.396, 0.42, 0.452, 0.4427, 0.2213, 0.2693,
    0.3333, 0.152, 0.3227, 0.396, 0.5347, 0.6227, 0.6453, 0.5933, 0.4013, 0.6013, 0.896, 0.716, 0.2213,
    0.432, 0.472, 0.5013, 0.576, 0.6653
  };

  private int w, h, airportRadius;
  private int departure = -1, arrival = -1;
  private Flights flights;
  private Filter filter = new Filter();
  private HashMap<String, Integer> flightLines = null;
  private float animationPosition = 0.0, animationSpeed = 0.0;

  public AirportPicker(int w, int h, int airportRadius, Flights flights)
  {
    this.w = w;
    this.h = h;
    this.airportRadius = airportRadius;
    this.flights = flights;
  }

  public void setFilter(Filter newFilter)
  {
    if (!filter.equals(newFilter))
    {
      filter = newFilter;
      flightLines = flights.getAirports(filter);
    }
  }

  public String getDeparture()
  {
    return departure < 0 ? "" : codes[departure];
  }

  public String getArrival()
  {
    return arrival < 0 ? "" : codes[arrival];
  }

  private boolean isInAirport(int posX, int posY, int airportIndex)
  {
    float dx = posX - xCoordinates[airportIndex] * w;
    float dy = posY - yCoordinates[airportIndex] * h;
    return dx * dx + dy * dy < airportRadius * airportRadius;
  }

  private int airportAt(int posX, int posY)
  {
    for (int i = 0; i < codes.length; ++i)
    {
      if (isInAirport(posX, posY, i))
      {
        return i;
      }
    }
    return -1;
  }

  public void mouseClick(int clickX, int clickY)
  {
    int clicked = airportAt(clickX, clickY);
    if (clicked >= 0)
    {
      if (departure < 0)
      {
        departure = clicked;
      }
      else if (arrival < 0)
      {
        arrival = clicked;
      }
      else
      {
        arrival = departure = -1;
      }
      if (departure >= 0 && arrival >= 0)
      {
        animationPosition = 0.0;
        float dx = xCoordinates[arrival] - xCoordinates[departure];
        float dy = yCoordinates[arrival] - yCoordinates[departure];
        animationSpeed = 0.005 / sqrt(dx * dx + dy * dy);
      }
    }
  }

  private void drawPrompt()
  {
    noStroke();
    fill(#FFFADA);
    rect(400, 10, 480, 30);

    fill(#000000);
    text("From: ", 450, 25);
    text(departure >= 0 ? codes[departure] : "Please Select Departure", 575, 25);
    text("To: ", 680, 25);
    text(arrival >= 0 ? codes[arrival] : "Please Select Arrival", 775, 25);
  }

  private void drawAnimation()
  {
    float circleX = (1 - animationPosition) * xCoordinates[departure] + animationPosition * xCoordinates[arrival];
    float circleY = (1 - animationPosition) * yCoordinates[departure] + animationPosition * yCoordinates[arrival];
    
    noStroke();
    fill(0);
    circle(circleX * w, circleY * h, 10);
    
    animationPosition += animationSpeed;
    if (animationPosition > 1)
    {
      animationPosition = 0;
    }
  }

  private void drawAirportCaption(int airport, String captionPrefix)
  {
    float x = xCoordinates[airport] * w;
    float y = yCoordinates[airport] * h;
    
    noStroke();
    fill(#FFFADA);
    rect(x - 50, y - 30, 90, 20);
    
    fill(#4B0076);
    text(captionPrefix + codes[airport], x - 10, y - 20);
    
    stroke(0);
    line(x + 30, y - 20, x + 40, y - 30);
    line(x + 30, y - 30, x + 40, y - 20);
  }

  private void drawLine(int airportFrom, int airportTo)
  {
    stroke(#4C0013);
    line(xCoordinates[airportFrom] * w, yCoordinates[airportFrom] * h, xCoordinates[airportTo] * w, yCoordinates[airportTo] * h);
  }

  private void drawLines(int airportFrom)
  {
    stroke(#4C0013);
    for (int i = 0; i < codes.length; ++i)
    {
      if (airportFrom != i && flightLines.containsKey(codes[i]))
      {
        drawLine(airportFrom, i);
      }
    }
  }

  private void drawAirports()
  {
    for (int i = 0; i < codes.length; ++i)
    {
      if (isInAirport(mouseX, mouseY, i) && departure != i && arrival != i)
      {
        fill(#FFFADA);
        noStroke();
        rect(xCoordinates[i] * w - 20, yCoordinates[i] * h - 30 - airportRadius, 40, 20);
        fill(#4B0076);
        text(codes[i], xCoordinates[i] * w, yCoordinates[i] * h - 20 - airportRadius);
      }
      else
      {
        fill(#9966CB);
      }
      stroke(0);
      circle(xCoordinates[i] * w, yCoordinates[i] * h, airportRadius * 2);
    }
  }

  public void draw()
  {
    drawPrompt();

    if (departure >= 0)
    {
      drawLines(departure);
      drawAirportCaption(departure, "DEP: ");
    }
    if (arrival >= 0)
    {
      drawAirportCaption(departure, "ARR: ");
    }
    if (departure >= 0 && arrival >= 0)
    {
      drawLine(departure, arrival);
      drawAnimation();
    }
    drawAirports();
  }
}
