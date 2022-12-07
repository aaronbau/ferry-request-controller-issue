import 'package:ferry_flutter/ferry_flutter.dart';
import 'package:flutter/material.dart';
import 'package:ferry/ferry.dart';
import 'package:gql_http_link/gql_http_link.dart';
import 'package:pokemon_explorer/src/graphql/__generated__/all_pokemon.data.gql.dart';
import 'package:pokemon_explorer/src/graphql/__generated__/all_pokemon.var.gql.dart';

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
        builder: (_) => Operation<GAllPokemonData, GAllPokemonVars>(
          client: client,
          operationRequest: request,
          builder: (_, __, ___) => OutlinedButton(
            onPressed: () async {
              // None of these lines send any request when you verify via the network logs.
              client.requestController.add(request);
              client.request(request);
              await client.request(request).first;
              await client.request(request).firstWhere((response) => response.dataSource != DataSource.Optimistic);
              client.request(request).listen((_) {});
            },
            child: const Text('Re-fetch'),
          ),
        ),
      ),
    ),
  );
}
