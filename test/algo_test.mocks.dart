// Mocks generated by Mockito 5.0.9 from annotations
// in rtt/test/algo_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:localstorage/localstorage.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:rtt/rtapi/api.dart' as _i3;
import 'package:rtt/rtt.dart' as _i5;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: comment_references
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeDuration extends _i1.Fake implements Duration {}

class _FakeLocalStorage extends _i1.Fake implements _i2.LocalStorage {}

/// A class which mocks [RTAPI].
///
/// See the documentation for Mockito's code generation for more information.
class MockRTAPI extends _i1.Mock implements _i3.RTAPI {
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
  Map<_i3.FindScheduleParam, _i3.CachedSchedules> get scheduleCache =>
      (super.noSuchMethod(Invocation.getter(#scheduleCache),
              returnValue: <_i3.FindScheduleParam, _i3.CachedSchedules>{})
          as Map<_i3.FindScheduleParam, _i3.CachedSchedules>);
  @override
  set scheduleCache(
          Map<_i3.FindScheduleParam, _i3.CachedSchedules>? _scheduleCache) =>
      super.noSuchMethod(Invocation.setter(#scheduleCache, _scheduleCache),
          returnValueForMissingStub: null);
  @override
  _i2.LocalStorage get storage =>
      (super.noSuchMethod(Invocation.getter(#storage),
          returnValue: _FakeLocalStorage()) as _i2.LocalStorage);
  @override
  _i4.Future<List<_i5.Schedule>> getSchedule(_i5.Transport? transport,
          _i5.Station? station, _i5.Direction? direction) =>
      (super.noSuchMethod(
              Invocation.method(#getSchedule, [transport, station, direction]),
              returnValue: Future<List<_i5.Schedule>>.value(<_i5.Schedule>[]))
          as _i4.Future<List<_i5.Schedule>>);
  @override
  _i4.Future<List<_i5.Station>> getStationsOfLine(
          _i5.Transport? transport, _i5.Direction? direction) =>
      (super.noSuchMethod(
              Invocation.method(#getStationsOfLine, [transport, direction]),
              returnValue: Future<List<_i5.Station>>.value(<_i5.Station>[]))
          as _i4.Future<List<_i5.Station>>);
  @override
  _i4.Future<List<_i5.Station>> getStationsOfLineNoCache(
          _i5.Transport? transport) =>
      (super.noSuchMethod(
              Invocation.method(#getStationsOfLineNoCache, [transport]),
              returnValue: Future<List<_i5.Station>>.value(<_i5.Station>[]))
          as _i4.Future<List<_i5.Station>>);
  @override
  _i4.Future<bool> doesMissionStopAt(_i5.RERSchedule? s, _i5.Station? to) =>
      (super.noSuchMethod(Invocation.method(#doesMissionStopAt, [s, to]),
          returnValue: Future<bool>.value(false)) as _i4.Future<bool>);
  @override
  _i4.Future<List<_i5.Station>> getStationsServedByMission(
          _i5.RERSchedule? s) =>
      (super.noSuchMethod(Invocation.method(#getStationsServedByMission, [s]),
              returnValue: Future<List<_i5.Station>>.value(<_i5.Station>[]))
          as _i4.Future<List<_i5.Station>>);
  @override
  _i4.Future<List<_i5.Station>> getStationsServedByMissionNoCache(
          _i5.RERSchedule? s) =>
      (super.noSuchMethod(
              Invocation.method(#getStationsServedByMissionNoCache, [s]),
              returnValue: Future<List<_i5.Station>>.value(<_i5.Station>[]))
          as _i4.Future<List<_i5.Station>>);
  @override
  _i4.Future<List<_i5.Schedule>> getScheduleNoCache(_i5.Transport? transport,
          _i5.Station? station, _i5.Direction? direction) =>
      (super.noSuchMethod(
              Invocation.method(
                  #getScheduleNoCache, [transport, station, direction]),
              returnValue: Future<List<_i5.Schedule>>.value(<_i5.Schedule>[]))
          as _i4.Future<List<_i5.Schedule>>);
}
