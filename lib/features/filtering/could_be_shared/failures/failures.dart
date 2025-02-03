abstract class Failures {
  final String message;

  Failures({required this.message});

}
class ServerFailure extends Failures {
  ServerFailure({required super.message});
}

class CacheFailure extends Failures {
  CacheFailure({required super.message});
}

class NetworkFailure extends Failures {
  NetworkFailure({required super.message});
} 
