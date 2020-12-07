import 'package:mockito/mockito.dart' as _i1;
import 'package:flutter/src/widgets/navigator.dart' as _i2;

/// A class which mocks [NavigatorObserver].
///
/// See the documentation for Mockito's code generation for more information.
class MockNavigatorObserver extends _i1.Mock implements _i2.NavigatorObserver {
  MockNavigatorObserver() {
    _i1.throwOnMissingStub(this);
  }

  void didPush(_i2.Route<dynamic>? route, _i2.Route<dynamic>? previousRoute) =>
      super.noSuchMethod(Invocation.method(#didPush, [route, previousRoute]));
  void didPop(_i2.Route<dynamic>? route, _i2.Route<dynamic>? previousRoute) =>
      super.noSuchMethod(Invocation.method(#didPop, [route, previousRoute]));
  void didRemove(
          _i2.Route<dynamic>? route, _i2.Route<dynamic>? previousRoute) =>
      super.noSuchMethod(Invocation.method(#didRemove, [route, previousRoute]));
  void didStartUserGesture(
          _i2.Route<dynamic>? route, _i2.Route<dynamic>? previousRoute) =>
      super.noSuchMethod(
          Invocation.method(#didStartUserGesture, [route, previousRoute]));
}
