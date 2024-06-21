class IssuesDataView extends DataView
{
  private Flights.Statistics flightStats;

  public IssuesDataView(Flights flights, int x, int y, int w, int h)
  {
    super(flights, x, y, w, h);
  }

  private void drawPiePiece(int offsetX, int offsetY, int size, int begin, int count, int total, color fillColor)
  {
    fill(fillColor);
    arc(x + offsetX + size / 2, y + offsetY + size / 2, size, size, 2 * PI * begin / total - PI / 2, 2 * PI * (begin + count) / total - PI / 2);
  }

  private void drawText(int offsetX, int offsetY)
  {
    fill(0);
    textAlign(LEFT, TOP);
    text("Average flight delay: " + round(flightStats.avgDelay) + " mins", x + offsetX, y + offsetY);
    text("Average flight distance: " + round(flightStats.avgDistance) + " miles", x + offsetX, y + offsetY + 25);
    text("Total flights: " + flightStats.total, x + offsetX, y + offsetY + 50);
  }

  protected void filterUpdated()
  {
    flightStats = flights.getStatistics(filter);
  }
  
  public void draw()
  {
    noStroke();

    // Text
    drawText(15, 15);

    if (flightStats.total > 0)
    {
      // Delayed flights pie chart
      textAlign(LEFT, TOP);
      drawPiePiece(15, 150, 200, 0, flightStats.delayed, flightStats.total, #F80000);
      text("Delayed flights (" + flightStats.delayed + ")", x + 25, y + 360);
      drawPiePiece(15, 150, 200, flightStats.delayed, flightStats.total - flightStats.delayed, flightStats.total, #00EE00);
      text("Flights on time ("+ (flightStats.total - flightStats.delayed) + ")", x + 25, y + 380);
      
      
      // Diverted flights pie chart
      int divertedOrCancelled = flightStats.diverted + flightStats.cancelled;
      int normalFlights = flightStats.total - divertedOrCancelled;
      drawPiePiece(300, 150, 200, 0, flightStats.diverted, flightStats.total, #F80000);
      text("Diverted flights (" + flightStats.diverted + ")", x + 320, y + 360);
      drawPiePiece(300, 150, 200, flightStats.diverted, flightStats.cancelled, flightStats.total, #0000FF);
      text("Cancelled flights (" + flightStats.cancelled + ")", x + 320, y + 380);
      drawPiePiece(300, 150, 200, divertedOrCancelled, normalFlights, flightStats.total, #00EE00);
      text("Regular flights (" + normalFlights + ")", x + 320, y + 400);
    }
  }
}
