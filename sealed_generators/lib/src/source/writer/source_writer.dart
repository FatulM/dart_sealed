import 'package:meta/meta.dart';
import 'package:sealed_generators/src/source/source.dart';
import 'package:sealed_generators/src/source/writer/base/base_writer.dart';
import 'package:sealed_generators/src/source/writer/sub/sub_writer.dart';
import 'package:sealed_generators/src/source/writer/top/top_writer.dart';
import 'package:sealed_generators/src/utils/string_utils.dart';

/// source writer
///
/// NOTE: writer phase is completely disjoint from
/// reader phase. if for example reader decides to
/// change types to non null by default for legacy
/// projects, writer will do good without any modification.
/// Except for knowing about target source options.isNullsafe
/// should NOT be used in writer. by now it is used
/// only in getters {n, nn, nl, req} and for checking
/// if it is needed to put asserts.
@sealed
@immutable
class SourceWriter extends BaseWriter {
  SourceWriter(Source source)
      : topWriter = TopWriter(source),
        subWriter = SubWriter(source),
        super(source);

  @nonVirtual
  @visibleForTesting
  final TopWriter topWriter;

  @nonVirtual
  @visibleForTesting
  final SubWriter subWriter;

  @protected
  @nonVirtual
  @visibleForTesting
  Iterable<String> classes() => [
        topWriter.topClass(),
        ...subWriter.subClasses(),
      ];

  @nonVirtual
  String write() => classes().joinMethods();
}
