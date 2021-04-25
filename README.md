# Dart Sealed Class Generator

[![build](https://img.shields.io/github/workflow/status/6thsolution/dart_sealed/Dart?label=build)](https://github.com/6thsolution/dart_sealed/actions/workflows/dart.yml)
[![build](https://img.shields.io/codecov/c/gh/6thsolution/dart_sealed?label=coverage)](https://codecov.io/gh/6thsolution/dart_sealed)
[![pub](https://img.shields.io/pub/v/sealed_generators.svg?color=blue&label=sealed_generators)](https://pub.dev/packages/sealed_generators)
[![pub](https://img.shields.io/pub/v/sealed_annotations.svg?color=blue&label=sealed_annotations)](https://pub.dev/packages/sealed_annotations)
[![pub](https://img.shields.io/pub/v/sealed_super_enum_mapper.svg?color=blue&label=sealed_super_enum_mapper)](https://pub.dev/packages/sealed_super_enum_mapper)

Generate sealed class hierarchy for Dart and Flutter, For null-safe and legacy projects.

## Features

* Generate sealed class with abstract super type and data sub classes.
* Static factory methods. for example `Result.success(data: 0)`.
* Cast methods. for example `a.asSuccess`, `a.isSuccess` or `a.isSuccessOrNull`.
* Three types of equality and hashCode generation : data (like kotlin data classes), identity and distinct.
* Implement data equality with popular equatable library.
* Support for generics. even types can be mixed.
* Support for nullable and non-nullable types in null-safe projects.
* Support for using one sealed type in another.
* Support both legacy and null-safe projects.
* Generate nullability comments for legacy projects to ease your migration.
* Generate toString for data classes.
* Generate 9 types of different matching methods. like `when` or `whenOrElse`.

## Usage

Add dependencies in your `pubspec.yaml` file.

```yaml
dependencies:
  sealed_annotations: ^latest.version

dev_dependencies:
  sealed_generators: ^latest.version
```

Import `sealed_annotations`.

```dart
import 'package:sealed_annotations/sealed_annotations.dart';
```

Add `part` pointing to a file which you want classes be generated in. with `.super.dart` extension.

```dart
part 'weather.sealed.dart';
```

Add `@Sealed` annotation, and an abstract private class as a manifest for generated code.

You can choose between three types of equality using `equality` parameter of `@Sealed(equality: Equality.*)`
annotations. Default equality is `data`.

* `data` Equality is implemented with Equatable package. It behaves like kotlin data classes.
* `identity` Only identical instances are equal. It's like when you don't implement any specific equality.
* `distinct` All the instances are not equal with each other. Even an instance is not equal with itself.

```dart
@Sealed()
abstract class _Weather {
  void sunny();

  void rainy(int rain);

  void windy(double velocity, double? angle);
}
```

Note that you can have nullable and non-nullable fields. In legacy projects all fields are considered nullable.

Then run the following command to generate code for you.

```bash
dart run build_runner build
```

The generated code will look like: (the following code is summarised)

```dart
abstract class Weather {
  static WeatherRainy rainy({required int rain}) =>
      WeatherRainy(rain: rain);

  bool isRainy() => this is WeatherRainy;

  WeatherRainy asRainy() => this as WeatherRainy;

  WeatherRainy? asRainyOrNull() {
    /* ... */
  }

  /* ... */

  R when<R extends Object?>({
    required R Function(WeatherSunny sunny) sunny,
    required R Function(WeatherRainy rainy) rainy,
    required R Function(WeatherWindy windy) windy,
  }) {
    /* ... */
  }

  R whenOrElse<R extends Object?>({
    R Function(WeatherSunny sunny)? sunny,
    R Function(WeatherRainy rainy)? rainy,
    R Function(WeatherWindy windy)? windy,
    required R Function(Weather weather) orElse,
  }) {
    /* ... */
  }

  R whenOrDefault<R extends Object?>({
    R Function(WeatherSunny sunny)? sunny,
    R Function(WeatherRainy rainy)? rainy,
    R Function(WeatherWindy windy)? windy,
    required R orDefault,
  }) {
    /* ... */
  }

  R? whenOrNull<R extends Object?>({
    R Function(WeatherSunny sunny)? sunny,
    R Function(WeatherRainy rainy)? rainy,
    R Function(WeatherWindy windy)? windy,
  }) {
    /* ... */
  }

  R whenOrThrow<R extends Object?>({
    R Function(WeatherSunny sunny)? sunny,
    R Function(WeatherRainy rainy)? rainy,
    R Function(WeatherWindy windy)? windy,
  }) {
    /* ... */
  }

  void branch({
    required void Function(WeatherSunny sunny) sunny,
    required void Function(WeatherRainy rainy) rainy,
    required void Function(WeatherWindy windy) windy,
  }) {
    /* ... */
  }

  void branchPartial({
    void Function(WeatherSunny sunny)? sunny,
    void Function(WeatherRainy rainy)? rainy,
    void Function(WeatherWindy windy)? windy,
  }) {
    /* ... */
  }

  void branchOrElse({
    void Function(WeatherSunny sunny)? sunny,
    void Function(WeatherRainy rainy)? rainy,
    void Function(WeatherWindy windy)? windy,
    required void Function(Weather weather) orElse,
  }) {
    /* ... */
  }

  void branchOrThrow({
    void Function(WeatherSunny sunny)? sunny,
    void Function(WeatherRainy rainy)? rainy,
    void Function(WeatherWindy windy)? windy,
  }) {
    /* ... */
  }
}

class WeatherSunny extends Weather {
  /* ... */
}

class WeatherRainy extends Weather with EquatableMixin {
  WeatherRainy({required this.rain});

  final int rain;

  WeatherRainy copy({int? rain}) =>
      WeatherRainy(rain: rain ?? this.rain);

  @override
  String toString() => 'Weather.rainy(rain: $rain)';

  @override
  List<Object?> get props => [rain];
}

class WeatherWindy extends Weather {
  /* ... */
}
```

## Generic Usage

For generic sealed classes you should write manifest class like a generic class which you are implementing.

It is recommended that if you want nullable generic fields, declare a generic parameter as `T extends Base?` and use `T`
without nullability suffix. If you want non-nullable generic fields declare a generic parameter as `T extends Base` and
use `T` without nullability suffix. If you don't specify upper bound it will default to `Object?` so your generic types
will be nullable.

```dart
import 'package:sealed_annotations/sealed_annotations.dart';

part 'result.sealed.dart';

@Sealed()
abstract class _Result<D extends num> {
  void success(D data);

  void error(Object exception);
}
```

Or you can have multiple generic types and even mix them.

```dart
import 'package:sealed_annotations/sealed_annotations.dart';

part 'result.sealed.dart';

@Sealed()
abstract class _Result<D extends num, E extends Object> {
  void success(D data);

  void error(E exception);

  void mixed(D data, E exception);
}
```

## Changing sub class name and equality

All sub classes have equality same as manifest equality, and their generated class name by default is concatenation of
manifest name and method name. You can change these by using `@Meta` annotation.

For example:

```dart
@Sealed(equality: Equality.data)
abstract class _Weather {
  @Meta(name: 'BestWeather')
  void sunny();

  @Meta(equality: Equality.identity)
  void rainy(int rain);

  @Meta(name: 'WorstWeather', equality: Equality.distinct)
  void windy(double velocity, double? angle);
}
```

## Using one sealed type in another

Consider you have a sealed result type like:

```dart
@Sealed()
abstract class _Result<D extends Object> {
  /* ... */
}
```

You want to use this type in another sealed type.

```dart
@Sealed()
abstract class _WeatherInfo {
  void fromInternet(Result<WeatherData> result);
}
```

If you generate for `WeatherInfo` you will see that result has `dynamic` type. It is because `Result` itself is not code
generated at build time.

You should use `@WithType` annotation.

```dart
@Sealed()
abstract class _WeatherInfo {
  void fromInternet(@WithType('Result<WeatherData>') result);

  // you can also have nullable types.
  void nullable(@WithType('Result<WeatherData>?') result);
}
```

## Mapping super_enum

If you were using super_enum and now you want to change your dependency to dart_sealed.

* 1 Add dependency to `sealed_annotations` near your dependency of `super_enum`.
* 2 Change dependency of `super_enum_generator` to `sealed_super_enum_mapper`.
* 3 Add import to `sealed_annotations` near imports of `super_enum`.
* 4 Run `dart run build_runner build`.
* 5 Now instead of super_enum, sealed_generators will generate code for you in `.super` files. Apart from generated
  sealed classes a manifest class with `@Sealed` annotation, and the same name of your enum and a trailing `$` will be
  generated.
* 6 Replace generated manifest class with `@Sealed` annotation with your `@super_enum` annotated enum. omit trailing `$`
  and class comments. This tool does not recognize `required` and all fields are considered nullable. If your project is
  null-safe start changing nullability of each field according to your needs. If your sealed class is generic
  change `Generic` type argument name and if it is needed use multiple type arguments.
* 7 Remove dependency to `super_enum`.
* 8 Change dependency of `sealed_super_enum_mapper` to `sealed_generators`.
* 9 Change `part` suffixes from `.super` to `.sealed`.
* 10 Run `dart run build_runner build`.
* 11 Remove `.super` files if it is not removed automatically.
* Optional: 12 If you want to migrate your code to null-safety you should do it now. Then
  run `dart run build_runner build` again and this library will handle it for you.

For example for:

```
@superEnum
enum _Weather {
  @object
  Sunny,
  @Data(fields: [
    DataField<int>('rain'),
  ])
  Rainy,
  @Data(fields: [
    DataField<double>('velocity'),
    DataField<double>('angle'),
  ])
  Windy,
}
```

It will generate sealed classes and the following manifest class.

```dart
@Sealed()
abstract class _Weather$ {
  @Meta(name: 'Sunny', equality: Equality.data)
  void sunny();

  @Meta(name: 'Rainy', equality: Equality.data)
  void rainy(int? rain);

  @Meta(name: 'Windy', equality: Equality.data)
  void windy(double? velocity, double? angle);
}
```

It is better to try not to use `@Meta` annotations.

## Migrating to null-safety

Using library for legacy projects it will generate legacy code assuming all fields being nullable. It also adds
nullability comments for easing migration.

For migration use standard migration tool. Change nullability of sealed class fields (which is mapped from method
arguments of manifest class) according to your needs. run `dart run build_runner build` again and library will generate
null-safe code for you.
