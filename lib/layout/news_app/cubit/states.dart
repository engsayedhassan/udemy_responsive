abstract class NewsStates {}

class NewsInitialStates extends NewsStates {}

class NeWsBottomNavStates extends NewsStates {}

class NeWsGetBusinessLoadingStates extends NewsStates {}

class NeWsGetBusinessSuccessStates extends NewsStates {}

class NeWsGetBusinessErrorStates extends NewsStates {
  late final String error;

  NeWsGetBusinessErrorStates(this.error);
}

class NeWsGetSportsLoadingStates extends NewsStates {}

class NeWsGetSportsSuccessStates extends NewsStates {}

class NeWsGetSportsErrorStates extends NewsStates {
  late final String error;

  NeWsGetSportsErrorStates(this.error);
}

class NeWsGetScienceLoadingStates extends NewsStates {}

class NeWsGetScienceSuccessStates extends NewsStates {}

class NeWsGetScienceErrorStates extends NewsStates {
  late final String error;

  NeWsGetScienceErrorStates(this.error);
}


class NeWsGetSearchLoadingStates extends NewsStates {}

class NeWsGetSearchSuccessStates extends NewsStates {}

class NeWsGetSearchErrorStates extends NewsStates {
  late final String error;

  NeWsGetSearchErrorStates(this.error);
}

