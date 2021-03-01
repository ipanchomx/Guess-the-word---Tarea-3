import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'front_event.dart';
part 'front_state.dart';

class FrontBloc extends Bloc<FrontEvent, FrontState> {
  FrontBloc() : super(FrontInitial());

  List<String> list_1 = [
    "Perro",
    "Gato",
    "Perico",
    "Loro",
    "Hámster",
    "Hurón",
    "Pitón",
    "Delfín",
    "Lobo",
    "Tiburón",
    "Rinoceronte",
    "Elefante",
    "Oso Panda"
  ];
  List<String> list_2 = [
    "Perro",
    "Gato",
    "Perico",
    "Loro",
    "Hámster",
    "Hurón",
    "Pitón",
    "Delfín",
    "Lobo",
    "Tiburón",
    "Rinoceronte",
    "Elefante",
    "Oso Panda"
  ];
  int listSize = 0;
  int index = 0;
  int count = 0;

  @override
  Stream<FrontState> mapEventToState(
    FrontEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is StartEvent) {
      list_1.shuffle();
      list_2.shuffle();

      listSize = list_1.length;
      count = 0;
      index = 0;
      yield JuegoIniciadoState(
        contador: count,
        titulo: "The word is...",
        palabra: list_1[index],
      );
    } else if (event is SkipEvent) {
      if (list_1[index] != list_2[index]) count++;

      index++;
      if (index >= listSize)
        yield JuegoEndState(contador: count, titulo: "You scored");
      else
        yield JuegoNextState(
          contador: count,
          titulo: "The word is...",
          palabra: list_1[index],
        );
    } else if (event is GotEvent) {
      if (list_1[index] == list_2[index]) count++;
      index++;
      if (index >= listSize)
        yield JuegoEndState(contador: count, titulo: "You scored");
      else
        yield JuegoNextState(
          contador: count,
          titulo: "The word is...",
          palabra: list_1[index],
        );
    } else if (event is EndEvent) {
      yield JuegoEndState(
        contador: count,
        titulo: "Your Scored",
      );
    }
  }
}
