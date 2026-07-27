import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../core/anime_provider.dart';
import '../widgets/anime_card.dart';
import '../widgets/custom_app_bar.dart';

class HomeScreen extends StatefulWidget {
  final String title;

  const HomeScreen({super.key, required this.title});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final animeProvider = Provider.of<AnimeProvider>(context);
    final filteredAnimes = animeProvider.searchAnimes(_searchQuery);
    final isTablet = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      appBar: CustomAppBar(
        title: widget.title,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/form'),
            mouseCursor: SystemMouseCursors.click,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Rechercher un anime ou genre...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          Expanded(
            child: animeProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : filteredAnimes.isEmpty
                    ? const Center(child: Text('Aucun anime trouvé'))
                    : LayoutBuilder(
                    builder: (context, constraints) {
                      if (isTablet) {
                        return GridView.builder(
                          padding: const EdgeInsets.all(8),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 0.7,
                          ),
                          itemCount: filteredAnimes.length,
                          itemBuilder: (context, index) => AnimeCard(
                            anime: filteredAnimes[index],
                            onTap: () => context.push('/detail', extra: filteredAnimes[index]),
                          ),
                        );
                      } else {
                        return ListView.builder(
                          itemCount: filteredAnimes.length,
                          itemBuilder: (context, index) => SizedBox(
                            height: 250,
                            child: AnimeCard(
                              anime: filteredAnimes[index],
                              onTap: () => context.push('/detail', extra: filteredAnimes[index]),
                            ),
                          ),
                        );
                      }
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
