import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:quotes_app/services/icons_provider.dart';
import 'package:quotes_app/services/quote_provider.dart';
import 'package:share_plus/share_plus.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Future<bool> onPop() async {
    return await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Exit App'),
              content: Text('Are you sure you want to exit the app?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text('Yes'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text('No'),
                ),
              ],
            );
          },
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) async {
          if (didPop) {
            return;
          } else {
            bool pop = await onPop();
            if (pop) {
              SystemNavigator.pop();
            }
          }
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/images/quoteapp_splash2.png',
              fit: BoxFit.cover,
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                color: Colors.black.withValues(alpha: 0.3),
                child: Center(
                  child: Card(
                    elevation: 10,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.7,
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: const Color.fromARGB(255, 230, 133, 165),
                          width: 2,
                        ),
                        color: const Color.fromARGB(255, 236, 199, 212),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: MediaQuery.of(context).size.height * 0.7,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.quora, size: 50),
                                SizedBox(height: 20),
                                Expanded(
                                  child: Consumer<QuoteProvider>(
                                    builder: (context, value, child) {
                                      if (value.isloading) {
                                        return Center(
                                          child: SpinKitSpinningLines(
                                            color: Colors.pink,
                                          ),
                                        );
                                      } else if (value.errmesg == null) {
                                        if (value.quotes!.quote.length > 500) {
                                          return SingleChildScrollView(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  value.quotes!.quote,
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'Author: ',
                                                      style: TextStyle(
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                    Text(
                                                      value.quotes!.author,
                                                      style: TextStyle(
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          );
                                        } else {
                                          return Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  value.quotes!.quote,
                                                  style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                SizedBox(height: 10),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'Author: ',
                                                      style: TextStyle(
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                    Text(
                                                      value.quotes!.author,
                                                      style: TextStyle(
                                                        fontStyle:
                                                            FontStyle.italic,
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          );
                                        }
                                      } else {
                                        return Center(
                                          child: Text(
                                            '${value.errmesg}}',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.red,
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ),

                                SizedBox(height: 20),
                                Consumer<IconsProvider>(
                                  builder: (ctx, value, child) {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            value.like();
                                          },
                                          child: Icon(
                                            Icons.thumb_up,
                                            color:
                                                value.islike
                                                    ? Colors.pink
                                                    : Colors.black,
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            value.dislike();
                                          },
                                          child: Icon(
                                            Icons.thumb_down,
                                            color:
                                                value.isdislike
                                                    ? Colors.pink
                                                    : Colors.black,
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            SharePlus.instance.share(
                                              ShareParams(
                                                text:
                                                    Provider.of<QuoteProvider>(
                                                      context,
                                                      listen: false,
                                                    ).quotes!.quote,
                                              ),
                                            );
                                          },
                                          child: Icon(Icons.share),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Clipboard.setData(
                                              ClipboardData(
                                                text:
                                                    Provider.of<QuoteProvider>(
                                                      context,
                                                      listen: false,
                                                    ).quotes!.quote,
                                              ),
                                            );
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                  'Quote copied to clipboard!',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                duration: Duration(
                                                  milliseconds: 500,
                                                ),
                                                backgroundColor: Color.fromARGB(
                                                  255,
                                                  236,
                                                  199,
                                                  212,
                                                ),
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                showCloseIcon: true,
                                              ),
                                            );
                                          },
                                          child: Icon(Icons.copy),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Provider.of<QuoteProvider>(
                                          context,
                                          listen: false,
                                        ).fetchQuote();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromARGB(
                                          255,
                                          214,
                                          197,
                                          203,
                                        ),
                                        elevation: 2,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            5,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        'Refresh',
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.pink,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
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
