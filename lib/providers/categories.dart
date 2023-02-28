import 'package:flutter/material.dart';
import 'category_outline.dart';

class Categories with ChangeNotifier {
  List<CategoryOutline> _items = [
    CategoryOutline(
        id: '3',
        imageUrl:
            'https://media.istockphoto.com/id/1442689861/photo/old-fort-house-with-autumnal-trees-and-a-green-field-on-a-sunny-day.jpg?b=1&s=170667a&w=0&k=20&c=uMtOglJx-1QEh7MzG3Z2WaCXOD8bJKi6GEux5rZHe88=',
        type: 'House',
        amount: 23000,
        sqft: 7890,
        address: 'T.Nagar, Chennai',
        bathRooms: 2,
        bedRooms: 4,
        garage: 2,
        isFavorite: true),
    CategoryOutline(
        id: '3',
        imageUrl:
            'https://media.istockphoto.com/id/985417344/photo/emerging-residential-area.jpg?s=612x612&w=0&k=20&c=53BK584e1xFwr3ylx_WqQcVp7CbWmsaGxFZ8lqtSgbM=',
        type: 'House',
        amount: 23000,
        sqft: 7890,
        address: 'Chennai',
        bathRooms: 3,
        bedRooms: 2,
        garage: 2,
        isFavorite: true),
    CategoryOutline(
        id: '3',
        imageUrl:
            'https://media.istockphoto.com/id/483773209/photo/new-cozy-cottage.jpg?s=612x612&w=0&k=20&c=y1rwmoHBg-ZoE7L5WkIWjrTmwXofzqIbozTJyftDu1E=',
        type: 'House',
        amount: 56000,
        sqft: 890,
        address: 'Nehru nagar, pondy',
        bathRooms: 3,
        bedRooms: 4,
        garage: 0,
        isFavorite: true),
    CategoryOutline(
        id: '3',
        imageUrl:
            'https://media.istockphoto.com/id/1442689861/photo/old-fort-house-with-autumnal-trees-and-a-green-field-on-a-sunny-day.jpg?b=1&s=170667a&w=0&k=20&c=uMtOglJx-1QEh7MzG3Z2WaCXOD8bJKi6GEux5rZHe88=',
        type: 'House',
        amount: 23000,
        sqft: 7890,
        address: 'T.Nagar, Chennai',
        bathRooms: 2,
        bedRooms: 4,
        garage: 2,
        isFavorite: true),
    CategoryOutline(
        id: '3',
        imageUrl:
            'https://media.istockphoto.com/id/985417344/photo/emerging-residential-area.jpg?s=612x612&w=0&k=20&c=53BK584e1xFwr3ylx_WqQcVp7CbWmsaGxFZ8lqtSgbM=',
        type: 'House',
        amount: 23000,
        sqft: 7890,
        address: 'Chennai',
        bathRooms: 3,
        bedRooms: 2,
        garage: 2,
        isFavorite: true),
    CategoryOutline(
        id: '3',
        imageUrl:
            'https://media.istockphoto.com/id/483773209/photo/new-cozy-cottage.jpg?s=612x612&w=0&k=20&c=y1rwmoHBg-ZoE7L5WkIWjrTmwXofzqIbozTJyftDu1E=',
        type: 'House',
        amount: 56000,
        sqft: 890,
        address: 'Nehru nagar, pondy',
        bathRooms: 3,
        bedRooms: 4,
        garage: 0,
        isFavorite: true),
  ];

  List<CategoryOutline> get items {
    return [..._items];
  }

  CategoryOutline findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
    // return _items.firstWhere((element) => element.id == id);
  }

  void addCategory() {
    //_items.add(value);
    notifyListeners();
  }
}
