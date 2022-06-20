import 'client.dart';

class ClientsResponse {
  final List<Client> clients;
  final int total;

  const ClientsResponse({
    required this.clients,
    required this.total,
  });

  factory ClientsResponse.fromJson(Map<String, dynamic> json) {
    return ClientsResponse(
      clients: (json['data'] as List).map((client) {
        return Client.fromJson(client);
      }).toList(),
      total: json['total'] as int,
    );
  }
}
