import 'client.dart';
import 'clients_response.dart';

abstract class IClientsRepository {
  Future<ClientsResponse> getClients([int? page]);
  Future<Client> getClient(int id);
  Future<Client> createClient({
    required String firstName,
    required String lastName,
    required String email,
  });
  Future<Client> updateClient(Client client);
  Future<void> deleteClient(int id);
}
