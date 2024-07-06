import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BodyPartsScreen extends StatefulWidget {
  const BodyPartsScreen({super.key});

  @override
  State<BodyPartsScreen> createState() => _BodyPartsScreenState();
}

class _BodyPartsScreenState extends State<BodyPartsScreen> {


late BluetoothConnection connection;
bool get isConnected =>(connection.isConnected);
_BodyPartsScreenState(){
  _connect();
}

Future<void> _connect() async{
  try{
      connection = await BluetoothConnection.toAddress("98:D3:31:F5:BB:FA");
      Fluttertoast.showToast(msg: 'Connected to the bluetooth device');
      print('Connected to the bluetooth device');
  }
  catch(exception){
    try{
      if(isConnected){
        Fluttertoast.showToast(msg: 'Already connected to the device');
        print('Already connected to the device');
      }
      else{
        Fluttertoast.showToast(msg: 'Cannot connect, exception occured');
        print('Cannot connect, exception occured');
      }

    }catch(e){
       Fluttertoast.showToast(msg: 'Cannot connect, probably not initialized connection');
       print('Cannot connect, probably not initialized connection');
    }
     
  }

}

Future<void> _sendData(String data) async{
  connection.output.add(Uint8List.fromList(utf8.encode(data))); //sending data
  await connection.output.allSent;
}
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      appBar: AppBar(
        title: const Text('Body Parts',style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),),
        backgroundColor: Colors.blueGrey,
      ),
      body:Padding(
        padding: const EdgeInsets.only(top: 20,left: 15,right: 15),
        child: Column(
          children: [
            Row(
              children: [
                item('Hand', 'assets/images/hand.jpg'),
                const SizedBox(width: 15,),
                button("Robot Hand", () {
                  if(isConnected){
                    _sendData("h");
                  }
                  else{
                    Fluttertoast.showToast(msg: 'Cannot send data!\nYou are not connected');
                  }
                 })
              ],
            ),
            const SizedBox(height: 15,),
             Row(
              children: [
                item("Face", 'assets/images/face.jpg'),
                const SizedBox(width: 15,),
                button("Robot Face", () {
                     if(isConnected){
                    _sendData("f"); 
                  }
                  else{
                    Fluttertoast.showToast(msg: 'Cannot send data!\nYou are not connected');
                  }
                  })
              ],
            ),
          ],
        ),
      )
    );
  }
}

button(String text,void Function()? onTap)
{
  return GestureDetector(
    onTap: onTap,
    child: Container(
      alignment: Alignment.center,
      height: 60,
      width: 150,
      decoration: BoxDecoration(
        color: Colors.blueGrey,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(text,style:const TextStyle(color: Colors.white,fontSize: 15),),
    ),
  );
}

item(String text,String image)
{
  return  Container(
                  height: 150,
                       decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            offset:const Offset(0, 5),
                            color: Colors.blueGrey.withOpacity(.2),
                            spreadRadius: 2,
                            blurRadius: 10,
                          )
                        ]
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15,right: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(text,style:const TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),),
                            const SizedBox(width: 10,),
                            CircleAvatar(
                              radius: 40,
                              backgroundImage: AssetImage(image),
                            )
                          ],),
                      ), 
            );
}