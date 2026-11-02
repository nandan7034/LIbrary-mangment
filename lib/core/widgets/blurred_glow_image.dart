import 'dart:ui';
import 'package:flutter/material.dart';

class BlurredGlowImage extends StatelessWidget {
  final String imageUrl;

  const BlurredGlowImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // 1. Background Blur Layer (Scaled Up)
            Positioned.fill(
              child: Transform.scale(
                scale:
                    1.0, // Scales up slightly to extend the "glow" beyond the foreground edges
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(
                    sigmaX: 30.0, // Horizontal blur intensity
                    sigmaY: 30.0, // Vertical blur intensity
                  ),
                  child: Image.network(
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 240,
                        height: 320,
                        child: Center(child: Icon(Icons.image_not_supported)),
                      );
                    },
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            // 2. Subtle Dark/Light Overlay (Optional: improves contrast and depth)
            Positioned.fill(
              child: Container(color: Colors.black.withOpacity(0.1)),
            ),

            // 3. Crisp Foreground Image Layer
            ClipRRect(
              // Rounded corners for a modern look
              child: Image.network(
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 240,
                    height: 320,
                    child: Center(
                      child: Icon(
                        Icons.image_not_supported,
                        color: Colors.white,
                      ),
                    ),
                  );
                },
                imageUrl,
                width: 240,
                // height: 320,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
