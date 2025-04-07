import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';

import '../../../common/bloc/bloc_view.dart';
import '../blocs/nasa_bloc.dart';

class FavoritesPage extends StatelessWidget with BlocView<NasaBloc> {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: BlocBuilder<NasaBloc, NasaState>(
        bloc: bloc,
        builder: (context, state) {
          if (state.favorites.isEmpty) {
            return Center(
              child: Text(
                'No favorites available.',
                style: TextStyle(fontSize: 16),
              ),
            );
          }
          return ListView.builder(
            itemCount: state.favorites.length,
            itemBuilder: (context, index) {
              var apod = state.favorites[index];
              return ListTile(
                title: Text(
                  DateFormat('dd/MM/yyyy').format(apod.date),
                ),
                subtitle: Text(apod.title),
                leading: CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(
                    apod.thumbnail ?? apod.url,
                  ),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete_outline),
                  color: Colors.red,
                  onPressed: () => bloc.add(
                    NasaEventFavoriteChanged(apod),
                  ),
                ),
                onTap: () => Modular.to.pushNamed('/', arguments: apod.date),
              );
            },
          );
        },
      ),
    );
  }
}
