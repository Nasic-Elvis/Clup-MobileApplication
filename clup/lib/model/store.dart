class Store {
  final int idStore;
  final String name;
  final String city;
  final int booktableCapacity;
  final int capacity;
  final String imageUrl;
  final String iconUrl;
  final String address;
  final double rating;
  final double latitude;
  final double longitude;
  final bool isFavourite;
  final String telephoneNumber;
  final String category;
  bool pref;
  Store(
      this.idStore,
      this.name,
      this.city,
      this.booktableCapacity,
      this.capacity,
      this.imageUrl,
      this.iconUrl,
      this.address,
      this.rating,
      this.latitude,
      this.longitude,
      this.isFavourite,
      this.telephoneNumber,
      this.category,
      this.pref);
}
