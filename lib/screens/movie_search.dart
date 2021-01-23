import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/blocs/movie/movie_bloc.dart';
import 'package:movie_app/models/movie_model.dart';

class MovieSearch extends SearchDelegate<String> {
  final List<Movie> favoriteMovies = [];
  final recentSearchingMovies = ["Matrix", "Harry Potter", "Avengers"];

  final Bloc<MovieEvent, MovieState> movieBloc;

  MovieSearch(this.movieBloc);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(icon: Icon(Icons.clear), onPressed: () => query = "")];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    movieBloc.add(SearchMovieEvent(movieName: query));
    return BlocBuilder(
        cubit: movieBloc,
        builder: (context, state) {
          debugPrint("State: $state");
          if (state is MovieInitialState) {
            return Center(child: Text("Initial"));
          }
          if (state is MovieSearchingState) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is MovieSearchErrorState) {
            print("Error:" + state.errorText);
            return Container(
              child: Text(state.errorText),
            );
          }
          if (state is MovieSearchSuccessState) {
            List<Movie> movieList = state.movieList;

            return _buildMovieList(movieList);
          } else {
            return Container();
          }
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList =
        query.isEmpty ? recentSearchingMovies : recentSearchingMovies;

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        leading: Icon(Icons.movie_outlined),
        title: Text(suggestionList[index]),
        onTap: () => showResults(context),
      ),
      itemCount: suggestionList.length,
    );
  }

  Widget _buildMovieList(List<Movie> movieList) {
    return Column(
     children: [

FlatButton.icon(onPressed: (){}, icon:Icon(Icons.movie_outlined), label: Text("My Favorite's Movies")),
       GridView.builder(
         shrinkWrap: true,
         itemCount: movieList.length,
         gridDelegate:
         SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
         itemBuilder: (BuildContext context, int index) {
           return GestureDetector(
             child: Padding(
               padding: const EdgeInsets.all(8.0),
               child: Material(
                 borderRadius: BorderRadius.circular(16),
                 elevation: 4,
                 color: Colors.grey,
                 child: Container(
                   decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(20), color: Colors.red),
                   child: Column(
                     children: [
                       Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Text(
                           movieList[index].title,
                           style: TextStyle(
                               fontSize: 14, fontWeight: FontWeight.bold),
                         ),
                       ),
                       Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Center(
                             child: Text(movieList[index].year,
                                 style: TextStyle(
                                     fontSize: 14, fontWeight: FontWeight.bold))),
                       ),
                       InkWell(
                         onTap: () {
                           /* Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  Detay(imgPath: 'assets/modelgrid1.jpeg')));*/
                         },
                         child: Hero(
                           tag: movieList[index].poster,
                           child: /*Expanded(child: Image(image: NetworkImage(movieList[index].poster),fit: BoxFit.cover,)),*/
                           Container(
                             width: 250, //MediaQuery.of(context).size.width,
                             height: 300, //MediaQuery.of(context).size.height,
                             decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(5),
                                 image: DecorationImage(
                                     image:
                                     NetworkImage(movieList[index].poster),
                                     fit: BoxFit.fill)),
                           ),
                         ),
                       ),


/*  SizedBox(
          width: 30,
                      ),*/
                       Divider(),
                       IconButton(
                         icon:Icon(Icons.favorite,size: 30,),
                         onPressed: ()=>favoriteMovies.add(movieList[index]),
                       ),
                     ],
                   ),
                 ),
               ),
             ),
             onTap: () => debugPrint("Movie $index tıklanıldı"),
             onDoubleTap: () => debugPrint("Movie $index çift tıklanıldı"),
             onLongPress: () => debugPrint("Movie $index uzun basıldı"),
             onHorizontalDragStart: (e) =>
                 debugPrint("Movie $index uzun basıldı $e"),
           );
         },
       ),
     ],
    );
  }
}
