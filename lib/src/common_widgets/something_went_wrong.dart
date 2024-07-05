import 'package:flutter/material.dart';
import 'package:path/path.dart';

class SomethingWentWrong extends StatelessWidget {
  const SomethingWentWrong(
      {super.key, this.onRefresh, this.imagePath, this.message, this.showOops});
  final VoidCallback? onRefresh;
  final String? imagePath;
  final String? message;
  final bool? showOops;

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
                Visibility(
                  visible: showOops ?? true,
                  child: Positioned(
                    right: 0,
                    child: Text(
                      'Oops!!!',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                    ),
                  ),
                ),
              ],
            ),
            Text(
              message ?? 'Something Went Wrong,\n Please try again.',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
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
