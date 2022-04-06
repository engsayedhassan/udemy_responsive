import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/modules/counter_app/counter/cubit/states.dart';

class CounterCubit extends Cubit<CounterStates> {
  CounterCubit() : super(CounterInitialStates());
  int counter =1;
  static CounterCubit get(context)=>BlocProvider.of(context);
  void min(){
   /* testWidgets('Counter increments smoke test', (WidgetTester tester)async{
      await tester.pumpWidget(MyApp(true));
    });*/

  }

}
