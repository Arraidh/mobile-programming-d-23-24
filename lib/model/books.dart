final String tableBooks = 'Books';

class BookFields {
  static final List<String> values = [
    /// Add all fields
    id, isImportant, number, title, image,  description, time
  ];

  static final String id = '_id';
  static final String isImportant = 'isImportant';
  static final String number = 'number';
  static final String title = 'title';
  static final String image = 'image';
  static final String description = 'description';
  static final String time = 'time';
}

class Book {
  final int? id;
  final bool isImportant;
  final int number;
  final String title;
  final String image;
  final String description;
  final DateTime createdTime;

  const Book({
    this.id,
    required this.isImportant,
    required this.number,
    required this.title,
    required this.image,
    required this.description,
    required this.createdTime,
  });

  Book copy({
    int? id,
    bool? isImportant,
    int? number,
    String? title,
    String? image,
    String? description,
    DateTime? createdTime,
  }) =>
      Book(
        id: id ?? this.id,
        isImportant: isImportant ?? this.isImportant,
        number: number ?? this.number,
        title: title ?? this.title,
        image: image ?? this.image,
        description: description ?? this.description,
        createdTime: createdTime ?? this.createdTime,
      );

  static Book fromJson(Map<String, Object?> json) => Book(
    id: json[BookFields.id] as int?,
    isImportant: json[BookFields.isImportant] == 1,
    number: json[BookFields.number] as int,
    title: json[BookFields.title] as String,
    image: json[BookFields.image] as String,
    description: json[BookFields.description] as String,
    createdTime: DateTime.parse(json[BookFields.time] as String),
  );

  Map<String, Object?> toJson() => {
    BookFields.id: id,
    BookFields.title: title,
    BookFields.image: image,
    BookFields.isImportant: isImportant ? 1 : 0,
    BookFields.number: number,
    BookFields.description: description,
    BookFields.time: createdTime.toIso8601String(),
  };
}
