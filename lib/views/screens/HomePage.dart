import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double sliderVal = 0;
  List myValues = [
    {
      'title': "Loan Amount",
      'min': 10000,
      'max': 1000000,
      'val': 10000,
      'label': "₹",
    },
    {
      'title': "Interest Rate",
      'min': 6.0,
      'max': 20.0,
      'val': 6.0,
      'label': "%",
    },
    {
      'title': "Loan Tenure",
      'min': 6.0,
      'max': 120.0,
      'val': 6.0,
      'label': "months",
    },
  ];
  double total = 0.0;
  void getTotal() {
    total = myValues[0]['val'] *
        myValues[1]['val'] *
        (1 + myValues[1]['val']) *
        ((1 + myValues[1]['val']) * (myValues[2]['val'] - 1)) /
        ((1 + myValues[1]['val']) * myValues[2]['val'] - 1);
  }

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    double w = s.width;
    double h = s.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "EMI Calculator",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xff20295c),
        elevation: 0,
        leading: const Icon(
          Icons.grid_view_rounded,
          color: Colors.white,
        ),
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: h,
              width: w,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xff20295c),
                    Color(0xff0f2027),
                  ],
                  stops: [0.2, 0.4],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            Positioned(
              top: 20,
              bottom: 320,
              child: Text(
                total.toStringAsFixed(2),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              height: h * 0.8,
              width: w,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  children: myValues
                      .map(
                        (e) => mySliderBox(
                          title: e['title'],
                          label: e['label'],
                          min: e['min'].toDouble(),
                          max: e['max'].toDouble(),
                          index: myValues.indexOf(e),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: GestureDetector(
                onTap: () {
                  getTotal();
                  setState(() {});
                },
                child: const Text(
                  "Calculate",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xff20295c),
                    fontSize: 30,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: const Color(0xff20295c),
    );
  }

  Widget mySliderBox({
    required String title,
    required String label,
    required double min,
    required double max,
    required int index,
  }) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text(title),
          Stack(
            alignment: Alignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Color(0xffE5E6E8),
                ),
              ),
              Text(
                "${myValues[index]['val'].toInt().toString()} $label",
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
          Slider(
            min: min,
            max: max,
            value: myValues[index]['val'].toDouble(),
            onChanged: (val) {
              setState(() {
                myValues[index]['val'] = val;
              });
            },
          )
        ],
      ),
    );
  }
}
