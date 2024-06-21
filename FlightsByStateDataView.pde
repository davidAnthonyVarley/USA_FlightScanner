class FlightsByStateDataView extends BarChartDataView
{
  private FlightCount[] stateFlightData = {};

  public FlightsByStateDataView(Flights flights, int x, int y, int w, int h)
  {
    super(flights, x, y, w, h);
  }

  protected void filterUpdated()
  {
    stateFlightData = flights.getFlightsByStates(filter);
    super.filterUpdated();
  }
  
  protected int getBarCount()
  {
    return stateFlightData.length;
  }

  protected int getBarValue(int i)
  {
    return stateFlightData[i].count;
  }

  protected String getBarLabel(int i)
  {
    return stateFlightData[i].category;
  }

  protected String getBarDescription(int i)
  {
    return stateFlightData[i].category;
  }
}
