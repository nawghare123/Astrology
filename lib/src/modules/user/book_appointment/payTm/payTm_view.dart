import 'dart:convert';

import 'package:dio/dio.dart' as dio_instance;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:paytm_allinonesdk/paytm_allinonesdk.dart';

class PayTm extends StatefulWidget {
  const PayTm({Key? key}) : super(key: key);

  @override
  State<PayTm> createState() => _PayTmState();
}

class _PayTmState extends State<PayTm> {
  String mid = "Ddqckl36992914432459", orderId = "012", amount = "100", txnToken = "FLWSECK_TESTa144fbd78848";
  String result = "";
  bool isStaging = false;
  bool isApiCallInprogress = false;
  String callbackUrl = "";
  bool restrictAppInvoke = false;
  bool enableAssist = true;
  @override
  void initState() {
    print("initState");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Card(
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(8),
                child: Column(
                  children: [
                    // EditText('Merchant', mid, onChange: (val) => mid = val),
                    // EditText('Order ID', orderId, onChange: (val) => orderId = val),
                    // EditText('Amount', amount, onChange: (val) => amount = val),
                    // EditText('Transaction Token', txnToken, onChange: (val) => txnToken = val),
                    // EditText('CallBack URL', callbackUrl, onChange: (val) => callbackUrl = val),
                    Row(
                      children: <Widget>[
                        Checkbox(
                            activeColor: Theme.of(context).buttonColor,
                            value: isStaging,
                            onChanged: (bool? val) {
                              setState(() {
                                isStaging = val!;
                              });
                            }),
                        Text("Staging")
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Checkbox(
                            activeColor: Theme.of(context).buttonColor,
                            value: restrictAppInvoke,
                            onChanged: (bool? val) {
                              setState(() {
                                restrictAppInvoke = val!;
                              });
                            }),
                        Text("Restrict AppInvoke")
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.all(16),
                      child: ElevatedButton(
                        onPressed: isApiCallInprogress
                            ? null
                            : () {
                                generateCheckSum();
                              },
                        child: Text('Start Transcation'),
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomLeft,
                      child: Text("Message : "),
                    ),
                    Container(
                      child: Text(result),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }

  void generateCheckSum() async {
    var url = 'https://promiseacademy.co.in/flutterapp/paytm/generateChecksum.php';

    String orderId = DateTime.now().millisecondsSinceEpoch.toString();

    String callBackUrl = 'https://securegw.paytm.in/theia/paytmCallback?ORDER_ID=' + orderId;

    //Please use your parameters here
    //CHANNEL_ID etc provided to you by paytm
    dio_instance.Response response;
    dio_instance.Dio dio = dio_instance.Dio();
    dio.options.headers['Accept'] = 'application/json';
    dio.options.headers['Content-Type'] = 'application/x-www-form-urlencode';
    response = await dio.post(url, data: {
      "M_ID": "Ddqckl36992914432459",
      "CHANNEL_ID": "consultant",
      'INDUSTRY_TYPE_ID': "Retail",
      'WEBSITE': "WEB",
      'TXN_AMOUNT': "122",
      'CALLBACK_URL': callBackUrl,
      'ORDER_ID': "122",
      'CUST_ID': '1',
    });

    //for Testing(Stagging) use this

    //https://securegw-stage.paytm.in/theia/paytmCallback?ORDER_ID=

    //https://securegw.paytm.in/theia/paytmCallback?ORDER_ID=

    if (response.statusCode == 200) {
      var result = json.decode(response.data);

      print("Response :" + response.data + "\nchecksumhash:" + result['CHECKSUMHASH']);

      // var paytmResponse = Paytm.startPaytmPayment(
      //     true,
      //     M_ID,
      //     orderId,
      //     "1",
      //     CHANNEL_ID,
      //     amountController.text,
      //     WEBSITE,
      //     callBackUrl,
      //     INDUSTRY_TYPE_ID,
      //     result['CHECKSUMHASH']);

      // paytmResponse.then((value) {
      //   setState(() {
      //     payment_response = value.toString();
      //   });
      // });
    } else {
      print(response.statusCode);
    }
  }

  Future<void> _startTransaction() async {
    try {
      var response = AllInOneSdk.startTransaction("Ddqckl36992914432459", "112", amount, "FLWSECK_TESTa144fbd78848", "DEFAULT", true, true, false);
      response.then((value) {
        print(value);
        setState(() {
          result = value.toString();
        });
      }).catchError((onError) {
        if (onError is PlatformException) {
          setState(() {
            result = onError.message.toString() + " \n  " + onError.details.toString();
          });
        } else {
          setState(() {
            result = onError.toString();
          });
        }
      });
    } catch (err) {
      result = err.toString();
    }
  }
}

class EditText extends StatelessWidget {
  const EditText(
    this.hint,
    this.value, {
    Key? key,
    this.onChange,
  }) : super(key: key);
  final String? hint, value;
  final Function(String)? onChange;
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChange,
    );
  }
}
