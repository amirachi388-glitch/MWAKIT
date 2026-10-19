import 'package:flutter/material.dart';

void main() {
  runApp(const MovieApp());
}

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'موقع الأفلام',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.redAccent,
        scaffoldBackgroundColor: const Color(0xFF141414), // لون خلفية داكن
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF141414),
          elevation: 0,
        ),
      ),
      home: const HomePage(),
    );
  }
}

// ========================
// البيانات الوهمية (الافلام)
// ========================
class Movie {
  final String title;
  final String imageUrl;
  final String rating;

  Movie({required this.title, required this.imageUrl, required this.rating});
}

final List<Movie> dummyMovies = [
  Movie(
    title: 'Inception',
    imageUrl: 'https://image.tmdb.org/t/p/w500/9gk7O0w6J6uH5o5y6y6y6y6y6y6.jpg', // ضع رابط صورة حقيقي هنا
    rating: '8.8',
  ),
  Movie(
    title: 'Interstellar',
    imageUrl: 'https://image.tmdb.org/t/p/w500/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg',
    rating: '8.6',
  ),
  Movie(
    title: 'The Dark Knight',
    imageUrl: 'https://image.tmdb.org/t/p/w500/qJ2tW6WMUDux911r6m7haRef0WH.jpg',
    rating: '9.0',
  ),
  Movie(
    title: 'Avatar',
    imageUrl: 'https://image.tmdb.org/t/p/w500/kyeqWdyUXW608qlYkRqosgbbJyK.jpg',
    rating: '7.8',
  ),
];

// ========================
// الصفحة الرئيسية
// ========================
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'أفلامي',
          style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // قسم الأفلام الشائعة (أفقي)
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'الأفلام الأكثر شعبية',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 250,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: dummyMovies.length,
                itemBuilder: (context, index) {
                  return MovieCard(movie: dummyMovies[index]);
                },
              ),
            ),
            
            // قسم الشبكة (أفلام مقترحة)
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'أضيف حديثاً',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: dummyMovies.length,
              itemBuilder: (context, index) {
                return MovieCard(movie: dummyMovies[index], isGrid: true);
              },
            ),
          ],
        ),
      ),
    );
  }
}

// ========================
// كارت الفيلم (شكل البوستر)
// ========================
class MovieCard extends StatelessWidget {
  final Movie movie;
  final bool isGrid;

  const MovieCard({super.key, required this.movie, this.isGrid = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isGrid ? double.infinity : 150,
      margin: isGrid ? EdgeInsets.zero : const EdgeInsets.only(left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                movie.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                // في حال فشل تحميل الصورة
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[800],
                    child: const Icon(Icons.movie, color: Colors.white, size: 50),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            movie.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 16),
              const SizedBox(width: 4),
              Text(movie.rating, style: TextStyle(color: Colors.grey[400])),
            ],
          ),
        ],
      ),
    );
  }
}