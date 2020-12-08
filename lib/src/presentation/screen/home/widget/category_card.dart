import 'package:flutter/material.dart';

import '../../../resources.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.label,
    required this.color,
    required this.shadowColor,
  }) : super(key: key);

  final String label;
  final Color color;
  final Color shadowColor;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final cardRadius = BorderRadius.circular(15.0);
      final width = constraints.maxWidth;
      final height = constraints.maxHeight;

      final shadowWidth = width * 0.85;

      return Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: (width - shadowWidth) / 2,
            right: (width - shadowWidth) / 2,
            bottom: 0.0,
            child: _CategoryCardShadow(
              width: shadowWidth,
              height: height * 0.2,
              cardRadius: cardRadius,
              color: shadowColor,
            ),
          ),
          _CategoryCardContents(
            label: label,
            color: color,
            width: width,
            height: height,
            cardRadius: cardRadius,
          ),
        ],
      );
    });
  }
}

class _CategoryCardContents extends StatelessWidget {
  const _CategoryCardContents({
    Key? key,
    required this.label,
    required this.color,
    this.width,
    this.height,
    this.cardRadius,
  }) : super(key: key);

  final String label;
  final Color color;

  final double? width;
  final double? height;
  final BorderRadius? cardRadius;

  @override
  Widget build(BuildContext context) {
    final decorationSize = height == null ? 62.0 : height! * 1.03;
    final pokeBallSize = height == null ? 83.0 : height! * 1.38;

    return ClipRRect(
      borderRadius: cardRadius,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: cardRadius,
          color: color,
        ),
        child: Stack(
          children: [
            Positioned(
              left: decorationSize * -0.52,
              top: decorationSize * -0.60,
              child: Container(
                width: decorationSize,
                height: decorationSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: R.color.white.withOpacity(0.3),
                ),
              ),
            ),
            Positioned(
              top: -pokeBallSize,
              bottom: -pokeBallSize,
              right: pokeBallSize * -0.16,
              child: Image.asset(
                R.image.pokeball,
                width: pokeBallSize,
                height: pokeBallSize,
                color: R.color.white.withOpacity(0.3),
              ),
            ),
            Positioned.fill(
              left: width == null ? 16.0 : width! * 0.11,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  label,
                  style: TextStyle(
                    color: R.color.white,
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryCardShadow extends StatelessWidget {
  const _CategoryCardShadow({
    Key? key,
    required this.color,
    this.width,
    this.height,
    this.cardRadius,
  }) : super(key: key);
  final Color color;
  final double? width;
  final double? height;
  final BorderRadius? cardRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: cardRadius,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, (height ?? 0) * 0.25),
            color: color,
            blurRadius: 15.0,
          ),
        ],
      ),
    );
  }
}
