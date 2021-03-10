import 'package:flutter/material.dart';
import 'package:kidaura/presentation/routes.dart';

class ScreenOne extends StatelessWidget {
  final PageController _controller = PageController();
  static const int pageLength = 5;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Screen One'),
      ),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: PageView.builder(
              controller: _controller,
              itemBuilder: (context, currentPage) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //Indicators
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Divider(
                            thickness: 2,
                            indent: 80,
                            endIndent: 80,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for (int i = 0; i < pageLength; i++)
                              indicator(i <= currentPage)
                          ],
                        ),
                      ],
                    ),

                    //Title
                    Text(
                      'Page ${currentPage + 1}',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 48),
                    ),

                    //Button
                    ElevatedButton(
                      onPressed: () {
                        if (currentPage == 4)
                          Navigator.pushNamed(
                              context, Screens.ScreenTwo.toString());
                        else
                          _controller.nextPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease);
                      },
                      child: Text(
                        currentPage == 4 ? 'Go to Screen Two' : 'Next',
                        style: TextStyle(fontSize: 24),
                      ),
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.all(20)),
                      ),
                    ),
                  ],
                );
              },
              itemCount: pageLength,
            )),
      ),
    );
  }

  Widget indicator(bool iSActive) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          backgroundColor: iSActive ? Colors.green : Colors.grey,
          child:
              Icon(iSActive ? Icons.done : Icons.circle, color: Colors.white),
        ),
      );
}
