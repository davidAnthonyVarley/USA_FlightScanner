class Menu
{
  private int x, y, w, h;
  private String[] options;
  private boolean opened = false;
  private int selected = 0;
  
  public Menu(int x, int y, int w, int h, String ... options)
  {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.options = options;
  }

  public int getSelected()
  {
    return selected;
  }
  
  private boolean inRect(int posX, int posY, int x, int y, int w, int h)
  {
    return x <= posX && posX <= x + w && y <= posY && posY <= y + h;
  }

  public boolean mouseClicked(int clickX, int clickY)
  {
    if (opened)
    {
      opened = false;
      for (int i = 0; i < options.length; ++i)
      {
        if (inRect(mouseX, mouseY, x, y + h * i, w, h))
        {
          selected = i;
          return true;
        }
      }
    }
    else if (inRect(clickX, clickY, x, y, w, h))
    {
      opened = true;
      return true;
    }
    return false;
  }
    
  public void draw()
  {
    if (opened)
    {
      fill(255);
      stroke(128);
      rect(x, y, w, h * options.length);
  
      noStroke();
      textAlign(CENTER, CENTER);
      for (int i = 0; i < options.length; ++i)
      {
        if (inRect(mouseX, mouseY, x, y + h * i, w, h))
        {
          fill(#40B0FF);
          rect(x + 1, y + h * i, w - 1, h);
        }
        fill(0);
        text(options[i], x, y + h * i, w, h);
      }
    }
    else
    {
      fill(inRect(mouseX, mouseY, x, y, w, h) ? #80CCFF : #FFFFFF);
      stroke(128);
      rect(x, y, w, h - 1);
  
      textAlign(CENTER, CENTER);
      fill(0);
      text(options[selected], x, y, w, h);
    }
  }
}
