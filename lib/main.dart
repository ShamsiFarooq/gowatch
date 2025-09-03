import 'package:flutter/material.dart';
import 'package:gowatch/features/movie/provider/detailes_provider.dart';
import 'package:gowatch/features/movie/provider/search_provider.dart';
import 'package:gowatch/features/movie/service/omdb_api.dart';
import 'package:provider/provider.dart';
import 'app/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final api = OmdbApi.create();
  runApp(MovieApp(api: api));
}

class MovieApp extends StatelessWidget {
  final OmdbApi api;
  const MovieApp({super.key, required this.api});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SearchProvider(api)),
        ChangeNotifierProvider(create: (_) => DetailProvider(api)),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'MovieTime',
        routerConfig: appRouter,
      ),
    );
  }
}
