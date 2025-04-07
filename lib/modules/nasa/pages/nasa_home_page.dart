import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';

import '../../../common/bloc/bloc_view.dart';
import '../blocs/nasa_bloc.dart';
import '../models/apod.dart';
import '../models/media_type.dart';
import '../widgets/image_viewer.dart';
import '../widgets/video_player.dart';
import '../widgets/webview.dart';

class NasaHomePage extends StatelessWidget with BlocView<NasaBloc> {
  final DateTime? date;
  NasaHomePage(this.date, {super.key}) {
    bloc.add(NasaEventPictureRequested(date));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Astronomy Picture of the Day'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_month_outlined),
            onPressed: () {
              showDatePicker(
                context: context,
                firstDate: DateTime(1995, 6, 16),
                lastDate: DateTime.now(),
                initialDate: bloc.state.date,
              ).then((date) {
                if (date != null) {
                  bloc.add(NasaEventPictureRequested(date));
                }
              });
            },
          )
        ],
      ),
      body: BlocBuilder<NasaBloc, NasaState>(
        bloc: bloc,
        builder: (context, state) {
          switch (state.status) {
            case NasaStatus.loaded:
              return _buildPage(state.apod!);
            case NasaStatus.loading:
              return _buildLoading();
            case NasaStatus.error:
              return _buildError();
            default:
              return SizedBox.shrink();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.favorite),
        onPressed: () => Modular.to.pushNamed('/favorites'),
      ),
    );
  }

  Widget _buildPage(Apod apod) {
    return ListView(
      physics: ClampingScrollPhysics(),
      children: [
        apod.url.toString().contains('html')
            ? WebView(apod.url)
            : apod.mediaType == MediaType.image
                ? ImageViewer(apod.url)
                : VideoPlayer(apod.url),
        Padding(
          padding: EdgeInsets.all(22),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  apod.title,
                  style: TextStyle(fontSize: 22),
                ),
              ),
              SizedBox(width: 12),
              IconButton(
                icon: Icon(
                  bloc.state.favorites.contains(apod) ? Icons.favorite : Icons.favorite_border,
                ),
                color: Colors.red,
                onPressed: () => bloc.add(
                  NasaEventFavoriteChanged(apod),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 22),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 22),
          child: Text(
            DateFormat('dd/MM/yyyy').format(apod.date),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(22),
          child: Text(
            apod.explanation,
          ),
        ),
      ],
    );
  }

  Widget _buildLoading() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(),
        SizedBox(height: 14),
        Center(
          child: Text(
            'Please wait, loading data.',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildError() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text(
            'An error occurred while loading data.',
            style: TextStyle(fontSize: 16),
          ),
        ),
        SizedBox(height: 12),
        OutlinedButton(
          child: Text('Try again'),
          onPressed: () => bloc.add(
            NasaEventPictureRequested(),
          ),
        )
      ],
    );
  }
}
