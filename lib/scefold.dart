import 'package:flutter/material.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {

  TextEditingController controller = TextEditingController();
  TextEditingController controller1 = TextEditingController();

  Widget aperator (String label) {
    return Container(
      margin: EdgeInsets.all(6),
        child: SizedBox(
          height: 57,
          width: 74,
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.orangeAccent),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          onPressed: () {
            setState(() {
              if (controller.text[controller.text.length - 1] == "X"|| 
                  controller.text[controller.text.length - 1] == "/" ||
                  controller.text[controller.text.length - 1] == "%" ||
                  controller.text[controller.text.length - 1] == "-" ||
                  controller.text[controller.text.length-1]=="+") {
                  controller.text = controller.text.substring(0, controller.text.length - 1);
                  controller.text += label;
              } else {
              controller.text += label;
            }
          }
        );
      },
        child: Text(label, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),)),
      ),
    );
  }

  Widget answer () {
    return Container(
      margin: const EdgeInsets.all(6),
      height: 57,
      width: 74,
      decoration: BoxDecoration(color: Colors.redAccent, borderRadius: BorderRadius.circular(10)),
      child: TextButton(onPressed: (){
        if (controller1.text != ''){
          controller.text = controller1.text; 
          controller1.text = '';
        } else {
          controller1.text = '';
        }
      }, child: const Text('=', style: TextStyle(color: Colors.white, fontSize: 25))),
    );
  }

  Widget bottom (Color Colors, String title, Color textcolor) {
  return Container(
    margin:const EdgeInsets.only(left: 9, right: 9, top: 11, bottom: 11),
    height: 57,
    width: 74,
    decoration: BoxDecoration(color: Colors, borderRadius: BorderRadius.circular(10)),
    child: TextButton(onPressed: (){
      controller.text += title;
      List<int> indexs = [];
        List <num> numbers = [];
        int a = 0;
        for (int i = 0; i < controller.text.length; i ++){
          if ('/x-+%'.contains(controller.text[i])){
            indexs.add(i);
          }
        }
        for (int i in indexs){
          String m = controller.text.substring(a, i);
          a = i + 1;
          numbers.add(num.parse(m));
        }
        numbers.add(num.parse(controller.text.substring(a, controller.text.length)));
        int i = 0;
        while (i < indexs.length){
          if (controller.text[indexs[i]]== '%'){
            numbers[i] = (numbers[i] * numbers[i+1]) / 100;
            indexs.removeAt(i);
            numbers.removeAt(i+1);
            continue;
          }
          if (controller.text[indexs[i]]== '/'){
            numbers[i]= numbers[i] / numbers[i + 1];
            indexs.removeAt(i);
            numbers.removeAt(i+1);
            continue;
          }
          if (controller.text[indexs[i]]== 'x'){
            numbers[i]= numbers[i] * numbers[i + 1];
            indexs.removeAt(i);
            numbers.removeAt(i+1);
            continue;
          }
          i++;
        }
        i = 0;
        while (i < indexs.length){
          if (controller.text[indexs[i]]== '-'){
            numbers[i]= numbers[i] - numbers[i + 1];
            indexs.removeAt(i);
            numbers.removeAt(i+1);
            continue;
          }
          if (controller.text[indexs[i]]== '+'){
            numbers[i]= numbers[i] + numbers[i + 1];
            indexs.removeAt(i);
            numbers.removeAt(i+1);
            continue;
          }
          i++;
        }
        controller1.text = numbers[0].toString();
    }, child: Text(title, style: TextStyle(color: textcolor, fontSize: 25))),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(  
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Container(
            color: Colors.white70,
            child: Column(
              children: [
                Container(
            margin: const EdgeInsets.only(top: 60, right: 10, left: 10),
            child: TextField(
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              textAlign: TextAlign.end,
              keyboardType: TextInputType.none,
              controller: controller,
              decoration: const InputDecoration(border: InputBorder.none),
              maxLines: 3,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 70, right: 10, left: 10,bottom: 10),
            child: TextField(
              style: const TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.black54),
              textAlign: TextAlign.end,
              keyboardType: TextInputType.none,
              controller: controller1,
              decoration: const InputDecoration(border: InputBorder.none),
            ),
          ),
          Container(
            alignment: AlignmentDirectional.topEnd,
                      margin: const EdgeInsets.all(9),
                      height: 37,
                      child: TextButton(onPressed: (){
                        controller.text = controller.text.substring(0, controller.text.length-1);
                      }, child: const Icon(Icons.backspace, size: 30, color: Colors.black87)),
                    ),
              ],
            ),
          ),
          
          Container(
            margin: const EdgeInsets.only(top: 40),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(children: [
                    Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(9),
                      height: 57,
                      width: 74,
                      decoration: BoxDecoration(color: Colors.red.shade500, borderRadius: BorderRadius.circular(10)),
                      child: TextButton(onPressed: (){
                        controller1.text = '';
                        controller.text = '';
                      }, child: const Text('C', style: TextStyle(color: Colors.white, fontSize: 25),)),
                    ),
                    aperator('%'),
                  ],
                ),
                  ],),
                ),
                Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                bottom(Colors.blueAccent, '1', Colors.white),
                bottom(Colors.blueAccent, '2', Colors.white),
                bottom(Colors.blueAccent, '3', Colors.white),
                aperator('/'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                bottom(Colors.blueAccent, '4', Colors.white),
                bottom(Colors.blueAccent, '5', Colors.white),
                bottom(Colors.blueAccent, '6', Colors.white),
                aperator('X'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                bottom(Colors.blueAccent, '7', Colors.white),
                bottom(Colors.blueAccent, '8', Colors.white),
                bottom(Colors.blueAccent, '9', Colors.white),
                aperator('-'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                bottom(Colors.tealAccent, '.', Colors.black),
                bottom(Colors.blueAccent, '0', Colors.white),
                answer(),
                aperator('+'),
              ],
            ),
              ],
            ),
          ),
        ],
      ),
      );
  }
}