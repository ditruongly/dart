var name = 'Voyager I';
var year = 1977;
var antennaDiameter = 3.7;
var flybyObjects = ['Jupiter', 'Saturn', 'Uranus', 'Neptune'];
var image = {
  'tags': ['saturn'],
  'url': '//path/to/saturn.jpg'
};

int fibonacci(int n) {
  if (n == 0 || n == 1) return n;
  return fibonacci(n - 1) + fibonacci(n - 2);
}

fn({bool bold = false, bool hidden = false}) {
  print(bold);
  print(hidden);
}

int incr(int a) => a + 1;

class Point {

  var x, y;

  Point.fromJson(Map jsonMap):
        x = jsonMap['x'],
        y = jsonMap['y'];
  
}

void main(List<String> arguments) {

  var point = Point.fromJson({'x': 0, 'y': 1 });

  print(point.x);
  print(point.y);

  const value = null;
  var a = value ?? 0;
  print(a);

  print(incr(1));

  fn();

  if (year >= 2001) {
    print('21st century');
  } else if (year >= 1901) {
    print('20th century');
  }

  for (final object in flybyObjects) {
    print(object);
  }

  for (int month = 1; month <= 12; month++) {
    print(month);
  }

  while (year < 2016) {
    year += 1;
  }

  print('Hello world!');

  var result = fibonacci(20);
  print(result);
  flybyObjects.where((name) => name.contains('turn')).forEach(print);

  var voyager = Spacecraft('Voyager I', DateTime(1977, 9, 5));
  voyager.describe();
  print(voyager.launchDate);

  var voyager3 = Spacecraft.unlaunched('Voyager III');
  voyager3.describe();
  print(voyager3.launchYear);

  var pilotedCraft = PilotedCraft("Di", DateTime(1977, 9, 5));
  pilotedCraft.describeCrew();
}

class PilotedCraft extends Spacecraft with Piloted {
  PilotedCraft(String name, DateTime? launchDate) : super(name, launchDate);
}

mixin Piloted {
  int astronauts = 1;

  void describeCrew() {
    print('Number of astronauts: $astronauts');
  }
}

class Spacecraft {

  int astronauts = 0;
  String name;
  DateTime? launchDate;

  // Read-only non-final property
  int? get launchYear => launchDate?.year;

  // Constructor, with syntactic sugar for assignment to members.
  Spacecraft(this.name, this.launchDate) {
    // Initialization code goes here.
  }

  // Named constructor that forwards to the default one.
  Spacecraft.unlaunched(String name) : this(name, null);

  // Method.
  void describe() {
    print('Spacecraft: $name');
    // Type promotion doesn't work on getters.
    var launchDate = this.launchDate;
    if (launchDate != null) {
      int years =
          DateTime.now().difference(launchDate).inDays ~/ 365;
      print('Launched: $launchYear ($years years ago)');
    } else {
      print('Unlaunched');
    }
  }
}