class WannabeFunction {
  String call(String a, String b, String c) => '$a $b $c!';
}

// Restricting the parameterized type.
// Any type provided to Foo for T must be non-nullable.
class Foo<T extends Object> {

  T first<T>(List<T> ts) {
    // Do some initial work or error checking, then...
    T tmp = ts[0];
    // Do some additional checking or processing...
    return tmp;
  }
}

class Musician {
  // ...
}
// restrict the types that can use a mixin
mixin MusicalPerformer on Musician {
  // ...
}
// restrict the types that can use a mixin
class SingerDancer extends Musician with MusicalPerformer {
  // ...
}

mixin Musical {
  bool canPlayPiano = false;
  bool canCompose = false;
  bool canConduct = false;

  void entertainMe() {
    if (canPlayPiano) {
      print('Playing piano');
    } else if (canConduct) {
      print('Waving hands');
    } else {
      print('Humming to self');
    }
  }
}

enum Color { red, green, blue }

// Abstract classes can't be instantiated unless they have
// factory methods.
// Every class implicitly defines an interface
abstract class Vehicle {
    double? _maxSpeed;
    move();
}

class Car extends Vehicle {

  _Car(double maxSpeed) {
    super._maxSpeed = maxSpeed;
  }

  @override
  move() { }
}

class Truck implements Vehicle {

  @override
  double? _maxSpeed;

  @override
  move() { }
}

class Fullname {
  Surname surname;
  Forname forname;
  Fullname(this.forname, this.surname);
  @override
  String toString() =>  forname.toString() + " " + surname.toString();
}

class Surname {
  String value;
  Surname(this.value);
  Fullname operator +(Forname forname) => Fullname(forname, this);
  @override
  String toString() =>  value;
}

class Forname {
  String value;
  Forname(this.value);
  Fullname operator +(Surname surname) => Fullname(this, surname);
  @override
  String toString() =>  value;
}

class Person {
  String? firstName;

  // named constructor
  Person.fromJson(Map data) {
    firstName = 'in Person\n';
  }
}

class Employee extends Person {
  // Person does not have a default constructor;
  // you must call super.fromJson(data).
  Employee.fromJson(Map data) : super.fromJson(data) {
    firstName = firstName! + 'in Employee\n';
  }
}

class Circle extends Shape {

  final double radius;

  const Circle(int rgb, this.radius) : super(rgb);

  static withRadius(int rgb, double radius) => Circle(rgb, radius);

  getRadius() => radius;

  @override
  bool operator ==(Object other) {
    if (other is! Circle) return false;
    return rgb == (other as Circle).getColor()
      && radius == (other as Circle).getRadius();
  }
}

class Shape {

  final int rgb;

  const Shape(this.rgb);

  static withColor(int rgb) => Shape(rgb);

  getColor() => rgb;

  @override
  bool operator ==(Object other) {
    if (other is! Shape) return false;
    return rgb == (other as Shape).getColor();
  }
}

/*
All instance variables generate an implicit getter method. Non-final instance
variables and late final instance variables without initializers also generate
an implicit setter method.
 */
class PointWithoutConstConstructor {
  double? x; // Declare instance variable x, initially null.
  double? y; // Declare y, initially null.
  double z = 0; // Declare z, initially 0.

  // a late final without an initializer adds a setter, which can be called
  // after the constructor is called like a factory constructor
  late final name;

  // constructor parameter
  // Syntactic sugar for setting x and y
  // before the constructor body runs.
  PointWithoutConstConstructor(this.x, this.y);

  /*
   1. initializer list
   2. superclass’s no-arg constructor
   3. main class’s no-arg constructor
  */

  // Named constructor with initializer list which is called
  // before the constructor body runs
  PointWithoutConstConstructor.init() : x = 0, y = 0 {
    print('In PointWithoutConstConstructor.init(): ($x, $y)');
  }
}

// Instances of this class are immutables.
class Point {

  static final Point ORIGIN = const Point(0, 0);

  // All fields have to be final.
  final int x;
  final int y;

  // 'const constructor'
  const Point(this.x, this.y);

  // 'initializer lists'
  Point.clone(Point other):
        x = other.x,
        y = other.y;

  static Point? NULL() {
    return null;
  }

  @override
  String toString() {
    return 'Point[$x,$y]';
  }
}

class LanguageConcepts {

  // You can declare that a variable can be null,
  // by putting a question mark (?) at the end of its type.
  int? _number;

  int? get number => _number;

  // The concept of "null safety" introduced in Dart 2.12 says,
  // that you must initialize a non-nullable variable before you use them.
  int _nonNullableNumber = 0;

  int get nonNullableNumber => _nonNullableNumber;

  // You can indicate that the evaluation of an expression
  // should throw an error if it evaluates to null but
  // shouldn't.
  throwErrorWhenParameterIsNull(var expression) {
    _nonNullableNumber = expression!;
  }

  // If you’re sure that a variable is set before it’s used,
  // but Dart disagrees, you can fix the error by marking the variable as late
  late String message;

  String initializeMessage() {
    message = 'Hello ';
    return message;
  }

  // If you fail to initialize a late variable,
  // a runtime error occurs when the variable is used.
  String appendToMessage(String anotherMessage) {
    return message + anotherMessage;
  }

  // Another example when to use lazy init:
  // If the temperature variable is never used,
  // then the expensive _readThermometer() function is never called
  late String veryVeryHighCost = _veryVeryHighCostFunction(); // Lazily initialized.

  _veryVeryHighCostFunction() {
    return 'Very very high cost';
  }

}