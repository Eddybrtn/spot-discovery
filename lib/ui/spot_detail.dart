import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spot_discovery/core/manager/spot_manager.dart';
import 'package:spot_discovery/core/model/spot.dart';
import 'package:spot_discovery/core/model/spot_comment.dart';
import 'package:spot_discovery/core/viewmodels/my_model.dart';
import 'package:spot_discovery/core/viewmodels/spot_detail_viewmodel.dart';
import 'package:spot_discovery/ui/my_widget.dart';

class SpotDetailArguments {
  Spot spot;

  SpotDetailArguments({this.spot});
}

class SpotDetail extends StatelessWidget {
  static const route = "/spot";

  final Spot spot;

  SpotDetail(this.spot);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (BuildContext context) {
          return MyModel();
        },
        child: MyWidget());

    return ChangeNotifierProvider<SpotDetailViewModel>(
      create: (_) => SpotDetailViewModel(spot),
      child: Consumer<SpotDetailViewModel>(
        builder: (context, SpotDetailViewModel model, child) => WillPopScope(
            onWillPop: () async {
              Navigator.pop(context, model.isFavorite);
              return true;
            },
            child: Scaffold(
                appBar: AppBar(
                  title: Text(model.spot.title),
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: () async {
                    model.toggleFavorite();
                  },
                  child: Icon(model.isFavorite
                      ? CupertinoIcons.heart_fill
                      : CupertinoIcons.heart),
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
                            child: PageView.builder(
                              itemBuilder: (context, position) {
                                return Image.network(
                                  model.hasFetchedSpotDetail()
                                      ? model.spot.imagesCollection[position]
                                      : model.spot.imageFullsize,
                                  fit: BoxFit.cover,
                                );
                              },
                              itemCount: model.hasFetchedSpotDetail()
                                  ? model.spot.imagesCollection.length
                                  : 1,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              SizedBox(
                                height: 16,
                              ),
                              model.spot.isRecommended
                                  ? Container(
                                      padding: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4)),
                                          color: Colors.green),
                                      child: Text(
                                        "Recommandé",
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.white),
                                      ),
                                    )
                                  : Container(),
                              SizedBox(
                                height: 8,
                              ),
                              model.spot.isClosed
                                  ? Container(
                                      padding: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(4)),
                                          color: Colors.red),
                                      child: Text("Fermé",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white)))
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
                              model.spot.title,
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Container(
                              height: 40,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, position) {
                                  String tag =
                                      model.spot.tagsCategory[position].name;
                                  return Container(
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4))),
                                    child: Center(
                                        child: Text(
                                      tag,
                                      style: TextStyle(color: Colors.white),
                                    )),
                                  );
                                },
                                separatorBuilder: (context, position) =>
                                    SizedBox(
                                  width: 8,
                                ),
                                itemCount: model.spot.tagsCategory.length,
                              ),
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Text("Adresse : ${model.spot.address}"),
                            SizedBox(
                              height: 12,
                            ),
                            Text(
                                "Gare la plus proche : ${model.spot.trainStation ?? "inconnue"}"),
                            SizedBox(
                              height: 20,
                            ),
                            model.hasFetchedSpotDetail()
                                ? _SpotDescription(model.spot.description)
                                : Container(),
                            model.hasFetchedSpotDetail()
                                ? _SpotComments(
                                    model.spot,
                                  )
                                : Container()
                          ],
                        ),
                      )
                    ],
                  ),
                ))),
      ),
    );
  }
}

class _SpotDescription extends StatelessWidget {
  final String description;

  _SpotDescription(this.description);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Description",
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(
          height: 6,
        ),
        Text(description)
      ],
    );
  }
}

class _SpotComments extends StatelessWidget {
  final Spot spot;
  final TextEditingController commentFieldController = TextEditingController();
  final GlobalKey<AnimatedListState> animatedListKey = GlobalKey();

  _SpotComments(this.spot);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Commentaires",
                style: TextStyle(fontSize: 18),
              ),
              FlatButton(
                  onPressed: () {
                    _postCommentDialog(context);
                  },
                  child: Text("Laisser un avis"))
            ],
          ),
          AnimatedList(
            key: animatedListKey,
            initialItemCount: spot.comments?.length ?? 0,
            shrinkWrap: true,
            primary: false,
            itemBuilder: (context, position, animation) {
              return SizeTransition(
                  sizeFactor: animation,
                  child: _CommentItem(spot.comments[position]));
            },
          )
        ],
      ),
    );
  }

  void _postCommentDialog(BuildContext context) async {
    await showDialog(
        context: context,
        barrierDismissible: true,
        useSafeArea: true,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12.0))),
            insetPadding: EdgeInsets.symmetric(horizontal: 40),
            title: Text("Saisissez votre commentaire",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            content: TextField(
              controller: commentFieldController,
              minLines: 3,
              maxLines: 3,
              textCapitalization: TextCapitalization.sentences,
            ),
            actions: [
              FlatButton(
                onPressed: () async {
                  if (commentFieldController.text.length > 0) {
                    SpotComment postedComment = await SpotManager()
                        .sendComment(spot.id, commentFieldController.text);
                    if (postedComment != null) {
                      spot.comments.insert(0, postedComment);
                      animatedListKey.currentState.insertItem(0);
                      Navigator.pop(context);
                    }
                  }
                },
                child: Text(
                  "ENVOYER",
                  style: TextStyle(fontSize: 16),
                ),
              )
            ],
          );
        });
  }
}

class _CommentItem extends StatelessWidget {
  final SpotComment comment;

  _CommentItem(this.comment);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
      child: Text("« ${comment.comment} »"),
    );
  }
}
