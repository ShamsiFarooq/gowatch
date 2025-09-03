/*
📱 App Overview
A simple Flutter app to explore movies using the TMDB (The Movie Database) API (free
and open).
The app will have 4–5 screens including a splash, list, search,Booking Screen and details.

🔹 Features & Screens
1. Splash Screen
○ App logo with a small animation.
○ Navigates to home after 2 seconds.
2. Home Screen & Listing (Movies List)
○ Search bar for entering a movie title.
○ Fetch movies from OMDb API.
○ Display results in a scrollable list/grid with:
i. Poster (or placeholder if not available)
ii. Title
iii. Year
○ Pagination support (page=1,2,3...) since OMDb only returns 10 results
per page.
3. Movie Details Screen
○ On tapping a movie, navigate to details.
○ Show movie Poster (if available), title,Year, Genre, Director, IMDb Rating,
○ Book a movie by choosing a date and time

4. Booking Screen
○ Show the informations selected in booking, and a Bar code

🔹 API Endpoints (TMDB Free API)
● List Movies:
https://omdbapi.com/?apikey=YOUR_KEY&s=avengers&page=1

● Movie Details
https://www.omdbapi.com/?apikey=YOUR_KEY&i=tt0848228&plot=full






 */

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gowatch/features/movie/model/movie_summary.dart';
import 'package:gowatch/features/movie/provider/search_provider.dart';
import 'package:gowatch/features/movie/views/widgets/moviecard.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();
  final _scroll = ScrollController();

  @override
  void initState() {
    super.initState();
    final p = context.read<SearchProvider>();
    p.initialLoad();
    _scroll.addListener(() {
      if (_scroll.position.pixels > _scroll.position.maxScrollExtent - 300) {
        p.fetchNext();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final p = context.watch<SearchProvider>();
    return Scaffold(
      appBar: AppBar(title: const Text('Discover Movies')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                
                prefixIcon: Icon(Icons.search),
                hintText: 'Search movie ',
                border: OutlineInputBorder(
                  
                  
                  borderRadius: BorderRadius.all(Radius.circular(30),),
                  
                ),
              ),
              onChanged: p.onQueryChanged,
              onSubmitted: p.onQueryChanged,
            ),
          ),
          Expanded(
            child: Builder(
              builder: (_) {
                if (p.loading && p.items.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (p.items.isEmpty) {
                  return const Center(child: Text('No movies found'));
                }
                return RefreshIndicator(
                  onRefresh: () => p.initialLoad(),
                  child: ListView.separated(
                    controller: _scroll,
                    itemCount: p.items.length + (p.isLastPage ? 0 : 1),
                    separatorBuilder: (_, __) => const SizedBox(height: 6),
                    itemBuilder: (ctx, i) {
                      if (i >= p.items.length) {
                        return const Padding(
                          padding: EdgeInsets.all(16),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                      final MovieSummary m = p.items[i];
                      return MovieCard(
                        movie: m,
                        onTap: () => context.push('/movie/${m.imdbID}'),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const _BottomBar(),
    );
  }
}

class _BottomBar extends StatelessWidget {
  const _BottomBar();

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      destinations: const [
        NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
                NavigationDestination(icon: Icon(Icons.search), label: 'Find'),

        NavigationDestination(
          icon: Icon(Icons.save),
          label: 'Saved',
        ),
        NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
      ],
      selectedIndex: 0,
      onDestinationSelected: (_) {},
    );
  }
}
