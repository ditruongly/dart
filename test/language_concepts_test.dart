import 'dart:ffi';
import 'dart:mirrors';

import 'package:test/test.dart';
import 'package:dart/language_concepts.dart';

main() {
  test('number should be null', () {
    final sut = LanguageConcepts();

    expect(sut.number, equals(null));
  });

  test('nonNullableNumber should never be null', () {
    final sut = LanguageConcepts();

    expect(sut.nonNullableNumber, isNotNull);
  });

  test('given null should throw an error', () {
    final sut = LanguageConcepts();

    expect(() => sut.throwErrorWhenParameterIsNull(null),
        throwsA(TypeMatcher<TypeError>()));
  });

  test('declare but not initialize a local variable', () {

    bool warn; // you don’t have to initialize a local variable
    // where it’s declared, but you do need to assign
    // it a value before it’s used.

    const loginCount = 3;
    if (loginCount >= 3) {
      warn = true;
    } else {
      warn = false;
    }

    expect(warn, isTrue);
  });

  String initializeMessage(String context) {
    print('initializeMessage($context)');
    return '$context';
  }

  test('lazy init with late', () {
    late String lazyInitMessage = initializeMessage("lazy");
    String normalMessage = initializeMessage("normal");
    expect(normalMessage, 'normal');
  });

  test('forget to initialize a lazy-declared variable before using it would cause a runtime error', () {
    final sut = LanguageConcepts();
    try {
      sut.appendToMessage("Di");
    } catch (e) {
      expect(
          e.toString(),
          equals(
              "LateInitializationError: Field 'message' has not been initialized."));
    }
  });

  test('final keyword for reference variables', () {
    final list = [0];

    list[0] = 1;

    expect(list[0], 1);
  });

  test('const keyword for reference variables', () {
    const list = [0];
    try {
      list[0] = 1;
    } catch (e) {
      expect(
          e.toString(),
          equals(
              "Unsupported operation: Cannot modify an unmodifiable list"));
    }
  });

  test('identify the type of a variable', () {
    Object objectWithIntValue = 3;

    objectWithIntValue.runtimeType;

    expect(objectWithIntValue.runtimeType, int);
    expect(objectWithIntValue.runtimeType, isNot(Object));
  });

  test('type-check operator: is', () {
      const Object obj = 3;
      var map = {};
      if (obj is int) {
        map[obj] = 'int';
      }

      expect(map[3], 'int');
  });

  test('if operator', () {
    const Object obj = 3;
    const map = {if (obj is int) obj: 'int'};

    expect(map[3], 'int');
  });


  test('spread operator: ...', () {
    const list = [1, 2, 3];
    const set = {...list};

    expect(set.first, 1);
  });

  test('type-cast operator: as', () {
    const Object obj = 3;
    const intVariable = obj as int;

    expect(intVariable, 3);
  });

  test('create an object with the new keyword and the const-constructor together', () {
    var origin0 = Point.ORIGIN;
    var origin1 = new Point(0, 0); // create with 'new' keyword and 'const constructor'

    print(origin0.hashCode);
    print(origin1.hashCode);

    expect(origin0, isNot(origin1));
  });

  test('create an object with the initializer-list', () {
    var origin0 = Point.ORIGIN;
    var origin1 = Point.clone(origin0); // create with 'initializer list'

    print(origin0.hashCode);
    print(origin1.hashCode);

    expect(origin0, isNot(origin1));
  });

  // 'const constructor' helps Flutter to increase performance,
  // because only those widgets, created without 'const constructor',
  // will be rebuild
  // https://stackoverflow.com/questions/21744677/how-does-the-const-constructor-actually-work
  test('create an object with the const-constructor', () {
    var origin0 = Point.ORIGIN;
    var origin1 = const Point(0, 0); // create compile-time constant with const-constructor

    print(origin0.hashCode);
    print(origin1.hashCode);

    expect(origin0, equals(origin1));
  });

  test('constant instanciation context', () {
    var origin0 = Point.ORIGIN;
    const points = [Point(0, 0)]; // the first use of the const keyword
    // establishes the constant context the list-items are implicitly created
    // with 'const constructur'

    print(origin0.hashCode);
    print(points[0].hashCode);

    expect(origin0, equals(points[0]));
  });

  test('normal instanciation context', () {
    var origin0 = Point.ORIGIN;
    final points = [Point(0, 0)]; // the use of the final keyword
    // establishes the normal context the list-items are implicitly created
    // without 'const constructur'

    print(origin0.hashCode);
    print(points[0].hashCode);

    expect(origin0, isNot(points[0]));
  });

  test('type num', () {
    num x = 1;
    print(x.runtimeType);

    expect(x.runtimeType, int);

    x += 2.5;
    print(x.runtimeType);

    expect(x.runtimeType, double);
  });

  test('integer literals are automatically converted to doubles when necessary', () {
    double z = 1;

    print(z.runtimeType);

    expect(z.runtimeType, double);
  });

  test('convert: String -> int', () {
    var one = int.parse('1');

    print(one.runtimeType);

    expect(one.runtimeType, int);
  });

  test('convert: String -> double', () {
    var onePointOne = double.parse('1.1');

    print(onePointOne.runtimeType);

    expect(onePointOne.runtimeType, double);
  });

  test('convert: int -> String', () {
    var i = 1;
    var s = i.toString();

    print('$s is a ${s.runtimeType}');

    expect(s.runtimeType, String);
    expect(s, '1');
  });

  test('convert: double -> String', () {
    String piAsString = 3.14159.toStringAsFixed(2);

    print(piAsString);

    expect(piAsString, '3.14');
  });

  test('bitwise shift: 0011 << 1 == 0110', () {
    expect((3 << 1) == 6, true);
  });

  test('bitwise or: 0011 | 0100 == 011', () {
    expect((3 | 4) == 7, true);
  });

  test('bitwise or: 0011 & 0100 == 0000', () {
    expect((3 & 4) == 0, true);
  });

  // The == operator tests whether two objects are equivalent. Two strings are
  // equivalent if they contain the same sequence of code units.

  test('string literals are either in single or double quotes', () {
    var s1 = 'a';
    var s2 = "a";

    expect(s1 == s2, true);
  });

  test('string interpolation', () {
    var s1 = 'a';
    var s2 = 's1 is $s1';

    print(s2);

    expect(s2 == 's1 is a', true);
  });

  test('common collection: list - add an item', () {
    var list = [1, 2, 3];

    list.add(4);

    expect(list[3] == 4, true);
  });

  test('common collection: list - add an item with wrong type', () {
    var list = [1, 2, 3];
    var four;

    try {
      list.add(four);
    } catch (e) {
      expect(
          e.toString(),
          equals(
              "type 'Null' is not a subtype of type 'int'"));
    }
  });

  test('common collection: list and the spread operator', () {
    var list = [1, 2, 3];
    var list2 = [0, ...list];

    expect(list2.length == 4, true);
  });

  test('common collection: list and the null-aware spread operator', () {
    var list;
    var list2 = [0, ...?list];

    expect(list2.length == 1, true);
  });

  test('common collection: list and collection if', () {
    var nav = [
      'Home',
      'Furniture',
      'Plants',
      if (true) 'Outlet'
    ];

    expect(nav.length == 4, true);
  });

  test('common collection: list and collection for', () {
    var listOfInts = [1, 2, 3];
    var listOfStrings = [
      '#0',
      for (var i in listOfInts) '#$i'
    ];

    expect(listOfStrings.length == 4, true);
  });

  group('collection set', () {
    test('create a set and add the wrong type of value to the set', () {
      var names = <String>{};
      var NULL;

      names.add('Jason');
      names.addAll({'Jon', 'Brad'});
      assert(names.length == 3);

      print(names.runtimeType);
      try {
        names.add(NULL);
      } catch (e) {
        expect(e.toString(),
            equals("type 'Null' is not a subtype of type 'String'"));
      }
    });

    test('create an unmodifiable set', () {
      final names = const {'Jason', 'Brad'};

      try {
        names.add('Jon');
      } catch (e) {
        expect(e.toString(),
            equals('Unsupported operation: Cannot change an unmodifiable set'));
      }
    });

    test('spread operator with sets', () {
      final set1 = {1, 2, 3};
      final set2 = {...set1};
      print(set1.hashCode);
      print(set2.hashCode);
      assert(set1 != set2);

      expect(set1, equals(set2));
    });

    test('spread operator with unmodifiable sets', () {
      const set1 = {1, 2, 3};
      const set2 = {...set1};
      print(set1.hashCode);
      print(set2.hashCode);
      assert(set1 == set2);

      expect(set1, equals(set2));
    });
  });

  group('collection map', () {
    test('create a map and update, add and delete entries', () {
      var person = {
        1:'Jason',
        3:'Brad'
      };
      person[2] = 'Jon'; // add
      person[1] = 'Jon'; // update
      person.remove(3);  // delete
      print(person);

      expect(person.length, 2);
    });

    test('create a map and add the wrong type of value to the map', () {
      var person = {
        1:'Jason',
        3:'Brad'
      };
      assert(person.length == 2);
      var NULL;
      try {
        person[1] = NULL;
      } catch (e) {
        expect(e.toString(),
            equals("type 'Null' is not a subtype of type 'String'"));
      }
    });

    // create compile-time constant maps with const constructors
    // maps support spread operators

  });

  test('symbol', () {
    const list = [#name];
    print(list);

    expect(list.first is Symbol, true);
  });

  group('function', () {

    test('function declaration without type annotations', () {
      fn(x) {
        return x;
      }

      expect(fn(1), 1);
      expect(fn('a'), 'a');
    });

    test('function declaration with return-value', () {
      fn()  {
        return Void;
      }
      expect(fn(), Void);
    });

    test('function declaration with arrow syntax', () {
      fn() => Void;

      expect(fn(), Void);
    });

    test('function declaration without return-value', () {
      fn() {}
      print(fn());

      expect(fn(), null);
    });

    test('function declaration with named parameter and default value', () {
      fn({enable = true}) => enable;

      expect(fn(enable: false), false);
      expect(fn(), true);
    });

    test('function declaration with required named parameter', () {
      fn({required bool enable}) => enable;

      expect(fn(enable: false), false);
    });

    test('function declaration with optional positional parameter', () {
      fn(int x, [enable]) => enable;

      expect(fn(1), null);
    });

    test('function declaration with default value for optional positional parameter', () {
      fn(int x, [x0 = 0]) => x + x0;

      expect(fn(1), 1);
      expect(fn(1, 1), 2);
    });

    test('functions as first-class objects', () {
      fn1(int x, [x0 = 0]) => x + x0;
      fn2(int x, fn) => fn(x) * x;

      expect(fn2(1, fn1), 1);
      expect(fn2(2, fn1), 4);
    });

    test('anonymous function, lambda, closure', () {
      const list = ['apples', 'bananas', 'oranges'];
      var itemPrint = (item) => print('${list.indexOf(item)}: $item');
      list.forEach(itemPrint);
    });

    test('lexical scope', () {

      myFunction() {
        var outerVariable = true;

        nestedFunction() {
          expect(outerVariable, true);
        }
      }
    });

    test('lexical closures', () {

      Function makeAdder(int addBy) {
        return (int i) => addBy + i;
      }

      main() {
        var add2 = makeAdder(2);

        expect(add2(3), 5);
      }
    });

    test('compare static functions', () {
      Function fn1;

      fn1 = Shape.withColor;
      print(fn1);
      print(Shape.withColor);

      expect(fn1, Shape.withColor);
    });

    test('compare instance methods from same instance', () {
      var shape1 = Shape(0);
      var shape2 = shape1;
      Function fn = shape2.getColor;

      expect(fn, shape1.getColor);
    });

    test('compare instance methods from different instances', () {
      var shape1 = Shape(0);
      var shape2 = Shape(0);

      expect(shape1.getColor, isNot(shape2.getColor));
    });

  });

  group('equality', () {

    test('compare different instances with identical or with ==', () {
      var shape1 = Shape(0);
      var shape2 = Shape(0);

      expect(identical(shape1, shape2), false);
      expect(shape1 == shape2, true);
      expect(shape1, shape2);
    });

    test('compare different variables refencing the same instance with ==', () {
      var shape1 = Shape(0);
      var shape2 = shape1;

      expect(identical(shape1, shape2), true);
      expect(shape1 == shape2, true);
      expect(shape1, shape2);
    });

    test('compare compile-time constants with identical or with ==', () {
      var shape1 = const Shape(0);
      var shape2 = const Shape(0);

      expect(identical(shape1, shape2), true);
      expect(shape1 == shape2, true);
      expect(shape1, shape2);
    });
  });

  test('type test operators', () {
    Shape obj;
    bool isCircle;

    obj = Shape(0);
    if (obj is Circle) {
      isCircle = true;
      print('obj is a circle instance with radius ${obj.radius}');
    } else {
      isCircle = false;
      print('obj is a shape instance with color ${obj.rgb}');
    }

    expect(isCircle, false);
  });

  test('assignment operator ??=', () {
    var x;

    x ??= 1;
    print('x = $x');

    expect(x, 1);
  });

  test('assignment operator ??=', () {
    var x = 0;

    x ??= 1;
    print('x = $x');

    expect(x, 0);
  });

  test('conditional expression ??', () {
    var x, y;

    y = x ?? 0;
    print('y = $y');

    expect(y, 0);
  });

  test('conditional expression ??', () {
    var x = 1;
    var y;

    y = x ?? 0;
    print('y = $y');

    expect(y, 1);
  });

  test('logical operators !expr || &&', () {
    var done = false;
    var col = 0;
    var valid = false;

    if (!done && (col == 0 || col == 3)) {
      valid = true;
    }

    expect(valid, true);
  });

  test('bitwise and shift operators & | ^ ~ << >> >>>', () {
    const value = 0x22;
    const bitmask = 0x0f;

    const AND = (value & bitmask);

    expect(AND, 0x02);
  });

  test('cascade notation ..', () {
    var list = []
        ..add(1)
        ..addAll([2,3]);

    expect(list.length, 3);
  });

  test('null-shorting cascade ?.. (Dart 2.12)', () {
    List<int>? queryNumber() => null;

    List<int>? numbers = queryNumber()
      ?..add(1) // none of the cascade operations are attempted on null object
      ..addAll([2,3]);

    expect(numbers, null);
  });

  test('nest cascades', () {
    var list = []
      ..add(1)
      ..addAll([2,3]..add(4));

    expect(list.length, 4);
  });

  test('conditional subscript access', () {
    List<int>? queryNumber() => null;

    List<int>? numbers = queryNumber();
    numbers?[0] = 0;

    expect(numbers, null);
  });

  test('conditional member access', () {
    List<int>? queryNumber() => null;

    List<int>? numbers = queryNumber();
    numbers?.add(1);

    expect(numbers, null);
  });

  test('if and else', () {
    int x;

    if (false) {
      x = 1;
    } else if (false) {
      x = 2;
    } else {
      x = 3;
    }

    expect(x, 3);
  });

  test('for loops', () {
    var message = StringBuffer('Dart is fun');

    for (var i = 0; i < 5; i++) {
      message.write('!');
    }

    expect(message.toString(), 'Dart is fun!!!!!');
  });

  test('for-in over iterable (such as List or Set)', () {
    var numbers = [1,2,3];

    int? two;
    for (final i in numbers) {
      if (i.isEven) {
        two = i;
      }
    }

    expect(two, 2);
  });

  test('for-each over iterable (such as List or Set)', () {
    var numbers = [1,2,3];
    var s = StringBuffer();

    numbers.forEach( (i) => s.write(i));

    expect(s.toString(), '123');
  });

  // while (true) {}
  // do { } while (true);
  // use 'break' to stop looping
  // use 'continue' to skip to the next loop iteration

  test('switch compare integer, string, or compile-time constants using ==', () {
    var next = 1;

    switch (next) {
      case 1:
        next = 2;
        break;
      case 2:
        next = 3;
        break;
      default:
    }

    expect(next, 2);
  });

  group('exceptions', () {

    test('throw an exception', () {
      expect(() => throw FormatException('A message'),
          throwsA(TypeMatcher<FormatException>()));
    });

    test('catch FormatException', () {

      final message = StringBuffer();
      final stacktrace = StringBuffer();

      try {
        throw FormatException('a message of FormatException');
      } on FormatException catch (e, s) {
        message.write(e.message);
        stacktrace.write(s.toString());
      } on ArgumentError catch (e, s) {
        message.write(e.message);
        stacktrace.write(s.toString());
      } catch (e, s) {
        message.write(e.toString());
        stacktrace.write(s.toString());
      }

      print(stacktrace);
      expect(message.toString(), 'a message of FormatException');
    });

    test('catch ArgumentError', () {

      final message = StringBuffer();
      final stacktrace = StringBuffer();

      try {
        throw ArgumentError('a message of ArgumentError');
      } on FormatException catch (e, s) {
        message.write(e.message);
        stacktrace.write(s.toString());
      } on ArgumentError catch (e, s) {
        message.write(e.message);
        stacktrace.write(s.toString());
      } catch (e, s) {
        message.write(e.toString());
        stacktrace.write(s.toString());
      }

      print(stacktrace);
      expect(message.toString(), 'a message of ArgumentError');
    });

    test('catch UnsupportedError', () {

      final message = StringBuffer();
      final stacktrace = StringBuffer();

      try {
        throw UnsupportedError('a message of UnsupportedError');
      } on FormatException catch (e, s) {
        message.write(e.message);
        stacktrace.write(s.toString());
      } on ArgumentError catch (e, s) {
        message.write(e.message);
        stacktrace.write(s.toString());
      } catch (e, s) {
        message.write(e.toString());
        stacktrace.write(s.toString());
      }

      print(stacktrace);
      expect(message.toString(), 'Unsupported operation: a message of UnsupportedError');
    });

    test('rethrow', () {

      catchAndRethrow() {
        try {
          throw UnsupportedError('a message of UnsupportedError');
        } on UnsupportedError catch (e, s) {
          print('partially handled');
          rethrow;
        }
      }

      expect(() => catchAndRethrow(),
          throwsA(TypeMatcher<UnsupportedError>()));
    });

    test('catch arbitrary object', () {
      try {
        throw 'arbitrary object';
      } catch (e, s) {
        print(e);
      }
    });

    test('catch with stacktrace', () {
      try {
        throw 'arbitrary object';
      } catch (e, s) {
        print(s);
      }
    });

    test('finally', () {
      try {
        print('hello');
      } finally {
        // Always clean up, even if an exception is thrown.
        print('whether or not an exception is thrown');
      }
    });
  });

  group('classes', () {
    test('Use ?. instead of . to avoid an exception when the leftmost operand is null', () {
        Point? p = Point.NULL();
        expect(p?.x, isNull);
    });

    test('create an object is not possible if the class does not have a const constructor', () {
      var p;
      int hash1, hash2;

      p =  PointWithoutConstConstructor(0, 0);
      hash1 = p.hashCode;
      print(hash1);

      p =  PointWithoutConstConstructor(0, 0);
      hash2 = p.hashCode;
      print(hash2);

      expect(hash1, isNot(hash2));
    });

    test('constructing two identical compile-time constants results in a single, canonical instance', () {
      var p1 = const Point(1, 1);
      var p2 = const Point(1, 1);

      assert(identical(p1, p2)); // They are the same instance!
      expect(p1, p2);
    });

    // constant context: constant instanciation context (see above)

    test('you can also create non-constant objects if its class has only const constructors', () {
      var p1 = Point(1, 1);
      var p2 = Point(1, 1);
      int hash1, hash2;

      hash1 = p1.hashCode;
      print(hash1);

      hash2 = p2.hashCode;
      print(hash2);

      assert(!identical(p1, p2)); // NOT the same instance!
      expect(p1, isNot(p2));
    });

    test('create a mutable object', () {
      var object = PointWithoutConstConstructor(0, 1);
      expect(object.x,0);
      expect(object.y,1);
      object.x = 0; // call the implicit setter method
      object.y = object.x; // call the implicit getter method
      expect(object.x,0);
      expect(object.y,0);
    });

    test('call hierachy', () {
      var employee = Employee.fromJson({});
      expect(employee.firstName,'in Person\nin Employee\n');
    });

    test('operator declaration', () {
      Forname forname = Forname('Brandon');
      Surname surname = Surname('Lee');
      Fullname fullname = forname + surname;
      print(fullname.hashCode);
      expect(fullname.toString(),'Brandon Lee');
      fullname = surname + forname;
      print(fullname.hashCode);
      expect(fullname.toString(),'Brandon Lee');
    });

    test('abstract methods/class', () {
      Vehicle car = Car();
      expect(car.runtimeType, Car);
    });

    test('enums are a special kind of class', () {
      expect(Color.red.index, 0);
      expect(Color.green.index, 1);
      expect(Color.blue.index, 2);
    });

    test('a list of all of the values in the enum', () {
      List<Color> colors = Color.values;
      expect(colors[2], Color.blue);
    });

    // You can use in switch statements.
    // You can’t subclass, mix in, or implement an enum.
    // You can’t explicitly instantiate an enum

    test('mixin', () {
      SingerDancer performer = SingerDancer();
      // performer.entertainMe();
    });

    // Use the static keyword to implement class-wide variables and methods.

  });

  // To get an object’s type at runtime,
  // you can use the Object property runtimeType, which returns a Type object.

  group('Generics', () {
    test('collection literals', () {
      var names = <String>['Seth', 'Kathy', 'Lars'];
      var uniqueNames = <String>{'Seth', 'Kathy', 'Lars'};
      var pages = <String, String>{
        'index.html': 'Homepage',
        'robots.txt': 'Hints for web robots',
        'humans.txt': 'We are people, not machines'
      };
      expect(names[0], 'Seth');
      expect(uniqueNames.lookup('Seth'),'Seth');
      expect(pages['index.html'], 'Homepage');
    });

    test('using parameterized types with constructors', () {
      var names = List<String>.from(['Seth', 'Kathy', 'Lars']);
      var uniqueNames = Set<String>.from(['Seth', 'Kathy', 'Lars']);
      var pages = Map<String, String>();
      pages.addAll({
        'index.html': 'Homepage',
        'robots.txt': 'Hints for web robots',
        'humans.txt': 'We are people, not machines'
      });
      expect(names is List<String>, true);
      expect(uniqueNames is Set<String>, true);
      expect(pages is Map<String, String>, true);
      expect(names[0], 'Seth');
      expect(uniqueNames.lookup('Seth'),'Seth');
      expect(pages['index.html'], 'Homepage');
    });

    // Restricting the parameterized type


  });

  /*
  import 'package:lib1/lib1.dart';
  import 'package:lib2/lib2.dart' as lib2;

  // Uses Element from lib1.
  Element element1 = Element();

  // Uses Element from lib2.
  lib2.Element element2 = lib2.Element();

  // Import only foo.
  import 'package:lib1/lib1.dart' show foo;

  // Import all names EXCEPT foo.
  import 'package:lib2/lib2.dart' hide foo;
  */

  group('callable classes', () {
    test('allow an instance to be called like a function', () {
      var wf = WannabeFunction();
      var out = wf('Hi', 'there,', 'gang');
      expect(out,'Hi there, gang!');
    });
  });


  /*
  group('', () {
    test('', () {
        expect('','');
    });
  });
  */
}