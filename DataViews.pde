class DataViews
{
  private ArrayList<DataView> dataViews = new ArrayList<DataView>();
  private int currentView = 0;
  private Filter filter = null;
  
  public void setView(int newView)
  {
    currentView = newView;
  }
  
  public int getView()
  {
    return currentView;
  }
  
  public void draw()
  {
    dataViews.get(currentView).draw();
  }

  public void setFilter(Filter filter)
  {
    for (DataView dataView: dataViews)
    {
      dataView.setFilter(filter);
    }
    this.filter = filter;
  }

  public Filter getFilter()
  {
    return filter;
  }

  public void keyPressed(int keyPressed, int keyCodePressed)
  {
    dataViews.get(currentView).keyPressed(keyPressed, keyCodePressed);
  }
  public void mouseClicked(int x, int y)
  {
    dataViews.get(currentView).mouseClicked(x, y);
  }

  public void add(DataView dataView)
  {
    dataViews.add(dataView);
  }
}
