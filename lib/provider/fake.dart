import 'package:flutter/foundation.dart';

class fake with ChangeNotifier {
  List moviess = [
    {
      'id': 1,
      'title': '100 Years',
      'url':
          'https://m.media-amazon.com/images/M/MV5BMWY3YWY1OTktNjc3Ni00NThiLWI0ODYtOTNjM2E4YjQ2MmJkXkEyXkFqcGdeQXVyMjcyMzI2OTQ@._V1_.jpg'
    },
    {
      'id': 2,
      'title': 'Avatar',
      'url':
          'https://m.media-amazon.com/images/M/MV5BNmM1NmY4N2QtNmVkOS00MjMyLWI5ZGUtYWYxMDRjY2MzNDdiXkEyXkFqcGdeQXVyMTAwMDAwMA@@._V1_.jpg'
    },
    {
      'id': 3,
      'title': '100 Years',
      'url':
          'https://m.media-amazon.com/images/M/MV5BMWY3YWY1OTktNjc3Ni00NThiLWI0ODYtOTNjM2E4YjQ2MmJkXkEyXkFqcGdeQXVyMjcyMzI2OTQ@._V1_.jpg'
    },
    {
      'id': 4,
      'title': 'Avatar 4',
      'url':
          'https://m.media-amazon.com/images/M/MV5BNmM1NmY4N2QtNmVkOS00MjMyLWI5ZGUtYWYxMDRjY2MzNDdiXkEyXkFqcGdeQXVyMTAwMDAwMA@@._V1_.jpg'
    },
  ];

  List get items {
    return [...moviess];
  }

  @override
  void notifyListeners() {
    // TODO: implement notifyListeners
    super.notifyListeners();
  }

// get detais

  List details = [
    {
      "adult": false,
      "backdrop_path":
          "https://m.media-amazon.com/images/M/MV5BNmM1NmY4N2QtNmVkOS00MjMyLWI5ZGUtYWYxMDRjY2MzNDdiXkEyXkFqcGdeQXVyMTAwMDAwMA@@._V1_.jpg",
      "belongs_to_collection": null,
      "budget": 63000000,
      "genres": [
        {"id": 18, "name": "Drama"}
      ],
      "homepage": "",
      "id": 550,
      "imdb_id": "tt0137523",
      "original_language": "en",
      "original_title": "Fight Club",
      "overview":
          "A ticking-time-bomb insomniac and a slippery soap salesman channel primal male aggression into a shocking new form of therapy. Their concept catches on, with underground \"fight clubs\" forming in every town, until an eccentric gets in the way and ignites an out-of-control spiral toward oblivion.",
      "popularity": 0.5,
      "poster_path": null,
      "production_companies": [
        {
          "id": 508,
          "logo_path": "/7PzJdsLGlR7oW4J0J5Xcd0pHGRg.png",
          "name": "Regency Enterprises",
          "origin_country": "US"
        },
        {
          "id": 711,
          "logo_path": null,
          "name": "Fox 2000 Pictures",
          "origin_country": ""
        },
        {
          "id": 20555,
          "logo_path": null,
          "name": "Taurus Film",
          "origin_country": ""
        },
        {
          "id": 54050,
          "logo_path": null,
          "name": "Linson Films",
          "origin_country": ""
        },
        {
          "id": 54051,
          "logo_path": null,
          "name": "Atman Entertainment",
          "origin_country": ""
        },
        {
          "id": 54052,
          "logo_path": null,
          "name": "Knickerbocker Films",
          "origin_country": ""
        },
        {
          "id": 25,
          "logo_path": "/qZCc1lty5FzX30aOCVRBLzaVmcp.png",
          "name": "20th Century Fox",
          "origin_country": "US"
        }
      ],
      "production_countries": [
        {"iso_3166_1": "US", "name": "United States of America"}
      ],
      "release_date": "1999-10-12",
      "revenue": 100853753,
      "runtime": 139,
      "spoken_languages": [
        {"iso_639_1": "en", "name": "English"}
      ],
      "status": "Released",
      "tagline":
          "How much can you know about yourself if you've never been in a fight?",
      "title": "Fight Club",
      "video": false,
      "vote_average": 7.8,
      "vote_count": 3439
    }
  ];

//
// cast
  List casts = [
    {
      "id": 550,
      "cast": [
        {
          "adult": false,
          "gender": 2,
          "id": 819,
          "known_for_department": "Acting",
          "name": "Edward Norton",
          "original_name": "Edward Norton",
          "popularity": 7.861,
          "profile_path": "/5XBzD5WuTyVQZeS4VI25z2moMeY.jpg",
          "cast_id": 4,
          "character": "The Narrator",
          "credit_id": "52fe4250c3a36847f80149f3",
          "order": 0
        },
        {
          "adult": false,
          "gender": 2,
          "id": 287,
          "known_for_department": "Acting",
          "name": "Brad Pitt",
          "original_name": "Brad Pitt",
          "popularity": 20.431,
          "profile_path": "/cckcYc2v0yh1tc9QjRelptcOBko.jpg",
          "cast_id": 5,
          "character": "Tyler Durden",
          "credit_id": "52fe4250c3a36847f80149f7",
          "order": 1
        },
        {
          "adult": false,
          "gender": 1,
          "id": 1283,
          "known_for_department": "Acting",
          "name": "Helena Bonham Carter",
          "original_name": "Helena Bonham Carter",
          "popularity": 14.399,
          "profile_path": "/mW1NolxQmPE16Zg6zuWyZlFgOwL.jpg",
          "cast_id": 6,
          "character": "Marla Singer",
          "credit_id": "52fe4250c3a36847f80149fb",
          "order": 2
        },
      ],
    }
  ];
}
