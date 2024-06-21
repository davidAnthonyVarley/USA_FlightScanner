static class Date
{
  private static int yearStart(int year)
  {
    year -= 1;
    int leap_years = year / 4 - year / 100 + year / 400;
    return 365 * year + leap_years;
  }

  private static int monthStart(int year, int month)
  {
    int leap = year % 4 == 0 && (year % 100 != 0 || year % 400 == 0) ? 1 : 0;
    switch (month)
    {
      case 1:
        return 0;
      case 2:
        return 31;
      case 3:
        return 59 + leap;
      case 4:
        return 90 + leap;
      case 5:
        return 120 + leap;
      case 6:
        return 151 + leap;
      case 7:
        return 181 + leap;
      case 8:
        return 212 + leap;
      case 9:
        return 243 + leap;
      case 10:
        return 273 + leap;
      case 11:
        return 304 + leap;
      default:
        return 334 + leap;
    }
  }

  public static String format(int days)
  {
    int year = days / 366 + 1;
    while (days >= yearStart(year + 1))
    {
      ++year;
    }
    days -= yearStart(year);
    int month = days / 31 + 1;
    while (days >= monthStart(year, month + 1))
    {
      ++month;
    }
    days -= monthStart(year, month);
    return String.format("%04d-%02d-%02d", year, month, days + 1);
  }
}
