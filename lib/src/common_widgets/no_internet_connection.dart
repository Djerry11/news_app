import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NoInternetConnection extends StatelessWidget {
  const NoInternetConnection({super.key, required this.onRefresh});
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(bottom: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              height: 300,
              width: 300,
              child: Image.asset('assets/images/no_internet.png'),
            ),
            Text('INTERNET CONNECTION',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith()),
            const SizedBox(height: 10),
            const Text(
              'Please check your connection and then \nRefresh the page.',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black54,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: onRefresh,
              style: const ButtonStyle(
                iconColor: WidgetStatePropertyAll(Colors.blue),
                side: WidgetStatePropertyAll(
                  BorderSide(
                    color: Colors.green,
                    width: 2,
                  ),
                ),
              ),
              child: Text(
                'Refresh',
                style: GoogleFonts.b612(color: Colors.green),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
