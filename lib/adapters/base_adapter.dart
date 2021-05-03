import 'package:graphql/client.dart';
import 'package:hemdaal_ui_flutter/utils/graphql_client.dart';

class BaseNetworkAdapter {
  GraphQLClientProvider _graphQLClientProvider;

  BaseNetworkAdapter({GraphQLClientProvider? graphQLClientProvider})
      : _graphQLClientProvider =
            graphQLClientProvider ?? GraphQLClientProvider();

  Future<QueryResult> query(QueryOptions queryOptions) async {
    final graphQlClient = await _graphQLClientProvider.getGraphQLClient();
    return await graphQlClient.query(queryOptions);
  }
}
