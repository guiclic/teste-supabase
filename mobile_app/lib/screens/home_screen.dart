import 'package:flutter/material.dart';
import '../models/cliente_model.dart';
import '../services/supabase_service.dart';
import 'cliente_detalhes_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Cliente>> _clientesFuture;

  @override
  void initState() {
    super.initState();
    _carregarClientes();
  }

  void _carregarClientes() {
    _clientesFuture = SupabaseService.instance.getClientesEmAberto();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestão de Clientes'),
        backgroundColor: const Color(0xFF0056B3),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 16.0),
              child: Text(
                'Clientes com Status: Em Aberto',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Cliente>>(
                future: _clientesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Erro ao carregar dados: ${snapshot.error}',
                        textAlign: TextAlign.center,
                      ),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text(
                        'Não há clientes com status "Em aberto" no momento.',
                        textAlign: TextAlign.center,
                      ),
                    );
                  } else {
                    return RefreshIndicator(
                      onRefresh: () async {
                        setState(() {
                          _carregarClientes();
                        });
                      },
                      child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final cliente = snapshot.data![index];
                          return _buildClienteCard(cliente);
                        },
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClienteCard(Cliente cliente) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ClienteDetalhesScreen(clienteId: cliente.id),
            ),
          );
          
          if (result == true) {
            setState(() {
              _carregarClientes();
            });
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cliente.nome,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0056B3),
                ),
              ),
              const SizedBox(height: 8),
              _buildInfoItem('Telefone', cliente.telefone),
              _buildInfoItem('Email', cliente.email),
              _buildInfoItem('Plano', cliente.plano),
              if (cliente.idFly.isNotEmpty) _buildInfoItem('ID FLY', cliente.idFly),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ClienteDetalhesScreen(clienteId: cliente.id),
                        ),
                      ).then((_) => setState(() => _carregarClientes()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0056B3),
                    ),
                    child: const Text('Editar'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(color: Colors.black, fontSize: 14),
          children: [
            TextSpan(
              text: '$label: ',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }
} 