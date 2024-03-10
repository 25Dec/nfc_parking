class ServerException implements Exception {
  final String message;
  ServerException({required this.message});
}

class CacheException implements Exception {
  final String message;
  CacheException({required this.message});
}

class HardwareException implements Exception {
  final String message;
  HardwareException({required this.message});
}
