import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';

void main() => runApp(HomePage());

class HomePage extends StatefulWidget{
HomePage({Key key}) :super(key: key);

_HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  
@override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: StackBuilder()
      ),
    );
  }
}




class StackBuilder extends StatefulWidget{
  StackBuilder({Key key}): super(key:key);

  _StackBuilderState createState() => _StackBuilderState();
}
class _StackBuilderState extends State<StackBuilder> with TickerProviderStateMixin{
  AnimationController paneController;
  Animation<double> paneAnimation;
  Animation<double> albumImageAnimation;
  Animation<double> albumImageBlurAnimation;

  bool isAnimcompleted = false;
  @override
  void initState() { 
    super.initState();
    paneController = AnimationController(vsync: this,duration: Duration(milliseconds: 500));
    paneAnimation = Tween<double>(begin: -250,end: 0.0).animate(CurvedAnimation(parent: paneController,curve: Curves.easeIn));
    albumImageAnimation = Tween<double>(begin: 1.0,end: 0.5).animate(CurvedAnimation(parent: paneController,curve: Curves.easeIn));
    albumImageBlurAnimation = Tween<double>(begin: 0.0,end: 10.0).animate(CurvedAnimation(parent: paneController,curve: Curves.easeIn));

    
  }

animationInit(){
  if(isAnimcompleted){
    paneController.reverse();
  }else{
    paneController.forward();
  }
  isAnimcompleted = !isAnimcompleted;
}

  Widget stackBody(BuildContext context){
    return Stack(
      fit: StackFit.expand,
       children: <Widget>[
            FractionallySizedBox(
              alignment: Alignment.topCenter,
              heightFactor: albumImageAnimation.value,

                          child: Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: ExactAssetImage(
                      'assets/aa.jpg'
                      ),
                      fit: BoxFit.cover
                      )
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: albumImageBlurAnimation.value,sigmaY: albumImageBlurAnimation.value),
                        child: Container(
                          color: Colors.white.withOpacity(0.0),
                        ),
                      ),
              ),
            ),
            Positioned(
              bottom: paneAnimation.value,
              child: GestureDetector(
                onTap: (){
                  animationInit();
                },
                child: Container(
                alignment: Alignment.bottomCenter,
                height: MediaQuery.of(context).size.height/2,
                width: MediaQuery.of(context).size.width,
                color: Colors.green,
                ),
              ),
            )
          ],
     );
  }


 Widget build(BuildContext context) {
   return AnimatedBuilder(
     animation: paneController,
     builder: (BuildContext context,widget){
       return stackBody(context);
     },
   );
 }
}
