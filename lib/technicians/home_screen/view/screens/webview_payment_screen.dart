import 'package:flutter/material.dart';
import 'package:polymarq/technicians/home_screen/view/screens/shop_tools_screen.dart';
import 'package:polymarq/utils/color.dart';
import 'package:polymarq/utils/custom_alert.dart';
import 'package:polymarq/utils/custom_button.dart';
import 'package:polymarq/utils/sizing.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPaymentScreen extends StatefulWidget {
  const WebViewPaymentScreen({
    required this.webUrl,
    super.key,
  });
  final String webUrl;

  @override
  State<WebViewPaymentScreen> createState() => _WebViewPaymentScreenState();
}

class _WebViewPaymentScreenState extends State<WebViewPaymentScreen> {
  WebViewController controller = WebViewController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith(
              'https://www.youtube.com/',
            )) {
              // log('req: ${request.url}');

              CustomAlert.show(context,
                  message: 'payment done succesflly', success: true,);
            } else {
              //log('re: ${request.url}');
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.webUrl));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.iris,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                navigationDialog(context);
              },
              icon: const Icon(Icons.close),),
        ],
        title: const Text(
          'Complete Payment',
          style: TextStyle(fontSize: 14),
        ),
        centerTitle: true,
      ),
      body: WebViewWidget(controller: controller),
    );
  }

  void navigationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColor.white,
          actions: [
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    buttonText: 'Yes',
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ShopToolsScreen(),),);
                    },
                  ),
                ),
                const XMargin(10),
                Expanded(
                  child: CustomButton(
                    buttonText: 'No',
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ],
          content: const Text(
            'Are you sure you want to\ngo back',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              color: AppColor.black,
              fontWeight: FontWeight.w700,
            ),
          ),
        );
      },
    );
  }
}
