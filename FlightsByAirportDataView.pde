class FlightsByAirportDataView extends BarChartDataView
{
  private FlightCount[] airports = {};
  private static final int MAX_AIRPORTS = 160;
  private int sumOfRest = 0;

  public FlightsByAirportDataView(Flights flights, int x, int y, int w, int h)
  {
    super(flights, x, y, w, h);
  }

  protected void filterUpdated()
  {
    airports = flights.getSortedAirports(filter);
    
    sumOfRest = 0;
    for (int i = MAX_AIRPORTS, len = airports.length; i < len; ++i)
    {
        sumOfRest += airports[i].count;
    }
    
    super.filterUpdated();
  }
  
  protected int getBarCount()
  {
    return min(airports.length, MAX_AIRPORTS + 1);
  }

  protected int getBarValue(int i)
  {
    return i < MAX_AIRPORTS ? airports[i].count : sumOfRest;
  }

  protected String getBarLabel(int i)
  {
    return "";
  }

  protected String getBarDescription(int i)
  {
    if (i < MAX_AIRPORTS)
    {
        int ratio = (int)(10000L * airports[i].count / flights.size());
        return airports[i].category + "\n" + ratio / 100 + "." + ratio % 100 + "% of all flights";
    }
    else
    {
        int ratio = (int)(10000L * sumOfRest / flights.size());
        return "Other" + "\n" + ratio / 100 + "." + ratio % 100 + "% of all flights";
    }
  }
}
