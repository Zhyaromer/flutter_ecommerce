class TopBrands {
  final int brandId;
  final String name;
  final String imageUrl;

  TopBrands({required this.brandId, required this.name, required this.imageUrl});
}

final List<TopBrands> brandList = [
  TopBrands(
    brandId: 1,
    name: 'Adidas',
    imageUrl: 'https://logos-world.net/wp-content/uploads/2020/04/Adidas-Logo-700x394.png',
  ),
  TopBrands(
    brandId: 2,
    name: 'Nike',
    imageUrl: 'https://acdn-us.mitiendanube.com/stores/006/133/691/products/nike-logo-24edf4f26f5a40025b17503629706845-1024-1024.webp',
  ),
  TopBrands(
    brandId: 3,
    name: 'Puma',
    imageUrl: 'https://logos-world.net/wp-content/uploads/2020/04/Puma-Logo-700x394.png',
  ),
  TopBrands(
    brandId: 4,
    name: 'Reebok',
    imageUrl: 'https://logos-world.net/wp-content/uploads/2020/04/Reebok-Logo-700x394.png',
  ),
  TopBrands(
    brandId: 5,
    name: 'Under Armour',
    imageUrl: 'https://logos-world.net/wp-content/uploads/2020/04/Under-Armour-Logo-700x394.png',
  ),
  TopBrands(
    brandId: 6,
    name: 'Asics',
    imageUrl: 'https://images.seeklogo.com/logo-png/30/2/asics-logo-png_seeklogo-305773.png',
  ),
  TopBrands(
    brandId: 7,
    name: 'Fila',
    imageUrl: 'https://images.seeklogo.com/logo-png/53/2/fila-logo-png_seeklogo-537116.png',
  ),
  TopBrands(
    brandId: 8,
    name: 'New Balance',
    imageUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/ea/New_Balance_logo.svg/1280px-New_Balance_logo.svg.png',
  ),
];
