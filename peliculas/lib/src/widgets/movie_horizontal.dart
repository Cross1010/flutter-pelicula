import 'package:flutter/material.dart';
import 'package:peliculas/src/models/peliculas_model.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Pelicula>? peliculas;
  final Function siguientePagina;

  MovieHorizontal({required this.peliculas, required this.siguientePagina});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    final _pageController =
        new PageController(initialPage: 1, viewportFraction: 0.3);

    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 200) {
        siguientePagina();
      }
    });

    return Container(
      height: _screenSize.height * 0.2,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        // pageSnapping: false,
        controller: _pageController,
        //children: _tarjetas(context),
        itemCount: peliculas!.length,
        itemBuilder: (context, i) {
          return _tarjeta(context, peliculas![i]);
        },
      ),
    );
  }

  Widget _tarjeta(BuildContext context, Pelicula pelicula) {
    // pelicula.uniqueId = '${pelicula.id}-poster';

    final tarjeta = Container(
      margin: EdgeInsets.only(left: 15.0),
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Hero(
              tag: pelicula.uniqueId,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  image: NetworkImage(pelicula.getPosterImg()),
                  fit: BoxFit.cover,
                  height: 160.0,
                ),
              ),
            ),
          ),
          Container(
            width: 120,
            child: Text(
              pelicula.title!,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            ),
          )
        ],
      ),
    );

    return GestureDetector(
      child: tarjeta,
      onTap: () {
        Navigator.pushNamed(context, 'detalle', arguments: pelicula);
      },
    );
  }

  // List<Widget> _tarjetas(BuildContext context) {
  //   return peliculas.map((pelicula) {
  //     return Container(
  //       margin: EdgeInsets.only(right: 15.0),
  //       child: Column(
  //         children: <Widget>[
  //           Expanded(
  //             flex: 3,
  //             child: ClipRRect(
  //               borderRadius: BorderRadius.circular(20),
  //               child: FadeInImage(
  //                 placeholder: AssetImage('assets/img/no-image.jpg'),
  //                 image: NetworkImage(pelicula.getPosterImg()),
  //                 fit: BoxFit.cover,
  //                 height: 160.0,
  //               ),
  //             ),
  //           ),
  //           Text(
  //             pelicula.title,
  //             overflow: TextOverflow.ellipsis,
  //             style: Theme.of(context).textTheme.caption,
  //           )
  //         ],
  //       ),
  //     );
  //   }).toList();
  // }
}
