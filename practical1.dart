//D23IT159

import 'dart:io';

void main() {
  print("Enter your name:");
  String name = stdin.readLineSync()!;

  print("Enter your age:");
  int age = int.parse(stdin.readLineSync()!);

  print("Enter your favorite color:");
  String favoriteColor = stdin.readLineSync()!;

  print(age < 18
      ? "Hello $name! You're a teenager!"
      : "Hello $name! You're an adult!");

  const maxAge = 100;
  List userList = [name, age, favoriteColor];
  Set userSet = {name, favoriteColor};
  Map<String, dynamic> userMap = {
    'name': name,
    'age': age,
    'color': favoriteColor
  };

  print("\nData as List: $userList");
  print("Data as Set: $userSet");
  print("Data as Map: $userMap");

  print("\nYears left to max age: ${maxAge - age}");
}
