import 'package:go_router/go_router.dart';
import 'package:gowatch/features/movie/views/view/booking_page.dart';
import 'package:gowatch/features/movie/views/view/home_page.dart';
import 'package:gowatch/features/movie/views/view/movie_details_page.dart';
import 'package:gowatch/features/movie/views/view/splash_page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const SplashPage()),
    GoRoute(path:   '/home', builder: (context, state) => const HomePage()),
    GoRoute(path: '/MovieDetails/:id', builder: (context, state) => const MovieDetailPage()),
    GoRoute(path:   '/booking', builder: (context, state) => const BookingPage()),

  ],
);