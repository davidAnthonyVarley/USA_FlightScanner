abstract class DataView
{
  protected final Flights flights;
  protected final int x, y, w, h;
  protected Filter filter;

  public DataView(Flights flights, int x, int y, int w, int h)
  {
    this.flights = flights;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.filter = new Filter();
  }

  public boolean contains(int posX, int posY)
  {
    return x <= posX && posX <= x + w && y <= posY && posY <= y + h;
  }

  public abstract void draw();

  public final void setFilter(Filter newFilter) 
  {
    if (!filter.equals(newFilter))
    {
      filter = newFilter;
      this.filterUpdated();
    }
  }

  protected void filterUpdated() {}
  public void keyPressed(int keyPressed, int keyCodePressed) {}
  public void mouseClicked(int x, int y) {}
}
