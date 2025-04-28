class TemperatureUtils {
  // ignore: lines_longer_than_80_chars
  // TODO(Baran): Add UserPrefs to the constructor to get the user's preferred measurement system.
  static double? kelvinToCelsius(double? kelvin) {
    if (kelvin == null) {
      return null;
    }
    return kelvin - 273.15;
  }

  static double? kelvinToFahrenheit(double? kelvin) {
    if (kelvin == null) {
      return null;
    }
    return (kelvin - 273.15) * 9 / 5 + 32;
  }
}
