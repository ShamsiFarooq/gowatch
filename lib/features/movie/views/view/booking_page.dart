import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:gowatch/features/movie/views/view/movie_details_page.dart';
import 'package:intl/intl.dart';

class BookingPage extends StatelessWidget {
  final BookingArgs? args;
  const BookingPage({super.key, this.args});

  @override
  Widget build(BuildContext context) {
    final m = args!.movie;
    final dt = args?.dateTime;
    final code = 'MOVIE-${m.id}-${dt!.millisecondsSinceEpoch}';

    return Scaffold(
      appBar: AppBar(leading: const BackButton()),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, size: 72),
            const SizedBox(height: 8),
            Text(
              'Booking Successful',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      m.title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text('Date: ${DateFormat('EEE, dd MMM yyyy').format(dt)}'),
                    Text('Time: ${DateFormat('hh:mm a').format(dt)}'),
                    Text('Screen: 3 Seat: Auto'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 18),
            Expanded(
              child: Center(
                child: BarcodeWidget(
                  barcode: Barcode.code128(),
                  data: code,
                  drawText: true,
                  width: double.infinity,
                  height: 150,
                ),
              ),
            ),
            const Text('Show this code at entry'),
          ],
        ),
      ),
    );
  }
}
