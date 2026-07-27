import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../core/anime_provider.dart';
import '../../domain/models/anime.dart';
import '../widgets/custom_app_bar.dart';

class DetailScreen extends StatelessWidget {
  final Anime anime;

  const DetailScreen({super.key, required this.anime});

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmer la suppression'),
          content: Text('Voulez-vous vraiment supprimer "${anime.title}" ?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                Provider.of<AnimeProvider>(context, listen: false).deleteAnime(anime.id);
                Navigator.of(context).pop(); // Ferme le dialogue
                context.pop(); // Retourne à l'écran précédent
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('"${anime.title}" a été supprimé.')),
                );
              },
              child: const Text('Supprimer', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: anime.title,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.redAccent),
            onPressed: () => _showDeleteConfirmation(context),
            tooltip: 'Supprimer cet anime',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: anime.id,
              child: anime.imageUrl.startsWith('http')
                  ? Image.network(
                      anime.imageUrl,
                      width: double.infinity,
                      height: 300,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const SizedBox(
                        height: 300,
                        child: Center(child: Icon(Icons.error, size: 100)),
                      ),
                    )
                  : Image.asset(
                      anime.imageUrl,
                      width: double.infinity,
                      height: 300,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const SizedBox(
                        height: 300,
                        child: Center(child: Icon(Icons.error, size: 100)),
                      ),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        anime.genre,
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber),
                          Text(
                            anime.rating.toString(),
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Synopsis',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    anime.description,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 24),
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.play_arrow),
                      label: const Text('Regarder maintenant'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
