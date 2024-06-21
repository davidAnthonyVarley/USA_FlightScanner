# Programming Project - Group 8
The flight data browser project.

Group members:
- Nicolas Moschenross
- Richard Blazek
- Cormac O'Sullivan
- David Varley

## Project structure
- `data/flights_sample.csv` - file with sample flights
- `Button.pde` - class Button for displaying a button which can be clicked
- `CsvParser.pde` - class CsvParser, which parses data stored in the CSV format
- `Flight.pde` - class Flight, which contains data about a single Flight
- `FlightLoader.pde` - class FlightLoader, which uses CsvParser to parse a file and create an ArrayList of Flight objects, containing the information about the flights in the given file
- `main.pde` - the main program (currently just dummy program which loads all flights and prints them)
- `sketch.properties` - a configuration file which tells Processing that the main program is in the file `main.pde`
- `Menu.pde` - class Menu displaying a list of Buttons and providing a function to tell which of them has been clicked
