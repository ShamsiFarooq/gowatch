import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gowatch/features/movie/model/movie_details.dart';
import 'package:gowatch/features/movie/provider/detailes_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MovieDetailPage extends StatefulWidget {
  final String? imdbId;
  const MovieDetailPage({super.key, this.imdbId});

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  DateTime? _date;
  TimeOfDay? _time;

  Future<void> _pickDateTime() async {
    final now = DateTime.now();
    final d = await showDatePicker(
      context: context,
      firstDate: now,
      lastDate: now.add(const Duration(days: 60)),
      initialDate: _date ?? now,
    );
    if (d == null) return;
    final t = await showTimePicker(
      context: context,
      initialTime: _time ?? TimeOfDay.now(),
    );
    if (t != null) {
      setState(() {
        _date = d;
        _time = t;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<DetailProvider>().load(widget.imdbId!);
  }

  @override
  Widget build(BuildContext context) {
    final p = context.watch<DetailProvider>();
    return Scaffold(
      appBar: AppBar(leading: const BackButton()),
      body: () {
        if (p.loading) return const Center(child: CircularProgressIndicator());
        if (p.error != null) return Center(child: Text(p.error!));
        final MovieDetails m = p.movie!;
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child:
                  m.poster == 'N/A'
                      ? const ColoredBox(color: Colors.black26)
                      : CachedNetworkImage(
                        imageUrl: m.poster!,
                        fit: BoxFit.cover,
                      ),
            ),
            const SizedBox(height: 16),
            Text(m.title, style: Theme.of(context).textTheme.headlineSmall),
            Text('${m.genre}'),
            const SizedBox(height: 12),
            const SizedBox(height: 20),
            Row(
              children: [
                OutlinedButton.icon(
                  icon: const Icon(Icons.event),
                  label: Text(
                    _date == null
                        ? 'Pick date & time'
                        : DateFormat('EEE, dd MMM').format(_date!) +
                            ' ' +
                            (_time?.format(context) ?? ''),
                  ),
                  onPressed: _pickDateTime,
                ),
                const Spacer(),
                FilledButton.icon(
                  icon: const Icon(Icons.local_activity),
                  label: const Text('BOOK NOW'),
                  onPressed:
                      (_date != null && _time != null)
                          ? () {
                            final dt = DateTime(
                              _date!.year,
                              _date!.month,
                              _date!.day,
                              _time!.hour,
                              _time!.minute,
                            );
                            context.push(
                              '/booking',
                              extra: BookingArgs(movie: m, dateTime: dt),
                            );
                          }
                          : null,
                ),
              ],
            ),
          ],
        );
      }(),
    );
  }
}

class BookingArgs {
  final MovieDetails movie;
  final DateTime dateTime;
  BookingArgs({required this.movie, required this.dateTime});
}
