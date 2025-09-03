
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

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome to the Home Page!'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/second');
              },
              child: const Text('Go to Second Page'),
            ),
          ],
        ),
      ),
    );
    
  }
}