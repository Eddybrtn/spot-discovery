import 'package:flutter/material.dart';
import 'package:spot_discovery/core/manager/spot_manager.dart';
import 'package:spot_discovery/core/model/spot.dart';
import 'package:spot_discovery/ui/spot_detail.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Spot> filteredSpots = List();
  final List<Spot> paginatedSpotList = List();
  final TextEditingController searchController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  int offset = 0;
  bool isLoadingMore = false;

  @override
  void initState() {
    searchController.addListener(() {
      searchSpots(searchController.text);
    });
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent &&
          paginatedSpotList.length < SpotManager().spots.length && !isLoadingMore) {
        isLoadingMore = true;
        // Le bas de la liste est atteint et + de spots sont disponibles
        setState(() {
          paginatedSpotList.addAll(SpotManager()
              .getSomeSpots(startIndex: offset, endIndex: offset + 15));
          offset += 15;
        });
        isLoadingMore = false;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the HomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        future: SpotManager().loadSpots(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Spot> spots;
            if (searchController.text != null &&
                searchController.text.isNotEmpty) {
              spots = filteredSpots;
            } else {
              if (paginatedSpotList.length == 0) {
                paginatedSpotList.addAll(SpotManager().getSomeSpots());
                offset = paginatedSpotList.length;
              }
              spots = paginatedSpotList;
            }
            return SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: searchController,
                            decoration: InputDecoration(
                                hintText: "Rechercher...",
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6)),
                                )),
                            textInputAction: TextInputAction.done,
                            onSubmitted: (term) {
                              searchSpots(term);
                            },
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () {
                            searchSpots(searchController.text);
                          },
                        )
                      ],
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemBuilder: (context, position) {
                      Spot spot = spots[position];
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(SpotDetail.route,
                              arguments: SpotDetailArguments(spot: spot));
                        },
                        child: Row(
                          children: [
                            Container(
                                width: 100,
                                height: 100,
                                child: Image.network(
                                  spot.imageThumbnail,
                                  fit: BoxFit.cover,
                                )),
                            SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    spot.title,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text("Catégorie : ${spot.mainCategory.name}")
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                    itemCount: spots.length,
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ), // This
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Spot randomSpot = SpotManager().getRandomSpot();
          Navigator.of(context).pushNamed(SpotDetail.route,
              arguments: SpotDetailArguments(spot: randomSpot));
        },
        child: Icon(
          Icons.shuffle,
          color: Colors.white,
        ),
      ), // trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void searchSpots(String term) async {
    setState(() {
      filteredSpots.clear();
      filteredSpots.addAll(SpotManager().getSpotsByName(term));
    });
  }
}
