import 'package:flutter_test/flutter_test.dart';

import 'package:rtt/rtt.dart';

void main() {
  test('Find trips', () {
    suggestTrip(tripRequest, todayWithTime(19, 30)).toList();
  });
}
