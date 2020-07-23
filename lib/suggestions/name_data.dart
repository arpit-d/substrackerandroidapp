import 'dart:math';

class BackendService {
  static Future<List> getSuggestions(String query) async {
    return List.generate(3, (index) {
      return {'name': query + index.toString(), 'price': Random().nextInt(100)};
    });
  }
}

class NamesService {
  static final List<String> names = [
    'Voot'
    'Netflix',
    'Udemy',
    'Spotify',
    'Apple Music',
    'Dashlane',
    'Dropbox',
    'Youtube Premium',
    'Youtube Music',
    'Youtube Premium+Music',
    'Express VPN',
    'Nord VPN',
    'Firebase',
    'Financial Times',
    'Money Control',
    'Times Of India',
    'The Hindu',
    'Economic Times',
    'Flipkart Plus',
    'Medical Insurance',
    'Car Insurance',
    'One Drive',
    'Gym',
    'Plural Sight',
    'Pocket',
    'Google Drive',
    'Proton VPN',
    'EMI',
    'VPN',
    'Fixed Deposit',
    'Sony Liv',
    'Zee5',
    'Voot',
    'Stripe',
    'The New York Times',
    'Wall Street Journal',
    'Home Mortage',
    'Twitch',
    'Xbox',
    'Amazon Prime',
    'Github Pro',
    'Hulu',
    'LinkedIn',
    'Medium',
    'McAfee',
    'Microsoft Office',
    'Evernote',
    'Phone Bill',
    'Internet',
    'Disney+',
    'Disney+Hotstar Premium',
    'Disney+Hotstar VIP',
    'Gaana Premium',
    'Wnyk',
    'Tata Sky',
    'Airtel DTH',
    'Sydney',
  ];

  static List<String> getSuggestions(String query) {
    List<String> matches = List();
    matches.addAll(names);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
}