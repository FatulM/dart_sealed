@echo off

echo HEADER format

pushd sealed_annotations || exit 1
echo NOTE sealed_annotations
call dart format lib test
popd || exit 1

pushd sealed_writer || exit 1
echo NOTE sealed_writer
call dart format lib test
popd || exit 1

pushd sealed_generators || exit 1
echo NOTE sealed_generators
call dart format lib test
popd || exit 1

pushd example || exit 1
echo NOTE example
call dart format test
popd || exit 1
