import 'package:flutter/material.dart';
import 'package:grocery_app/core/services/favorites_service.dart';
import 'package:grocery_app/core/theme/app_colors.dart';
import 'package:grocery_app/features/categories/data/models/product_model.dart';

class CustomFavoriteButton extends StatefulWidget {
  final ProductModel product;
  final VoidCallback? onFavoriteChanged;

  const CustomFavoriteButton({
    super.key,
    required this.product,
    this.onFavoriteChanged,
  });

  @override
  State<CustomFavoriteButton> createState() => _CustomFavoriteButtonState();
}

class _CustomFavoriteButtonState extends State<CustomFavoriteButton> {
  late Future<bool> _isFavoriteFuture;
  final FavoritesService _favoritesService = FavoritesService();

  @override
  void initState() {
    super.initState();
    _checkIfFavorite();
  }

  void _checkIfFavorite() {
    _isFavoriteFuture = _favoritesService.isProductInFavorites(
      widget.product.id,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _isFavoriteFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Icon(
            Icons.favorite_border,
            color: AppColors.primaryOrange,
          );
        }

        if (snapshot.hasError) {
          // If there's an error, show the default (not favorite) state
          return IconButton(
            icon: const Icon(
              Icons.favorite_border,
              color: AppColors.primaryOrange,
            ),
            onPressed: _toggleFavorite,
          );
        }

        final isFavorite = snapshot.data ?? false;
        return IconButton(
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: isFavorite
                ? AppColors.primaryOrange
                : AppColors.primaryOrange,
          ),
          onPressed: _toggleFavorite,
        );
      },
    );
  }

  void _toggleFavorite() async {
    try {
      final isCurrentlyFavorite = await _isFavoriteFuture;

      if (isCurrentlyFavorite) {
        await _favoritesService.removeProductFromFavorites(widget.product.id);
      } else {
        await _favoritesService.addProductToFavorites(widget.product);
      }

      // Refresh the favorite status
      setState(() {
        _isFavoriteFuture = _favoritesService.isProductInFavorites(
          widget.product.id,
        );
      });

      // Notify parent widget if callback is provided
      if (widget.onFavoriteChanged != null) {
        widget.onFavoriteChanged!();
      }
    } catch (e) {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to update favorite status'),
          backgroundColor: AppColors.errorRed,
        ),
      );
    }
  }
}
