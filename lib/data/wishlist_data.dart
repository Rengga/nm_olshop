class WishlistData {
  static List<Map<String, dynamic>> wishlistItems = [];

  static void addToWishlist(Map<String, dynamic> product) {
    if (!isInWishlist(product)) {
      wishlistItems.add(product);
    }
  }

  static void removeFromWishlist(Map<String, dynamic> product) {
    wishlistItems.removeWhere((item) => item["id"] == product["id"]);
  }

  static bool isInWishlist(Map<String, dynamic> product) {
    return wishlistItems.any((item) => item["id"] == product["id"]);
  }
}
