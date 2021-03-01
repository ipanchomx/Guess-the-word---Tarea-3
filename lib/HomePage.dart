import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:guess_the_word/bloc/front_bloc.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Guess the Word"),
        backgroundColor: Colors.green,
      ),
      body: BlocProvider(
        create: (context) => FrontBloc(),
        child: BlocConsumer<FrontBloc, FrontState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            if (state is JuegoIniciadoState) {
              return GameScreen(
                contador: state.contador,
                titulo: state.titulo,
                palabra: state.palabra,
              );
            } else if (state is JuegoNextState) {
              return GameScreen(
                contador: state.contador,
                titulo: state.titulo,
                palabra: state.palabra,
              );
            } else if (state is JuegoEndState) {
              return EndScreen(
                contador: state.contador,
                titulo: state.titulo,
              );
            } else
              return StartScreen();
          },
        ),
      ),
    );
  }
}

class StartScreen extends StatelessWidget {
  const StartScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Spacer(),
            Text("Get ready to"),
            SizedBox(
              height: 20,
            ),
            Text(
              "Guess the word!",
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: MaterialButton(
                child: Text(
                  "PLAY",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                color: Colors.green,
                onPressed: () {
                  BlocProvider.of<FrontBloc>(context).add(StartEvent());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GameScreen extends StatelessWidget {
  final String palabra;
  final String titulo;
  final int contador;
  const GameScreen(
      {Key key,
      @required this.palabra,
      @required this.titulo,
      @required this.contador})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Spacer(),
            Text(titulo),
            SizedBox(
              height: 20,
            ),
            Text(
              palabra,
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: Text(contador.toString()),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: Row(
                children: [
                  Expanded(
                    child: MaterialButton(
                      child: Text(
                        "SKIP",
                      ),
                      color: Colors.white,
                      elevation: 0,
                      onPressed: () {
                        BlocProvider.of<FrontBloc>(context).add(
                          SkipEvent(),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: MaterialButton(
                      child: Text(
                        "GOT IT",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      color: Colors.green,
                      onPressed: () {
                        BlocProvider.of<FrontBloc>(context).add(
                          GotEvent(),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    child: MaterialButton(
                      child: Text(
                        "END GAME",
                      ),
                      color: Colors.white,
                      elevation: 0,
                      onPressed: () {
                        BlocProvider.of<FrontBloc>(context).add(
                          EndEvent(),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EndScreen extends StatelessWidget {
  final String titulo;
  final int contador;
  const EndScreen({
    Key key,
    @required this.titulo,
    @required this.contador,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(titulo),
            SizedBox(
              height: 30,
            ),
            Text(
              contador.toString(),
              style: TextStyle(
                fontSize: 40,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            MaterialButton(
              child: Text(
                "PLAY AGAIN",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              color: Colors.green,
              onPressed: () {
                BlocProvider.of<FrontBloc>(context).add(
                  StartEvent(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
