abstract class FavoritesEvent {}

class GetFavorites extends FavoritesEvent {}

class AddFavorites extends FavoritesEvent {
  final int idStore;
  final String name;
  AddFavorites(this.idStore, this.name);
}

class RemoveFavorites extends FavoritesEvent {
  final int idStore;
  final String name;
  RemoveFavorites(this.idStore, this.name);
}
