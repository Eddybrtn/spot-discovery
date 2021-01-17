# Spot Discovery
## Description
Il s'agit d'un projet d'initiation à Flutter.
Vous utiliserez les données mises à votre disposition afin de constuire une interface simple.

## SpotManager
Vous trouverez dans ce projet le singleton **SpotManager** (lib/core/manager/spot_manager.dart) qui vous donne accès à une liste de spots.
Les données sont parsées depuis le fichier spots.json se trouvant dans le dossier `assets/json`.
La classe **Spot** (lib/core/model.spot.dart) représente un lieu et vous donne accès à de nombreuses informations sur celui-ci.

### Exemples d'utilisation
Récupérer la liste complète des spots :
```
List<Spot> fullSpotList = SpotManager().spots;
```

Récupérer une sous liste de spots :
```
List<Spot> spots = SpotManager().getSomeSpots();
List<Spot> moreSpots = SpotManager().getSomeSpots(startIndex: 15, endIndex: 30);
```

Récupérer un spot au hasard :
```
Spot randomSpot = SpotManager().getRandomSpot();
```

## Objectifs
1. Utilisez une ListView pour afficher la liste des spots. Faites apparaître les infos suivantes du Spot :
    - title
    - imageThumbnail
    - mainCategory : affichez  le `name`

2. Créez la page détail d'un spot, dans laquelle vous afficherez :
    - title
    - imageFullsize
    - address
    - trainStation (attention, la valeur peut-être null)
    - isRecommended : faites apparaître un bandeau avec le label `Recommandé` si **true**
    - isClosed : faites appaître un bandeau avec le label `Fermé` si **true**
    - tagsCategory : affichez les catégories dans une ListView

Lors du clic sur un élément de la liste de votre première vue, redirigez l'utilisateur sur la vue de détail.

3. Ajoutez un FloatingActionButton sur la page d'accueil.
En cliquant sur ce bouton, vous récupérerez un spot au hasard dans la liste et l'afficherez dans la vue de détail

4. Implémentez une fonction **getSpotByName** dans le singleton `SpotManager`.
Utilisez cette fonction pour implémenter une fonctionnalité de recherche par titre de spot dans votre application.

5. Affectez un **ScrollController** à votre ListView pour implémenter une liste paginée.
Vous pouvez utiliser la fonction `getSomeSpots` pour simuler une pagination.
