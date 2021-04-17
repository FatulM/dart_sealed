import 'package:sealed_generators/src/options/options.dart';
import 'package:sealed_generators/src/source/writer/backward/backward_writer.dart';
import 'package:test/test.dart';

import '../../../../utils/examples.dart';

void main() {
  group('class BackwardWriter', () {
    test('initialization', () {
      final source = source1DataSafe;
      final writer = BackwardWriter(source);

      expect(writer.source, source);
    });

    group('method write', () {
      test('data equality', () {
        final source = source1DataSafe;
        final writer = BackwardWriter(source);

        expect(writer.write(), code1Data);
      });

      test('identity equality', () {
        final source = source1IdentitySafe;
        final writer = BackwardWriter(source);

        expect(writer.write(), code1Identity);
      });

      test('distinct equality', () {
        final source = source1DistinctSafe;
        final writer = BackwardWriter(source);

        expect(writer.write(), code1Distinct);
      });

      test('data equality generic', () {
        final source = source2DataSafe;
        final writer = BackwardWriter(source);

        expect(writer.write(), code2Data);
      });
    });

    test('constant equalityNames', () {
      // should have same order
      expect(
        BackwardWriter.equalityNames.map((e) => 'Equality.$e').toList(),
        Equality.values.map((e) => '$e').toList(),
      );
    });
  });
}
