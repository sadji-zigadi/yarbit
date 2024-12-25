import 'package:client/features/home/domain/entities/category_entity.dart';
import 'package:flutter/material.dart';

getCategoryIcon({
  required CategoryEntity category,
  required double size,
}) {
  return switch (category.name) {
    'Électricité' => Image.asset(
        'assets/icons/electricite.png',
        width: size,
        height: size,
      ),
    'Plomberie' => Image.asset(
        'assets/icons/plomberie.png',
        width: size,
        height: size,
      ),
    'Réparation électro' => Image.asset(
        'assets/icons/reparation.png',
        width: size,
        height: size,
      ),
    'Finition' => Image.asset(
        'assets/icons/finition.png',
        width: size,
        height: size,
      ),
    'Nettoyage' => Image.asset(
        'assets/icons/nettoyage.png',
        width: size,
        height: size,
      ),
    _ => Image.asset(
        'assets/icons/electricite.png',
        width: size,
        height: size,
      ),
  };
}
