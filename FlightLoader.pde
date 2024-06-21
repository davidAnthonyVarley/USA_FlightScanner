import java.io.FileInputStream;

class FlightLoader
{
  private String filepath;
  private byte[] buffer = null;
  private int i = 0, len = 0;
  
  public FlightLoader(String filepath)
  {
    this.filepath = filepath;
  }

  private int nextInt()
  {
    int result = 0;
    while (i < len && buffer[i] != -1)
    {
      result = result << 7 | buffer[i];
      ++i;
    }
    ++i;
    return result;
  }

  private int nextTime()
  {
    int result = buffer[i] << 7 | buffer[i + 1];
    i += 2;
    return result;
  }

  private int nextDate()
  {
    int result = buffer[i] << 14 | buffer[i + 1] << 7 | buffer[i + 2];
    i += 3;
    return result;
  }

  private byte nextByte()
  {
    byte result = buffer[i];
    ++i;
    return result;
  }
    
  private String nextString()
  {
    int begin = i;
    while (i < len && buffer[i] != -1)
    {
      ++i;
    }
    ++i;
    return new String(buffer, 0, begin, i - begin - 1);
  }
    
  public Flights load()
  {
    int m = millis();
    int lineCount = 0;
    try (FileInputStream reader = new FileInputStream(filepath))
    {
      byte[] tmp = new byte[10];
      reader.read(tmp);
      len = tmp[0] << 28 | tmp[1] << 21 | tmp[2] << 14 | tmp[3] << 7 | tmp[4];
      lineCount = tmp[5] << 28 | tmp[6] << 21 | tmp[7] << 14 | tmp[8] << 7 | tmp[9];
      buffer = new byte[len];
      reader.read(buffer);
    }
    catch (Exception exc) {}
    println("reading file:", millis() - m);
    m = millis();
    
    var flights = new Flight[lineCount];
    
    int flightDate;
    String carrierCode;
    int flightNumber;
    String originAirportCode, originCityName;
    byte originStateCode;
    String destinationAirportCode, destinationCityName;
    byte destinationStateCode;
    int scheduledDeparture, actualDeparture, scheduledArrival, actualArrival;
    boolean isCancelled, isDiverted;
    int distance;

    for (int line = 0; i < len; ++line)
    {
      flightDate = nextDate();
      carrierCode = nextString();
      flightNumber = nextInt();
      originAirportCode = nextString();
      originCityName = nextString();
      originStateCode = nextByte();
      destinationAirportCode = nextString();
      destinationCityName = nextString();
      destinationStateCode = nextByte();
      scheduledDeparture = nextTime();
      actualDeparture = nextTime();
      scheduledArrival = nextTime();
      actualArrival = nextTime();
      isCancelled = nextByte() == '1';
      isDiverted = nextByte() == '1';
      distance = nextInt();

      flights[line] = new Flight(
        flightDate, carrierCode, flightNumber, originAirportCode, originCityName, originStateCode,
        destinationAirportCode, destinationCityName, destinationStateCode,
        scheduledDeparture, actualDeparture, scheduledArrival, actualArrival, isCancelled, isDiverted, distance
      );
    }
    println("parsing file:", millis() - m);
    return new Flights(flights);
  }
}
