class TemperatureUtils {
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
