import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'dart:math';
import '../../core/anime_provider.dart';
import '../../domain/models/anime.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_text_field.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _genre = '';
  double _rating = 0.0;
  String _description = '';
  String _imageUrl = '';

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      
      final newAnime = Anime(
        id: Random().nextInt(10000).toString(),
        title: _title,
        genre: _genre,
        rating: _rating,
        description: _description,
        imageUrl: _imageUrl,
      );

      Provider.of<AnimeProvider>(context, listen: false).addAnime(newAnime);
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Anime "$_title" ajouté avec succès !')),
      );
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Ajouter un Anime'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              CustomTextField(
                label: 'Titre',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un titre';
                  }
                  return null;
                },
                onSaved: (value) => _title = value!,
              ),
              CustomTextField(
                label: 'Genre',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer un genre';
                  }
                  return null;
                },
                onSaved: (value) => _genre = value!,
              ),
              CustomTextField(
                label: 'Note (0-10)',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer une note';
                  }
                  final rating = double.tryParse(value);
                  if (rating == null || rating < 0 || rating > 10) {
                    return 'La note doit être entre 0 et 10';
                  }
                  return null;
                },
                onSaved: (value) => _rating = double.parse(value!),
              ),
              CustomTextField(
                label: 'URL de l\'image (Optionnel)',
                onSaved: (value) {
                  if (value != null && value.isNotEmpty) {
                    _imageUrl = value;
                  }
                },
              ),
              CustomTextField(
                label: 'Description',
                validator: (value) {
                  if (value == null || value.length < 10) {
                    return 'La description doit faire au moins 10 caractères';
                  }
                  return null;
                },
                onSaved: (value) => _description = value!,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Enregistrer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
