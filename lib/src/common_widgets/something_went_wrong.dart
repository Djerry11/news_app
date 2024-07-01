import 'package:flutter/material.dart';

class SomethingWentWrong extends StatelessWidget {
  const SomethingWentWrong(
      {super.key, this.onRefresh, this.imagePath, this.message});
  final VoidCallback? onRefresh;
  final String? imagePath;
  final String? message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                SizedBox(
                  width: 200,
                  height: 200,
                  child: Image.asset(
                      imagePath ?? 'assets/images/somethingwrong.png'),
                ),
                const Positioned(
                  right: 0,
                  child: Text(
                    'Oops!!!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              message ?? 'Something Went Wrong,\n Please try again.',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
            Visibility(
              visible: onRefresh == null ? false : true,
              child: Padding(
                padding: const EdgeInsets.only(top: 5.0),
                child: ElevatedButton(
                  onPressed: onRefresh,
                  style: const ButtonStyle(
                    side: WidgetStatePropertyAll(
                      BorderSide(
                        color: Colors.green,
                        width: 2,
                      ),
                    ),
                  ),
                  child: const Text(
                    'Refresh',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
