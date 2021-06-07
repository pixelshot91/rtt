// Mocks generated by Mockito 5.0.9 from annotations
// in rtt/test/algo_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i3;

import 'package:mockito/mockito.dart' as _i1;
import 'package:rtt/rtapi/api.dart' as _i2;
import 'package:rtt/rtt.dart' as _i4;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: comment_references
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeDuration extends _i1.Fake implements Duration {}

/// A class which mocks [RTAPI].
///
/// See the documentation for Mockito's code generation for more information.
class MockRTAPI extends _i1.Mock implements _i2.RTAPI {
  MockRTAPI() {
    _i1.throwOnMissingStub(this);
  }

  @override
  Duration get maxCacheLife =>
      (super.noSuchMethod(Invocation.getter(#maxCacheLife),
          returnValue: _FakeDuration()) as Duration);
  @override
  set maxCacheLife(Duration? _maxCacheLife) =>
      super.noSuchMethod(Invocation.setter(#maxCacheLife, _maxCacheLife),
          returnValueForMissingStub: null);
  @override
  Map<_i2.FindScheduleParam, _i2.CachedSchedules> get scheduleCache =>
      (super.noSuchMethod(Invocation.getter(#scheduleCache),
              returnValue: <_i2.FindScheduleParam, _i2.CachedSchedules>{})
          as Map<_i2.FindScheduleParam, _i2.CachedSchedules>);
  @override
  set scheduleCache(
          Map<_i2.FindScheduleParam, _i2.CachedSchedules>? _scheduleCache) =>
      super.noSuchMethod(Invocation.setter(#scheduleCache, _scheduleCache),
          returnValueForMissingStub: null);
  @override
  _i3.Future<List<_i4.Schedule>> getSchedule(_i4.Transport? transport,
          _i4.Station? station, _i4.Direction? direction) =>
      (super.noSuchMethod(
              Invocation.method(#getSchedule, [transport, station, direction]),
              returnValue: Future<List<_i4.Schedule>>.value(<_i4.Schedule>[]))
          as _i3.Future<List<_i4.Schedule>>);
  @override
  _i3.Future<List<_i4.Schedule>> getScheduleNoCache(_i4.Transport? transport,
          _i4.Station? station, _i4.Direction? direction) =>
      (super.noSuchMethod(
              Invocation.method(
                  #getScheduleNoCache, [transport, station, direction]),
              returnValue: Future<List<_i4.Schedule>>.value(<_i4.Schedule>[]))
          as _i3.Future<List<_i4.Schedule>>);
}
