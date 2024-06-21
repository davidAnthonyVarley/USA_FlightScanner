class DatePicker
{
  private final int minimum, maximum, range;
  private int begin, end;
  private String beginStr, endStr;
  private final int x, y, w, h;

  public DatePicker(int minimum, int maximum, int x, int y, int w, int h)
  {
    this.minimum = minimum;
    this.maximum = maximum;
    range = maximum - minimum;
    begin = minimum;
    end = maximum;
    beginStr = Date.format(minimum);
    endStr = Date.format(maximum);
    
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
  
  private int dateToPos(int days)
  {
    return round(x + w * float(days - minimum) / range);
  }
  
  private int posToDate(int pos)
  {
    return round(minimum + range * float(pos - x) / w);
  }

  public int beginDate()
  {
    return begin;
  }

  public int endDate()
  {
    return end;
  }

  public void draw()
  {
    noStroke();
    int from = dateToPos(begin);
    int to = dateToPos(end);

    fill(#707070);
    rect(x, y, from - x, 9);
    rect(to, y, x + w - to, 9);

    fill(#0080FF);
    rect(from, y, to - from, 9);

    fill(0);
    textAlign(LEFT, TOP);
    text(beginStr, x, y + 9, w, h - 9);
    textAlign(RIGHT, TOP);
    text(endStr, x, y + 9, w, h - 9);
  }
  
  public void mousePressed(int posX, int posY)
  {
    if (posX > x && posX < x + w && posY > y && posY < y + h)
    {
      int date = min(maximum, max(minimum, posToDate(posX)));
      String dateStr = Date.format(date);
      
      if (abs(date - begin) < abs(date - end))
      {
        begin = date;
        beginStr = dateStr;
      }
      else
      {
        end = date;
        endStr = dateStr;
      }
    }
  }
}
