import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:graphql/client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GraphQLClientProvider {
  final _httpLink = HttpLink(env['REST_ENDPOINT_URL']!);

  Future<GraphQLClient> getGraphQLClient() async {
    final preference = await SharedPreferences.getInstance();

    final _authLink = AuthLink(
      getToken: () async => 'Bearer ${preference.getString('token')}',
    );

    Link _link = _authLink.concat(_httpLink);

    return GraphQLClient(
      cache: GraphQLCache(),
      link: _link,
    );
  }
}
