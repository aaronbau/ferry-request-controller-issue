import 'package:flutter/material.dart';
import 'package:ferry/ferry.dart';
import 'package:gql_http_link/gql_http_link.dart';

import 'src/graphql/__generated__/all_pokemon.req.gql.dart';

void main() async {
  final client = Client(
    link: HttpLink("https://pokeapi.dev"),
    cache: Cache(),
  );

  final request = GAllPokemonReq(
    (b) => b
      ..vars.limit = 50
      ..vars.offset = 0,
  );

  runApp(
    MaterialApp(
      title: 'Demo',
      onGenerateRoute: (_) => MaterialPageRoute(
        builder: (_) => OutlinedButton(
          onPressed: () {
            client.requestController.add(request); // This doesn't send any request.
            client.request(request); // This doesn't send any request too.
          },
          child: const Text('Send Request'),
        ),
      ),
    ),
  );
}
