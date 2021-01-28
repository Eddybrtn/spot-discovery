import 'package:flutter/material.dart';
import 'package:spot_discovery/core/manager/spot_manager.dart';
import 'package:spot_discovery/core/model/spot.dart';
import 'package:spot_discovery/ui/spot_detail.dart';

class SpotListPage extends StatefulWidget {
  final bool fromFavorite;

  SpotListPage({this.fromFavorite = false});

  @override
  State<StatefulWidget> createState() => _SpotListPageState();
}

class _SpotListPageState extends State<SpotListPage> {
  final List<Spot> spots = List();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Spot>>(
      future: widget.fromFavorite
          ? SpotManager().loadFavoriteSpots()
          : SpotManager().loadSpots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          spots.clear();
          spots.addAll(snapshot.data);
          return ListView.builder(
            itemBuilder: (context, position) {
              Spot spot = spots[position];
              return InkWell(
                onTap: () async {
                  var isFavorite = await Navigator.of(context).pushNamed(
                      SpotDetail.route,
                      arguments: SpotDetailArguments(spot: spot));
                  if (!isFavorite) {
                    setState(() {});
                  }
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
                          Text("Catégorie : ${spot.mainCategoryName()}")
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
            itemCount: spots.length,
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
