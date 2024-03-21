import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luxury_car_renatal_app/features/productPage/ui/productPage.dart';

import '../bloc/home_bloc.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
  homeBloc.add(HomeInitialEvent());
    super.initState();
  }
  final HomeBloc homeBloc = HomeBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous,current)=>(current is HomeActionState),
      buildWhen: (previous,current)=>(current is !HomeActionState),
      listener: (context, state) {
      if(state is ImageClickedActionState){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>
         ProductPage(selectedCarModel:(state as ImageClickedActionState).carModel)));
      }
      },
      builder: (context, state) {
       switch(state.runtimeType){
         case HomeLoadedState:
           final loadedState = state as HomeLoadedState;
           return Scaffold(
             backgroundColor: Colors.brown.shade900.withOpacity(0.9),
             appBar: AppBar(
               backgroundColor: Colors.transparent,
               elevation: 0,
               toolbarHeight: 90,
               centerTitle: true,
               title: const Column(
                 children: [
                   Text("Bagalore, Karnataka",
                     style: TextStyle(color: Colors.white,
                         fontWeight: FontWeight.w500,
                         fontSize: 18),),
                   SizedBox(height: 10,),
                   Text("7:00am - 12:00pm, February 12",
                     style: TextStyle(color: Colors.white,
                         fontWeight: FontWeight.w500,
                         fontSize: 16),),
                 ],
               ),

             ),
             body: Container(
               height: double.maxFinite,
               width: double.maxFinite,
               decoration: BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.circular(30)
               ),
               child: Container(
                 margin: EdgeInsets.all(15),
                 child:  Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     const Padding(
                       padding: EdgeInsets.only(right: 10),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Text("47 cars available",
                           style: TextStyle(fontWeight: FontWeight.bold,
                           fontSize: 17),),
                           Text("Relevance",
                           style: TextStyle(fontWeight: FontWeight.bold,
                           fontSize: 17),),
                         ],
                       ),
                     ),
                     const SizedBox(height: 10,),
                     Container(
                       child: Expanded(
                         child: ListView.builder(
                             itemCount: loadedState.carModel.length,
                             itemBuilder:(context,index){
                               return Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   InkWell(
                                     child: Container(
                                     decoration: BoxDecoration(
                                       image: DecorationImage(
                                           image: NetworkImage(loadedState.carModel[index].image.toString()),
                                       fit: BoxFit.cover),
                                       borderRadius: BorderRadius.circular(15)
                                     ),
                                                              height: 150,
                                       margin: EdgeInsets.all(8),
                                     ),
                                     onTap: (){
                                       homeBloc.add(ImageClickedEvent(selectedModel: loadedState.carModel[index]));
                                     },
                                   ),
                                   Row(
                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                     children: [
                                       Text(loadedState.carModel[index].name,style:
                                         const TextStyle(fontWeight: FontWeight.w700,
                                         fontSize: 20),),
                                       Container(
                                         child: Row(
                                           children: [
                                             const Icon(Icons.star,color: Colors.yellow,),
                                             const SizedBox(width: 5,),
                                             Text(loadedState.carModel[index].rating.toString(),style:
                                               const TextStyle(fontWeight: FontWeight.w700,
                                               fontSize: 17),),
                                           ],
                                         ),
                                       )
                                     ],
                                   ),
                                   Text("Rs ${loadedState.carModel[index].pricePerHour.toString()}/day",
                                   style: const TextStyle(fontWeight: FontWeight.w700,
                                   fontSize: 17),),
                                   const SizedBox(
                                     height: 10,
                                   ),
                                   Container(
                                     decoration: const BoxDecoration(
                                       border: Border(
                                         bottom: BorderSide(width:2,color: Colors.black54)
                                       )
                                     ),
                                   )
                                 ],
                               );
                             }),
                       ),
                     )
                   ],
                 ),
               ),
             ),
           );
           break;
         default:
           return const Center(child: Text("Error"));
       }

      },
    );
  }
}
