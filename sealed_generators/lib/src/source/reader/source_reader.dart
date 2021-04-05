import 'package:analyzer/dart/element/element.dart';
import 'package:sealed_generators/src/manifest/reader/manifest_reader.dart';
import 'package:sealed_generators/src/options/reader/options_reader.dart';
import 'package:sealed_generators/src/source/source.dart';
import 'package:source_gen/src/constants/reader.dart';

class SourceReader {
  const SourceReader();

  Source read(Element element, ConstantReader annotation) {
    final optionsReader = OptionsReader();
    final options = optionsReader.read(element, annotation);
    final manifestReader = ManifestReader(options: options);
    final manifest = manifestReader.read(element);
    return Source(options: options, manifest: manifest);
  }
}