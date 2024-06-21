class TextInfoDataView extends DataView
{
  private int flightIndex = 0;
  private String dateStr = "";

  public TextInfoDataView(Flights flights, int x, int y, int w, int h)
  {
    super(flights, x, y, w, h);
    flightIndex = min(0, flights.size() - 1);
  }

  protected void filterUpdated()
  {
    flightIndex = flights.firstMatching(filter, 0, 1);
    updateDateStr();
  }

  private void step(int direction)
  {
    flightIndex = flights.firstMatching(filter, flightIndex < 0 ? 0 : flightIndex + direction, direction);
    updateDateStr();
  }

  private void updateDateStr()
  {
    if (flightIndex >= 0)
    {
      dateStr = Date.format(flights.get(flightIndex).flightDate);
    }
  }

  private String formatTime(int sinceMidnight)
  {
    if (sinceMidnight > 1440)
    {
      return "N/A";
    }
    int minutes = sinceMidnight % 60;
    int hours = sinceMidnight / 60;
    return "" + hours + (minutes < 10 ? ":0" : ":") + minutes;
  }

  public void draw()
  {
    noStroke();

    fill(0);
    textAlign(LEFT, TOP);
    int textX = x + 15;

    if (flightIndex != -1)
    {
      Flight flight = flights.get(flightIndex);

      text("Flight Date: " + dateStr, textX, y);
      text("Carrier Code: " + flight.carrierCode, textX, y + 25);
      text("Flight Number: " + flight.flightNumber, textX, y + 50);
      text("Origin Airport: " + flight.originAirportCode, textX, y + 75);
      text("Origin City: " + flight.originCityName, textX, y + 100);
      text("Destination Airport: " + flight.destinationAirportCode, textX, y + 125);
      text("Destination City: " + flight.destinationCityName, textX, y + 150);
      text("Scheduled Departure: " + formatTime(flight.scheduledDeparture), textX, y + 175);
      text("Actual Departure: " + formatTime(flight.actualDeparture), textX, y + 200);
      text("Scheduled Arrival: " + formatTime(flight.scheduledArrival), textX, y + 225);
      text("Actual Arrival: " + formatTime(flight.actualArrival), textX, y + 250);
      text("Distance: " + flight.distance + " miles", textX, y + 275);
      if (flight.isCancelled)
      {
        text("Flight has been cancelled", textX, y + 300);
      }
      else if (flight.isDiverted)
      {
        text("Flight has been diverted", textX, y + 300);
      }
    }
    else
    {
      text("No flights matching your criteria", textX, y);
    }
  }

  public void mouseClicked(int x, int y)
  {
    if (contains(x, y))
    {
      step(1);
    }
  }

  public void keyPressed(int keyPressed, int keyCodePressed)
  {
    if (keyPressed == CODED && keyCodePressed == LEFT)
    {
      step(-1);
    }
    else if (keyPressed == CODED && keyCodePressed == RIGHT)
    {
      step(1);
    }
  }
}
