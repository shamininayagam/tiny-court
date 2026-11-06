import 'environment.dart';

class StageEnvironment extends Environment {
  StageEnvironment() : super.public() {
    Environment.env = this;
  }

  @override
  EnvironmentType get type => EnvironmentType.stage;
}
