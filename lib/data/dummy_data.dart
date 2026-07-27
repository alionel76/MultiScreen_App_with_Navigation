import '../domain/models/anime.dart';

final List<Anime> dummyAnimes = [
  Anime(
    id: '1',
    title: 'One Piece',
    description: 'L\'histoire suit les aventures de Monkey D. Luffy, un garçon dont le corps a acquis les propriétés du caoutchouc après avoir mangé par mégarde un fruit du démon.',
    imageUrl: 'assets/images/one_piece.jpg',
    rating: 9.0,
    genre: 'Aventure',
  ),
  Anime(
    id: '2',
    title: 'Naruto',
    description: 'Naruto Uzumaki, un jeune ninja qui cherche la reconnaissance de ses pairs et rêve de devenir le Hokage.',
    imageUrl: 'assets/images/naruto.jpg',
    rating: 8.5,
    genre: 'Action',
  ),
  Anime(
    id: '3',
    title: 'Attack on Titan',
    description: 'Dans un monde où l\'humanité vit à l\'intérieur de villes entourées de trois murs énormes qui les protègent des Titans.',
    imageUrl: 'assets/images/aot.jpg',
    rating: 9.5,
    genre: 'Drame',
  ),
];
