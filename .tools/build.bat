@echo off

pushd sealed_example || exit
echo NOTE sealed_example
call dart run build_runner build --delete-conflicting-outputs
popd || exit

pushd super_enum_sealed_example || exit
echo NOTE super_enum_sealed_example
call dart run build_runner build --delete-conflicting-outputs
popd || exit
