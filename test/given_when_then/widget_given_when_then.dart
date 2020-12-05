/// TODO:
///  Copy&paste from given_when_then. Redundancy needs to be removed by
///  refactoring.
import 'package:flutter_test/flutter_test.dart' as flutter_test;
import 'package:meta/meta.dart';
import 'package:mockito/mockito.dart' as mockito;

typedef Define = dynamic Function();
typedef WidgetDefine = Future<void> Function(flutter_test.WidgetTester tester);

Given given(String description, Define define) => Given(description, define);

When when(String description, WidgetDefine define) => When(description, define);

Then then(String description, WidgetDefine define) => Then(description, define);

mockito.Expectation get mockWhen => mockito.when;

@isTest
void testWidget(Then givenWhenThen) {
  givenWhenThen.test();
}

class Given {
  const Given(
    this._description,
    this.define, {
    this.parent,
  });

  final String _description;
  final Define define;
  final Given? parent;

  String get description {
    if (_description.startsWith('Given ')) {
      return _description;
    } else {
      return 'Given $_description';
    }
  }

  Given _merge() {
    Given? given = this;
    final descriptions = <String>[];
    final defines = <Define>[];
    while (given != null) {
      descriptions.add(given.description);
      defines.add(given.define);
      given = given.parent;
    }

    return Given(
      descriptions.reversed.join(' and '),
      () {
        for (var define in defines.reversed) {
          define();
        }
      },
      parent: null,
    );
  }

  Given copyWith({String? description, Define? define, Given? parent}) {
    return Given(
      description ?? _description,
      define ?? this.define,
      parent: parent ?? this.parent,
    );
  }

  Given and(String description, Define define) {
    return Given(description, define, parent: this);
  }

  Given andThat(Given given) {
    return given.copyWith(parent: this);
  }

  When when(String description, WidgetDefine define) {
    return When(description, define, given: parent == null ? this : _merge());
  }

  When whenThat(When when) {
    return When(
      when.description,
      when.define,
      given: parent == null ? this : _merge(),
    );
  }
}

class When {
  const When(
    this._description,
    this.define, {
    this.given,
    this.parent,
  });

  final String _description;
  final WidgetDefine define;
  final Given? given;
  final When? parent;

  String get description {
    if (_description.startsWith('When ')) {
      return _description;
    } else {
      return 'When $_description';
    }
  }

  When _merge() {
    When? givenWhen = this;
    final descriptions = <String>[];
    final defines = <WidgetDefine>[];
    while (givenWhen != null) {
      descriptions.add(givenWhen.description);
      defines.add(givenWhen.define);
      givenWhen = givenWhen.parent;
    }

    return When(
      descriptions.reversed.join(' and '),
      (tester) async {
        for (var define in defines.reversed) {
          await define(tester);
        }
      },
      given: given,
      parent: null,
    );
  }

  When copyWith({
    String? description,
    WidgetDefine? define,
    Given? given,
    When? parent,
  }) {
    return When(
      description ?? _description,
      define ?? this.define,
      given: given ?? this.given,
      parent: parent ?? this.parent,
    );
  }

  When and(String description, WidgetDefine define) {
    return When(description, define, parent: this, given: given);
  }

  When andThat(When when) {
    return when.copyWith(given: given, parent: this);
  }

  @isTest
  Then then(String description, Function define) {
    return Then(description, define, when: parent == null ? this : _merge());
  }

  @isTest
  Then thenThat(Then then) {
    return then.copyWith(when: parent == null ? this : _merge());
  }
}

class Then {
  const Then(
    this._description,
    this.define, {
    this.when,
    this.parent,
  }) : assert(define is Define || define is WidgetDefine);

  final String _description;
  String get description {
    if (_description.startsWith('Then ')) {
      return _description;
    } else {
      return 'Then $_description';
    }
  }

  final Function define;
  final When? when;
  final Then? parent;

  Then copyWith({
    String? description,
    Function? define,
    When? when,
    Then? parent,
  }) {
    return Then(
      description ?? _description,
      define ?? this.define,
      when: when ?? this.when,
      parent: parent ?? this.parent,
    );
  }

  Then and(String description, Function define) {
    return Then(description, define, when: when, parent: this);
  }

  Then andThat(Then then) {
    return then.copyWith(when: when, parent: this);
  }

  @isTest
  void test() {
    assert(this.when != null, "can't test with Then alone.");

    final when = this.when!;

    void whenThen() {
      flutter_test.group(when.description, () {
        var descriptions = [];
        var defines = [];
        Then? then = this;
        while (then != null) {
          descriptions.add(then.description);
          defines.add(then.define);
          then = then.parent;
        }

        descriptions = descriptions.reversed.toList();
        defines = defines.reversed.toList();

        for (var i = 0; i < descriptions.length; i++) {
          flutter_test.testWidgets(descriptions[i], (tester) async {
            final define = defines[i];
            await when.define(tester);
            if (define is Define) {
              define();
            } else {
              await define(tester);
            }
          });
        }
      });
    }

    if (when.given != null) {
      final given = when.given!;
      flutter_test.group(given.description, () {
        flutter_test.setUp(given.define);
        whenThen();
      });
    } else {
      whenThen();
    }
  }
}
