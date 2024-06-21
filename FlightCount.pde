static class FlightCount
{
  public final String category;
  public final int count;
  
  public FlightCount(String category, int count)
  {
    this.category = category;
    this.count = count;
  }
  
  public static void sort(FlightCount[] array)
  {
    FlightCount[] second = new FlightCount[array.length], tmp = null;
    int[] counts = new int[256];
    int[] starts = new int[256];
    
    for (int bit = 0, len = array.length; bit < 32; bit += 8)
    {
      for (int i = 0; i < len; ++i)
      {
        ++counts[(array[i].count >>> bit) & 255];
      }
      starts[255] = 0;
      for (int i = 255; i > 0; --i)
      {
        starts[i - 1] = starts[i] + counts[i];
        counts[i] = 0;
      }
      counts[255] = 0;
      for (int i = 0; i < len; ++i)
      {
        int key = (array[i].count >>> bit) & 255;
        second[starts[key]] = array[i];
        ++starts[key];
      }
      tmp = second;
      second = array;
      array = tmp;
    }
  }
}
