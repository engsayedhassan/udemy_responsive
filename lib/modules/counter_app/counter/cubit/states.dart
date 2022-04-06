abstract class CounterStates {}

class CounterInitialStates extends CounterStates {}

class CounterPlusStates extends CounterStates {
  late final int counter;
  CounterPlusStates(this.counter);
}

class CounterMinusStates extends CounterStates {
  late final int counter;
  CounterMinusStates(this.counter);
}
