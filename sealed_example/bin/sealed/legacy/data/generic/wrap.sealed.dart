// GENERATED CODE - DO NOT MODIFY BY HAND

// @dart=2.9
part of 'wrap.dart';

// **************************************************************************
// Generator: sealed_generators
// **************************************************************************

/// [Complete]<[T] extends [num]?, [U] extends [Object]?> {
///
/// ([CompleteOne] one){} with data equality with wrap
///
/// ([CompleteTwo] two){[T]? x, [U]? y, [U]? z} with data equality with wrap
///
/// ([CompleteThree] three){[int]? a, [T]? b} with data equality with wrap
///
/// }
@immutable
@SealedManifest(_Complete)
abstract class Complete<T extends num /*?*/, U extends Object /*?*/ > {
  const Complete._internal();

  @factory
  static CompleteOne<T, U> /*!*/ one<T extends num /*?*/,
          U extends Object /*?*/ >() =>
      CompleteOne<T, U>();

  @factory
  static CompleteTwo<T, U> /*!*/ two<T extends num /*?*/,
          U extends Object /*?*/ >({
    @required T /*?*/ x,
    @required U /*?*/ y,
    @required U /*?*/ z,
  }) =>
      CompleteTwo<T, U>(
        x: x,
        y: y,
        z: z,
      );

  @factory
  static CompleteThree<T, U> /*!*/ three<T extends num /*?*/,
          U extends Object /*?*/ >({
    @required int /*?*/ a,
    @required T /*?*/ b,
  }) =>
      CompleteThree<T, U>(
        a: a,
        b: b,
      );

  bool /*!*/ isOne() => this is CompleteOne<T, U>;

  bool /*!*/ isTwo() => this is CompleteTwo<T, U>;

  bool /*!*/ isThree() => this is CompleteThree<T, U>;

  CompleteOne<T, U> /*!*/ asOne() => this as CompleteOne<T, U>;

  CompleteTwo<T, U> /*!*/ asTwo() => this as CompleteTwo<T, U>;

  CompleteThree<T, U> /*!*/ asThree() => this as CompleteThree<T, U>;

  CompleteOne<T, U> /*?*/ asOneOrNull() {
    final complete = this;
    return complete is CompleteOne<T, U> ? complete : null;
  }

  CompleteTwo<T, U> /*?*/ asTwoOrNull() {
    final complete = this;
    return complete is CompleteTwo<T, U> ? complete : null;
  }

  CompleteThree<T, U> /*?*/ asThreeOrNull() {
    final complete = this;
    return complete is CompleteThree<T, U> ? complete : null;
  }

  R when<R extends Object /*?*/ >({
    @required R Function(CompleteOne<T, U> /*!*/ one) /*!*/ one,
    @required R Function(CompleteTwo<T, U> /*!*/ two) /*!*/ two,
    @required R Function(CompleteThree<T, U> /*!*/ three) /*!*/ three,
  }) {
    assert(one != null);
    assert(two != null);
    assert(three != null);
    final complete = this;
    if (complete is CompleteOne<T, U>) {
      return one(complete);
    } else if (complete is CompleteTwo<T, U>) {
      return two(complete);
    } else if (complete is CompleteThree<T, U>) {
      return three(complete);
    } else {
      throw AssertionError();
    }
  }

  R whenOrElse<R extends Object /*?*/ >({
    R Function(CompleteOne<T, U> /*!*/ one) /*?*/ one,
    R Function(CompleteTwo<T, U> /*!*/ two) /*?*/ two,
    R Function(CompleteThree<T, U> /*!*/ three) /*?*/ three,
    @required R Function(Complete<T, U> /*!*/ complete) /*!*/ orElse,
  }) {
    assert(orElse != null);
    final complete = this;
    if (complete is CompleteOne<T, U>) {
      return one != null ? one(complete) : orElse(complete);
    } else if (complete is CompleteTwo<T, U>) {
      return two != null ? two(complete) : orElse(complete);
    } else if (complete is CompleteThree<T, U>) {
      return three != null ? three(complete) : orElse(complete);
    } else {
      throw AssertionError();
    }
  }

  R whenOrDefault<R extends Object /*?*/ >({
    R Function(CompleteOne<T, U> /*!*/ one) /*?*/ one,
    R Function(CompleteTwo<T, U> /*!*/ two) /*?*/ two,
    R Function(CompleteThree<T, U> /*!*/ three) /*?*/ three,
    @required R orDefault,
  }) {
    assert(orDefault != null);
    final complete = this;
    if (complete is CompleteOne<T, U>) {
      return one != null ? one(complete) : orDefault;
    } else if (complete is CompleteTwo<T, U>) {
      return two != null ? two(complete) : orDefault;
    } else if (complete is CompleteThree<T, U>) {
      return three != null ? three(complete) : orDefault;
    } else {
      throw AssertionError();
    }
  }

  R /*?*/ whenOrNull<R extends Object /*?*/ >({
    R Function(CompleteOne<T, U> /*!*/ one) /*?*/ one,
    R Function(CompleteTwo<T, U> /*!*/ two) /*?*/ two,
    R Function(CompleteThree<T, U> /*!*/ three) /*?*/ three,
  }) {
    final complete = this;
    if (complete is CompleteOne<T, U>) {
      return one?.call(complete);
    } else if (complete is CompleteTwo<T, U>) {
      return two?.call(complete);
    } else if (complete is CompleteThree<T, U>) {
      return three?.call(complete);
    } else {
      throw AssertionError();
    }
  }

  R whenOrThrow<R extends Object /*?*/ >({
    R Function(CompleteOne<T, U> /*!*/ one) /*?*/ one,
    R Function(CompleteTwo<T, U> /*!*/ two) /*?*/ two,
    R Function(CompleteThree<T, U> /*!*/ three) /*?*/ three,
  }) {
    final complete = this;
    if (complete is CompleteOne<T, U> && one != null) {
      return one(complete);
    } else if (complete is CompleteTwo<T, U> && two != null) {
      return two(complete);
    } else if (complete is CompleteThree<T, U> && three != null) {
      return three(complete);
    } else {
      throw AssertionError();
    }
  }

  void whenPartial({
    void Function(CompleteOne<T, U> /*!*/ one) /*?*/ one,
    void Function(CompleteTwo<T, U> /*!*/ two) /*?*/ two,
    void Function(CompleteThree<T, U> /*!*/ three) /*?*/ three,
  }) {
    final complete = this;
    if (complete is CompleteOne<T, U>) {
      one?.call(complete);
    } else if (complete is CompleteTwo<T, U>) {
      two?.call(complete);
    } else if (complete is CompleteThree<T, U>) {
      three?.call(complete);
    } else {
      throw AssertionError();
    }
  }
}

/// (([CompleteOne] : [Complete])<[T] extends [num]?, [U] extends [Object]?> one){}
///
/// with data equality
///
/// with wrap
@immutable
class CompleteOne<T extends num /*?*/, U extends Object /*?*/ >
    extends Complete<T, U> with EquatableMixin {
  const CompleteOne() : super._internal();

  @override
  String /*!*/ toString() => 'Complete.one()';

  @override
  List<Object /*?*/ > /*!*/ get props => [];
}

/// (([CompleteTwo] : [Complete])<[T] extends [num]?, [U] extends [Object]?> two){[T]? x, [U]? y, [U]? z}
///
/// with data equality
///
/// with wrap
@immutable
class CompleteTwo<T extends num /*?*/, U extends Object /*?*/ >
    extends Complete<T, U> with EquatableMixin {
  const CompleteTwo({
    @required this.x,
    @required this.y,
    @required this.z,
  }) : super._internal();

  final T /*?*/ x;
  final U /*?*/ y;
  final U /*?*/ z;

  @override
  String /*!*/ toString() => 'Complete.two(x: $x, y: $y, z: $z)';

  @override
  List<Object /*?*/ > /*!*/ get props => [
        x,
        y,
        z,
      ];
}

/// (([CompleteThree] : [Complete])<[T] extends [num]?, [U] extends [Object]?> three){[int]? a, [T]? b}
///
/// with data equality
///
/// with wrap
@immutable
class CompleteThree<T extends num /*?*/, U extends Object /*?*/ >
    extends Complete<T, U> with EquatableMixin {
  const CompleteThree({
    @required this.a,
    @required this.b,
  }) : super._internal();

  final int /*?*/ a;
  final T /*?*/ b;

  @override
  String /*!*/ toString() => 'Complete.three(a: $a, b: $b)';

  @override
  List<Object /*?*/ > /*!*/ get props => [
        a,
        b,
      ];
}