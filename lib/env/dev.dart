import 'environment.dart';

class DevEnvironment extends Environment {
  DevEnvironment() : super.public() {
    Environment.env = this;
  }

  @override
  EnvironmentType get type => EnvironmentType.dev;
}
