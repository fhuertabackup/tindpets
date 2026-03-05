
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFFFF5864);
  static const Color darkBase = Color(0xFF0F0F12);
  
  static ThemeData get immersiveTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: primaryColor,
        surface: Colors.transparent,
      ),
      scaffoldBackgroundColor: Colors.black,
      textTheme: GoogleFonts.outfitTextTheme(ThemeData.dark().textTheme),
    );
  }
}

class GlassContainer extends StatelessWidget {
  final Widget child;
  final double blur;
  final double opacity;
  final double borderRadius;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final BoxShape shape;

  const GlassContainer({
    super.key,
    required this.child,
    this.blur = 20.0,
    this.opacity = 0.08,
    this.borderRadius = 20.0,
    this.color,
    this.padding,
    this.shape = BoxShape.rectangle,
  });

  @override
  Widget build(BuildContext context) {
    if (shape == BoxShape.circle) {
      return ClipOval(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: _buildContainer(),
        ),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: _buildContainer(),
      ),
    );
  }

  Widget _buildContainer() {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        shape: shape,
        color: (color ?? Colors.white).withOpacity(opacity),
        borderRadius: shape == BoxShape.circle ? null : BorderRadius.circular(borderRadius),
        border: Border.all(
          color: Colors.white.withOpacity(0.05),
          width: 1.0,
        ),
      ),
      child: child,
    );
  }
}
