Map map;
Menu menu;
DataViews dataViews;
TextInput textInput;
DatePicker datePicker;
AirportPicker airportPicker;

int m;
void settings()
{
  m = millis();
  size(SCREEN_WIDTH, SCREEN_HEIGHT);
}

void setup()
{
  // Arial, 16 point, anti-aliasing on
  textFont(createFont("Arial", 16, true));
  size(SCREEN_WIDTH, SCREEN_HEIGHT);
  
  Flights flights = new FlightLoader(dataPath("flights_lines.txt")).load();
  
  println(millis() - m, "ms");

  map = new Map("usa.svg", 0, 0, MAP_WIDTH, MAP_HEIGHT, flights);
  airportPicker = new AirportPicker(MAP_WIDTH, MAP_HEIGHT, round(SCREEN_HEIGHT / 20 * 0.15), flights);

  textInput = new TextInput(SCREEN_WIDTH - 245, 0, 240, MENU_HEIGHT, "City: ", "City: ", "Carrier code: ", "Carrier code: ");
  datePicker = new DatePicker(flights.getMinDate(), flights.getMaxDate(), MAP_WIDTH + MENU_WIDTH + 20, 0, DATEPICKER_WIDTH, MENU_HEIGHT);
  
  // The menu for switching between displayed content in DataViews
  menu = new Menu(MAP_WIDTH, 0, MENU_WIDTH, MENU_HEIGHT, "Flight info", "Airport issues", "Flights by state", "Flights by airport");
  
  println(millis() - m, "ms");
  // The DataViews showing various information, statistics, etc.
  dataViews = new DataViews();
  dataViews.add(new TextInfoDataView(flights, MAP_WIDTH, MENU_HEIGHT, DATAVIEW_WIDTH, DATAVIEW_HEIGHT));
  dataViews.add(new IssuesDataView(flights, MAP_WIDTH, MENU_HEIGHT, DATAVIEW_WIDTH, DATAVIEW_HEIGHT));
  dataViews.add(new FlightsByStateDataView(flights, MAP_WIDTH, MENU_HEIGHT, DATAVIEW_WIDTH, DATAVIEW_HEIGHT));
  dataViews.add(new FlightsByAirportDataView(flights, MAP_WIDTH, MENU_HEIGHT, DATAVIEW_WIDTH, DATAVIEW_HEIGHT));
  
  updateFilter();

  println(millis() - m, "ms");
}

void draw()
{
  background(255, 255, 180);
  map.draw();
  textInput.draw();
  datePicker.draw();
  dataViews.draw();
  menu.draw();
  airportPicker.draw();

  if (mousePressed)
  {
    datePicker.mousePressed(mouseX, mouseY);
  }
}

void mousePressed()
{
  if (menu.mouseClicked(mouseX, mouseY))
  {
    dataViews.setView(menu.getSelected());
    textInput.selectLabel(menu.getSelected());
  }
  else
  {
    dataViews.mouseClicked(mouseX, mouseY);
  }
}

void updateFilter()
{
  if (menu.getSelected() >= 2)
  {
    dataViews.setFilter(new Filter(textInput.getText(), "", airportPicker.getDeparture(), airportPicker.getArrival(), datePicker.beginDate(), datePicker.endDate()));
  }
  else
  {
    dataViews.setFilter(new Filter("", textInput.getText(), airportPicker.getDeparture(), airportPicker.getArrival(), datePicker.beginDate(), datePicker.endDate()));
  }
  airportPicker.setFilter(dataViews.getFilter());
}

void keyPressed()
{
  textInput.keyPressed(key, keyCode);
  dataViews.keyPressed(key, keyCode);
  thread("updateFilter");
}

void mouseReleased()
{
  airportPicker.mouseClick(mouseX, mouseY);
  updateFilter();
}
