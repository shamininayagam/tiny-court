import 'environment.dart';

class ProdEnvironment extends Environment {
  ProdEnvironment() : super.public() {
    Environment.env = this;
  }

  @override
  EnvironmentType get type => EnvironmentType.prod;
}
