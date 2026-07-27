# Animes World - Flutter Multi-Screen App

Une application Flutter moderne présentant un catalogue d'animes, mettant en œuvre la navigation avancée, la gestion d'état et un design responsive.

## 🚀 Fonctionnalités

- **4 Écrans Distincts** :
  - `Accueil` : Catalogue complet avec recherche et filtrage dynamique.
  - `Détails` : Vue approfondie de chaque anime avec paramètres passés via la route.
  - `Contact` : Formulaire complet avec validation en temps réel.
  - `Paramètres` : Personnalisation de l'expérience utilisateur.
- **Navigation Nommée** : Utilisation de `GoRouter` pour une gestion fluide des routes.
- **Gestion du Thème** : Support complet des modes **Clair** et **Sombre**.
- **Design Responsive** : L'interface s'adapte intelligemment aux mobiles, tablettes et ordinateurs (ListView vs GridView).
- **Persistance & Données** : Chargement asynchrone des données depuis un fichier JSON (`assets/data/animes.json`).

## 🛠 Architecture & Technique

- **State Management** : `Provider` pour la gestion réactive de l'état (Animes et Thème).
- **Widgets Réutilisables** :
  - `CustomAppBar` : Barre de navigation unifiée.
  - `AnimeCard` : Composant intelligent s'adaptant à la taille du conteneur.
  - `CustomTextField` : Abstraction de TextFormField pour une cohérence visuelle.
- **Widgets Utilisés (+8)** : `ListView`, `GridView`, `Stack`, `Hero`, `Card`, `LayoutBuilder`, `InkWell`, `ElevatedButton`, `Form`, etc.
- **Tests** : Suite de tests automatisés couvrant la navigation, la recherche et la validation de formulaire.

## 📦 Installation

1. S'assurer d'avoir Flutter installé sur votre machine.
2. Cloner le projet.
3. Exécuter la commande suivante pour récupérer les dépendances :
   ```bash
   flutter pub get
   ```
4. Lancer l'application :
   ```bash
   flutter run
   ```

## 🧪 Tests

Pour lancer les tests automatisés :
```bash
flutter test
```

---
*Projet réalisé dans le cadre de l'apprentissage de Flutter.*
