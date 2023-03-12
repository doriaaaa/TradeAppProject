abstract class Constants {
  static const String ipAddr = String.fromEnvironment(
    'IP_ADDR',
    defaultValue: '172.20.10.4'
  );
}