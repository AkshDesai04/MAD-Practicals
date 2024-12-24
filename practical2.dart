import 'dart:async';
import 'dart:io';

abstract class User {
  void displayUserType();
}

class Member extends User {
  @override
  void displayUserType() {
    print("User Type: Member");
  }
}

class Book {
  String title;
  String author;
  int yearPublished;
  bool isAvailable;

  Book(this.title, this.author, this.yearPublished, this.isAvailable);

  String get details =>
      "Title: $title, Author: $author, Year: $yearPublished, Available: $isAvailable";

  void displayDetails() {
    print(details);
  }
}

class EBook extends Book {
  double fileSize;

  EBook(String title, String author, int yearPublished, bool isAvailable,
      this.fileSize)
      : super(title, author, yearPublished, isAvailable);

  @override
  void displayDetails() {
    print("$details, File Size: ${fileSize.toStringAsFixed(2)} MB");
  }
}

class Library {
  List<Book> books;

  Library(this.books);

  void addBook(Book book) {
    books.add(book);
    print("Book added: ${book.title}");
  }

  void borrowBook(String title) {
    try {
      Book book = books.firstWhere((b) => b.title == title && b.isAvailable);
      book.isAvailable = false;
      print("You borrowed: ${book.title}");
    } catch (e) {
      print("Error: Book not available or not found.");
    }
  }

  void returnBook(String title) {
    try {
      Book book = books.firstWhere((b) => b.title == title && !b.isAvailable);
      book.isAvailable = true;
      print("You returned: ${book.title}");
    } catch (e) {
      print("Error: Book not borrowed or not found.");
    }
  }

  Future<void> listBooks() async {
    await Future.delayed(Duration(seconds: 1));
    if (books.isEmpty) {
      print("No books in the library.");
    } else {
      books.forEach((book) => book.displayDetails());
    }
  }

  static int totalBooks(List<Book> books) {
    return books.length;
  }
}

void main() {
  List<Book> initialBooks = [
    Book("Book A", "Author A", 2020, true),
    EBook("EBook B", "Author B", 2021, true, 5.5)
  ];
  Library library = Library(initialBooks);

  while (true) {
    print("\nLibrary Menu:");
    print("1. Add a new book");
    print("2. Borrow a book");
    print("3. Return a book");
    print("4. List all books");
    print("5. Exit");

    String? choice = stdin.readLineSync();
    switch (choice) {
      case "1":
        print("Enter title:");
        String? title = stdin.readLineSync();
        print("Enter author:");
        String? author = stdin.readLineSync();
        print("Enter year published:");
        int year = int.parse(stdin.readLineSync()!);
        print("Is it available? (yes/no):");
        bool isAvailable = stdin.readLineSync()!.toLowerCase() == 'yes';
        library.addBook(Book(title!, author!, year, isAvailable));
        break;
      case "2":
        print("Enter the title of the book to borrow:");
        String? borrowTitle = stdin.readLineSync();
        library.borrowBook(borrowTitle!);
        break;
      case "3":
        print("Enter the title of the book to return:");
        String? returnTitle = stdin.readLineSync();
        library.returnBook(returnTitle!);
        break;
      case "4":
        print("Listing books...");
        library.listBooks();
        break;
      case "5":
        print("Exiting...");
        return;
      default:
        print("Invalid option. Try again.");
    }
  }
}
