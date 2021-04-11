import 'package:sealed_generators/src/manifest/reader/override/dyn/reader.dart';
import 'package:test/test.dart';

import '../../../../../utils/examples.dart';

void main() {
  group('class TypeOverrideDynamicReader', () {
    test('initialization', () {
      final options = optionsDataSafe;
      final reader = TypeOverrideDynamicReader(options);
      expect(reader.options, options);
    });

    group('method mapOverride', () {
      test('null-safe', () {
        final options = optionsDataSafe;
        final reader = TypeOverrideDynamicReader(options);

        final o1 = reader.mapOverride('double');
        expect(o1.type.name, equals('double'));
        expect(o1.type.isNullable, isFalse);

        final o2 = reader.mapOverride('double?');
        expect(o2.type.name, equals('double'));
        expect(o2.type.isNullable, isTrue);
      });

      test('legacy', () {
        final options = optionsDataLegacy;
        final reader = TypeOverrideDynamicReader(options);

        final o1 = reader.mapOverride('double');
        expect(o1.type.name, equals('double'));
        // same behaviour in legacy
        expect(o1.type.isNullable, isFalse);

        final o2 = reader.mapOverride('double?');
        expect(o2.type.name, equals('double'));
        expect(o2.type.isNullable, isTrue);
      });
    });
  });
}