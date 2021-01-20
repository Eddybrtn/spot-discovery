import 'package:flutter/material.dart';
import 'package:spot_discovery/core/model/spot.dart';

class SpotDetailArguments {
  Spot spot;

  SpotDetailArguments({this.spot});
}

class SpotDetail extends StatefulWidget {
  static const route = "/spot";

  final Spot spot;

  SpotDetail(this.spot);

  @override
  State<StatefulWidget> createState() => _SpotDetailState();
}

class _SpotDetailState extends State<SpotDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.spot.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: 300,
                    child: Image.network(
                      widget.spot.imageFullsize,
                      fit: BoxFit.cover,
                    )),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 16,
                    ),
                    widget.spot.isRecommended
                        ? Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                                color: Colors.green),
                            child: Text(
                              "Recommandé",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                          )
                        : Container(),
                    SizedBox(
                      height: 8,
                    ),
                    widget.spot.isClosed
                        ? Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                                color: Colors.red),
                            child: Text("Fermé",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white)))
                        : Container()
                  ],
                )
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    widget.spot.title,
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Container(
                    height: 40,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, position) {
                        String tag = widget.spot.tagsCategory[position].name;
                        return Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4))),
                          child: Center(
                              child: Text(
                            tag,
                            style: TextStyle(color: Colors.white),
                          )),
                        );
                      },
                      itemCount: widget.spot.tagsCategory.length,
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text("Adresse : ${widget.spot.address}"),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                      "Gare la plus proche : ${widget.spot.trainStation ?? "inconnue"}"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
