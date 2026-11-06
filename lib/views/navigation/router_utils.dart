import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

typedef GoToLocation = void Function(String location);
typedef GoVoidCallback = void Function();

extension RouterUtils on BuildContext {
  GoToLocation get go {
    final GoRouter r = GoRouter.of(this);
    return (String location) {
      r.go(location);
    };
  }

  GoVoidCallback get pop {
    final GoRouter r = GoRouter.of(this);
    return () {
      r.pop();
    };
  }

  GoToLocation get push {
    final GoRouter r = GoRouter.of(this);
    return (String location) {
      r.push(location);
    };
  }

  @Deprecated('Avoid Using `pushReplacement`, use `go` instead')
  GoToLocation get pushReplacement {
    final GoRouter r = GoRouter.of(this);
    return (String location) {
      r.pushReplacement(location);
    };
  }
}
