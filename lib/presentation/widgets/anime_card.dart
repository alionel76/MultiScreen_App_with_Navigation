import 'package:flutter/material.dart';
import '../../domain/models/anime.dart';

class AnimeCard extends StatelessWidget {
  final Anime anime;
  final VoidCallback onTap;

  const AnimeCard({super.key, required this.anime, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(8),
      child: InkWell(
        onTap: onTap,
        mouseCursor: SystemMouseCursors.click,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                    child: anime.imageUrl.startsWith('http')
                        ? Image.network(
                            anime.imageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => const Center(child: Icon(Icons.error)),
                          )
                        : Image.asset(
                            anime.imageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => const Center(child: Icon(Icons.error)),
                          ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            anime.rating.toString(),
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    anime.title,
                    style: Theme.of(context).textTheme.titleMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(anime.genre, style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
