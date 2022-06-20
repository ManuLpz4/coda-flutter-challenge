import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/clients/client.dart';
import '../../logic/clients/clients_provider.dart';
import '../../logic/clients/clients_state.dart';
import '../core/utils/snackbar.dart';
import '../core/utils/validator.dart';

class ClientPage extends StatefulWidget {
  final Client? client;

  const ClientPage({
    Key? key,
    this.client,
  }) : super(key: key);

  @override
  State<ClientPage> createState() => _ClientPageState();
}

class _ClientPageState extends State<ClientPage> {
  final _formKey = GlobalKey<FormState>();
  late final _firstNameController = TextEditingController(
    text: widget.client?.firstName,
  );
  late final _lastNameController = TextEditingController(
    text: widget.client?.lastName,
  );
  late final _emailController = TextEditingController(
    text: widget.client?.email,
  );

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ProviderListener(
      provider: clientsControllerProvider,
      onChange: _onClientsStateChange,
      child: Scaffold(
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              title: widget.client != null
                  ? const Text('Edit client')
                  : const Text('Add new client'),
              centerTitle: false,
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const Spacer(),
                      if (widget.client != null) ...[
                        CircleAvatar(
                          radius: 56,
                          backgroundColor: theme.primaryColor,
                          foregroundColor: theme.primaryIconTheme.color,
                          backgroundImage:
                              widget.client!.profilePictureUrl != null
                                  ? CachedNetworkImageProvider(
                                      widget.client!.profilePictureUrl!,
                                    )
                                  : null,
                          child: widget.client!.profilePictureUrl == null
                              ? Text(widget.client!.firstName[0].toUpperCase())
                              : null,
                        )
                      ] else ...[
                        CircleAvatar(
                            radius: 56,
                            backgroundColor: theme.primaryColor,
                            foregroundColor: theme.primaryIconTheme.color,
                            child: const Icon(Icons.person_rounded)),
                      ],
                      const SizedBox(height: 32),
                      TextFormField(
                        controller: _firstNameController,
                        autofocus: widget.client == null,
                        decoration: const InputDecoration(
                          hintText: 'First name',
                        ),
                        validator: (value) {
                          return Validator.validateFirstName(value);
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _lastNameController,
                        decoration: const InputDecoration(
                          hintText: 'Last name',
                        ),
                        validator: (value) => Validator.validateLastName(value),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          hintText: 'Email',
                        ),
                        validator: (value) => Validator.validateEmail(value),
                      ),
                      const SizedBox(height: 32),
                      const Spacer(),
                      Row(
                        children: [
                          Expanded(
                            child: TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('Cancel'),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: widget.client != null
                                  ? _updateClient
                                  : _createClient,
                              child: widget.client != null
                                  ? const Text('Save')
                                  : const Text('Add'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onClientsStateChange(BuildContext context, ClientsState clientsState) {
    Navigator.of(context).pop();

    if (clientsState is Error) {
      final errorMessage = widget.client != null
          ? 'Failed to update client'
          : 'Failed to create client';

      showErrorSnackBar(context, errorMessage);
    }
  }

  void _createClient() {
    if (_formKey.currentState!.validate()) {
      final clientsController = context.read(
        clientsControllerProvider.notifier,
      );
      clientsController.createClient(
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        email: _emailController.text,
      );
    }
  }

  void _updateClient() {
    if (_formKey.currentState!.validate()) {
      final clientsController =
          context.read(clientsControllerProvider.notifier);
      final updatedClient = widget.client!.copyWith(
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        email: _emailController.text,
      );
      clientsController.updateClient(updatedClient);
    }
  }
}
