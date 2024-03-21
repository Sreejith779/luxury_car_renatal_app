import 'package:flutter/material.dart';
import 'package:luxury_car_renatal_app/features/homePage/ui/homePage.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height:double.maxFinite,

            child: Container(

              decoration:  const BoxDecoration(
                gradient: RadialGradient(colors:[Colors.black,Colors.black],
               center: Alignment.center,
                ),
                image: DecorationImage(image: AssetImage("assets/onboarding.jpeg"),
                opacity: 0.92,

                fit: BoxFit.cover),

              ),
              child: Container(
                margin: EdgeInsets.only(top: 400),
                decoration:  BoxDecoration(
                  gradient: LinearGradient(colors: [Colors.black,Colors.black.withOpacity(0.2)],
stops: [00,10,],
begin: Alignment.bottomRight,
                    end: Alignment.topCenter

                  )
                ),
              ),
            ),
          ),

          const Padding(padding: EdgeInsets.only(top: 400,left: 30),
          child:Text("Welcome to Luxury Drives",
          style: TextStyle(
            fontFamily: "Whisper",
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.w700
          ),)),
          const Padding(padding: EdgeInsets.only(top: 450,left: 30),
          child:Text("Embark on a journey of luxury and refinement with our exquisite collection of premier vehicles. Explore opulence redefined at Luxury Drives",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w400
          ),)),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 700,),
              child: InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>
                  const HomePage()));
                },
                child: Container(
                  height: 50,
                  width: 150,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(25)
                  ),
                  child: const Center(child: Text("GET STARTED",
                  style: TextStyle(fontSize: 18,
                  fontWeight:FontWeight.w700),)),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
