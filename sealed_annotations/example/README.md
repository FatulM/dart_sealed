# Dart Sealed Class Generator

[![build](https://img.shields.io/github/actions/workflow/status/FatulM/dart_sealed/.github/workflows/dart.yml?branch=master&label=build)](https://github.com/FatulM/dart_sealed/actions/workflows/dart.yml)
[![build](https://img.shields.io/codecov/c/gh/FatulM/dart_sealed?label=coverage)](https://codecov.io/gh/FatulM/dart_sealed)
[![pub](https://img.shields.io/badge/sealed__annotations-v2.0.0-blue)](https://github.com/FatulM/dart_sealed/tree/master/sealed_annotations)
[![pub](https://img.shields.io/badge/sealed__generators-v2.0.0-blue)](https://github.com/FatulM/dart_sealed/tree/master/sealed_generators)
[![version](https://img.shields.io/badge/sealed__writer-v2.0.0-blue)](https://github.com/FatulM/dart_sealed/tree/master/sealed_writer)

Generate sealed class hierarchy for Dart and Flutter.

**NOTE** that this is only a clone of the upstream git repository
which I have fixed some issues and updated some dependencies.

## Features

* Generate sealed class with abstract super type and data subclasses.
* Static factory methods. for example `Result.success(data: 0)`.
* Cast methods. for example `a.asSuccess`, `a.isSuccess` or `a.asSuccessOrNull`.
* Three types of equality and hashCode generation : data (like kotlin data classes), identity and distinct.
* Implement data equality with popular equatable library.
* Support for generics. even types can be mixed.
* Support for nullable and non-nullable types in null-safe projects.
* Support for using one sealed type in another.
* Support for null-safety.
* Generate toString for data classes.
* Generate 6 types of different matching methods. like `when`, `maybeWhen` and `map`.

## Usage

Add dependencies in your `pubspec.yaml` file.

Since this is not the original repository, you can not use like this:

```yaml
# WON'T WORK LIKE THIS:
dependencies:
  sealed_annotations: '2.0.0'

dev_dependencies:
  sealed_generators: '2.0.0'
```

Instead, use like this:

This will override the three dependencies to be downloaded from git.

```yaml
dependencies:
  sealed_annotations: '2.0.0'

dev_dependencies:
  sealed_generators: '2.0.0'

dependency_overrides:
  sealed_annotations:
    git:
      url: https://github.com/FatulM/dart_sealed
      path: sealed_annotations/
  sealed_writer:
    git:
      url: https://github.com/FatulM/dart_sealed
      path: sealed_writer/
  sealed_generators:
    git:
      url: https://github.com/FatulM/dart_sealed
      path: sealed_generators/
```

Import `sealed_annotations`.

```dart
import 'package:sealed_annotations/sealed_annotations.dart';
```

Add `part` pointing to a file which you want classes be generated in. with `.sealed.dart` extension.

```dart
part 'weather.sealed.dart';
```

Add `@Sealed` annotation, and an abstract private class as a manifest for generated code. For example:

```dart
@Sealed()
abstract class _Weather {
  void sunny();

  void rainy(int rain);

  void windy(double velocity, double? angle);
}
```

Then run the following command to generate code for you. If you are developer for flutter:

```bash
flutter pub run build_runner build
```

And if you are developing for pure dart:

```bash
dart run build_runner build
```

The generated code will look like: (the following code is summarised)

```dart
abstract class Weather {
  const factory Weather.rainy({required int rain}) = WeatherRainy;

  bool get isRainy => this is WeatherRainy;

  WeatherRainy get asRainy => this as WeatherRainy;

  WeatherRainy? get asRainyOrNull {
    /* ... */
  }

  /* ... */

  R when<R extends Object?>({
    required R Function() sunny,
    required R Function(int rain) rainy,
    required R Function(double velocity, double? angle) windy,
  }) {
    /* ... */
  }

  R maybeWhen<R extends Object?>({
    R Function()? sunny,
    R Function(int rain)? rainy,
    R Function(double velocity, double? angle)? windy,
    required R Function(Weather weather) orElse,
  }) {
    /* ... */
  }

  R? whenOrNull<R extends Object?>({
    R Function()? sunny,
    R Function(int rain)? rainy,
    R Function(double velocity, double? angle)? windy,
    R Function(Weather weather)? orElse,
  }) {
    /* ... */
  }

  R map<R extends Object?>({
    required R Function(WeatherSunny sunny) sunny,
    required R Function(WeatherRainy rainy) rainy,
    required R Function(WeatherWindy windy) windy,
  }) {
    /* ... */
  }

  R maybeMap<R extends Object?>({
    R Function(WeatherSunny sunny)? sunny,
    R Function(WeatherRainy rainy)? rainy,
    R Function(WeatherWindy windy)? windy,
    required R Function(Weather weather) orElse,
  }) {
    /* ... */
  }

  R? mapOrNull<R extends Object?>({
    R Function(WeatherSunny sunny)? sunny,
    R Function(WeatherRainy rainy)? rainy,
    R Function(WeatherWindy windy)? windy,
    R Function(Weather weather)? orElse,
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

  @override
  String toString() => 'Weather.rainy(rain: $rain)';

  @override
  List<Object?> get props => [rain];
}

class WeatherWindy extends Weather {
  /* ... */
}
```

Notes:

- Prefer using factories in super class instead of subclass constructors. like `Whether.rainy()` instead
  of `WhetherRainy()`
- Minimize usage of cast methods, most of the time they can be replaced with a match method.

## Equality and generated class names

You can choose between three types of equality using `@WithEquality(...)` annotation. Default equality is `data` if not
specified. This will become default equality for all subclasses. You can change equality of each subclass by using
this annotation on individual methods.

Equality types:

* `data` Equality is implemented with Equatable package. It behaves like kotlin data classes.
* `identity` Only identical instances are equal. It's like when you don't implement any specific equality.
* `distinct` All the instances are not equal with each other. Even an instance is not equal with itself.

A basic example:

```dart
@Sealed()
abstract class _Weather {
  void sunny();

  void rainy(int rain);

  void windy(double velocity, double? angle);
}
```

In the proceeding example all classes will have `data` equality. For example if you wanted `identity` equality for all
classes but using `distinct` equality for `windy`:

```dart
@Sealed()
@WithEquality(Equality.identity)
abstract class _Weather {
  void sunny();

  void rainy(int rain);

  @WithEquality(Equality.distinct)
  void windy(double velocity, double? angle);
}
```

An abstract super class is generated with name equal to name of manifest class without the underline (here `Weather`).
Each method will become a subclass. There should be at least one method. subclass names are based on method name
prefixed with super class name (for example `WeatherSunny`). Naming process can be tailored with use of `@WithPrefix`
and `@WithName` annotations. Each method argument will become a field in corresponding subclass. Field names are equal
to argument names and field types are equal to argument types or dynamic if not specified. Argument types can be
overridden using `@WithType` annotation for example when type information is not available at build time. Note that you
can have nullable and non-nullable fields.

To change prefix of subclass names which by default is top class name, you can use `@WithPrefix` annotation. for
example:

```dart
@Sealed()
@WithPrefix('Hello')
abstract class _Weather {
  void sunny();
}
```

Now `sunny` will be named `HelloSunny` instead of the default `WeatherSunny`. You can use `@WithPrefix('')` to remove
all prefix from subclass names.

To change subclass names directly you can use `@WithName` annotation. It will override `WithPrefix` if specified. for
example:

```dart
@Sealed()
abstract class _Weather {
  @WithName('Hello')
  void sunny();
}
```

Now `sunny` will be named `Hello` instead of the default `WeatherSunny`. This is useful if you want not to use prefix
for some items.

Almost all methods on sealed classes use short names extracted from manifest method names. Full subclass names are not
used. It is recommended not to use subclasses directly. There are factory methods for each item on super class.

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

## Dynamic types and Using one sealed type in another

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

### Hierarchy Feature

If Sealed classes are in the same file you can reference them directly using their manifest class name. This is to
avoid `@WithType` annotation and better refactoring capability.

```dart
@Sealed()
abstract class _Apple {
  void eat();
}

@Sealed()
abstract class _Banana {
  void eat();
}

@Sealed()
abstract class _Basket {
  void friends(_Apple? apple, _Banana? banana);

// or equivalently
// void friends(@WithType('Apple?') apple, @WithType('Banana?') banana);
}
```

And for generic case:

```dart
@Sealed()
abstract class _Result<D extends num> {
  void success(D data);

  void error(Object exception);
}

@Sealed()
abstract class _Basket {
  void hold(_Result<int> x);

// or equivalently:
// void hold(@WithType('Result<int>') x);
}
```

`@WithType` annotation will override hierarchy feature if present.

## Common Fields

Sometimes you need some fields to be present in all of your sealed classes. For example consider making a sealed class
for different types of errors, and all of them are required to have `code` and `message`. It is very annoying to add
code and message to all of sealed classes manually. Also, if you have an error object you are unable to get its code or
message without using cast or match methods. Here you can use common fields.

To declare a common field you can add a getter or a final field to a manifest class, and it will automatically be added
to all of your sealed classes. for example:

```dart
@Sealed()
abstract class _ApiError {
  // using getter
  String get message;

  // using final field
  final String? code = null;

  // code and message will be added to this automatically
  void internetError();

  void badRequest();

  void internalError(Object? error);
}
```

You can also use a constructor in pair with final fields equivalently.

common fields are available on `ApiError` objects as well as its subclasses.

If you specify common fields in your sealed classes it has no effect. for example:

```dart
@Sealed()
abstract class _Common {
  Object get x;

  // one and two will have identical signatures
  void one(Object x);

  void two();
}
```

You can use subclass of common field type in sealed classes. For example:

```dart
@Sealed()
abstract class _Common {
  Object get x;

  // x has type int
  void one(int x);

  // x has type String
  void one(String x);

  // x has type Object
  void three();
}
```

common fields also works with other constructs of dart_sealed like generics and @WithType. for example:

```dart
@Sealed()
abstract class _Common {
  @WithType('num')
  dynamic get x; // you can omit dynamic

  // x has type int
  void one(@WithType('int') dynamic x); // you can omit dynamic

  // x has type num
  void two();
}
```

and, for example:

```dart
@Sealed()
abstract class _Result<D extends num> {
  Object? get value;

  void success(D value);

  void error();
}
```

## Ignoring Generated Files

It is recommended to ignore generated files on Git. Add this to your `.gitignore` file:

```
*.sealed.dart
```

To exclude generated files from dart analysis, add this to your `analysis_options.yaml` file:

```
analyzer:
  exclude:
    - lib/**/*.sealed.dart
```
