import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gowatch/features/movie/model/movie_summary.dart';

class MovieCard extends StatelessWidget {
 final MovieSummary movie;
 final VoidCallback onTap;
 const MovieCard({super.key, required this.movie, required this.onTap});

 @override
 Widget build(BuildContext context) {
 return InkWell(
 onTap: onTap,
 child: Card(
 clipBehavior: Clip.antiAlias,
 child: Row(
 children: [
 SizedBox(
 width: 100, height: 140,
 child: movie.poster == 'N/A'
 ? const ColoredBox(color: Colors.black26)
 : CachedNetworkImage(imageUrl: movie.poster, fit: BoxFit.cover),
 ),
 const SizedBox(width: 12),
 Expanded(
 child: Padding(
 padding: const EdgeInsets.symmetric(vertical: 12),
 child: Column(
 crossAxisAlignment: CrossAxisAlignment.start,
 children: [
 Text(movie.title, maxLines: 2, overflow: TextOverflow.ellipsis,
 style: Theme.of(context).textTheme.titleMedium),
 const SizedBox(height: 8),
 Text(movie.year, style: Theme.of(context).textTheme.bodySmall),
 ],
 ),
 ),
 ),
 ],
 ),
 ),
 );
 }
}