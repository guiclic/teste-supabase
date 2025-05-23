import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import '../models/cliente_model.dart';
import '../services/supabase_service.dart';

class ClienteDetalhesScreen extends StatefulWidget {
  final String clienteId;

  const ClienteDetalhesScreen({Key? key, required this.clienteId}) : super(key: key);

  @override
  State<ClienteDetalhesScreen> createState() => _ClienteDetalhesScreenState();
}

class _ClienteDetalhesScreenState extends State<ClienteDetalhesScreen> {
  late Future<Cliente> _clienteFuture;
  bool _isLoading = false;

  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _telefoneController = MaskedTextController(mask: '(00) 00000-0000');
  final _enderecoController = TextEditingController();
  final _emailController = TextEditingController();
  final _observacoesController = TextEditingController();
  String _plano = 'Básico';
  String _idFly = '';

  @override
  void initState() {
    super.initState();
    _carregarCliente();
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _telefoneController.dispose();
    _enderecoController.dispose();
    _emailController.dispose();
    _observacoesController.dispose();
    super.dispose();
  }

  void _carregarCliente() {
    _clienteFuture = SupabaseService.instance.getClienteById(widget.clienteId);
    _clienteFuture.then((cliente) {
      _nomeController.text = cliente.nome;
      _telefoneController.text = cliente.telefone;
      _enderecoController.text = cliente.endereco;
      _emailController.text = cliente.email;
      _plano = cliente.plano;
      _idFly = cliente.idFly;
      if (cliente.observacoes != null) {
        _observacoesController.text = cliente.observacoes!;
      }
    });
  }

  Future<void> _salvarAlteracoes(Cliente cliente) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final clienteAtualizado = cliente.copyWith(
        nome: _nomeController.text,
        telefone: _telefoneController.text,
        endereco: _enderecoController.text,
        email: _emailController.text,
        plano: _plano,
        idFly: _idFly,
        observacoes: _observacoesController.text,
      );

      await SupabaseService.instance.atualizarCliente(clienteAtualizado);
      
      if (!mounted) return;
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Cliente atualizado com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );
      
      Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao atualizar cliente: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _atualizarStatus(Cliente cliente, String novoStatus) async {
    setState(() {
      _isLoading = true;
    });

    try {
      await SupabaseService.instance.atualizarStatus(cliente.id, novoStatus);
      
      if (!mounted) return;
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Status atualizado para $novoStatus'),
          backgroundColor: Colors.green,
        ),
      );
      
      Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao atualizar status: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Cliente'),
        backgroundColor: const Color(0xFF0056B3),
      ),
      body: FutureBuilder<Cliente>(
        future: _clienteFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Erro ao carregar dados: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData) {
            return const Center(
              child: Text('Cliente não encontrado'),
            );
          }

          final cliente = snapshot.data!;
          
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cliente.nome,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0056B3),
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildTextField(
                    controller: _nomeController,
                    label: 'Nome',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira o nome';
                      }
                      return null;
                    },
                  ),
                  _buildTextField(
                    controller: _telefoneController,
                    label: 'Telefone',
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira o telefone';
                      } else if (value.replaceAll(RegExp(r'\D'), '').length < 10) {
                        return 'Telefone inválido';
                      }
                      return null;
                    },
                  ),
                  _buildTextField(
                    controller: _enderecoController,
                    label: 'Endereço',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira o endereço';
                      }
                      return null;
                    },
                    maxLines: 3,
                  ),
                  _buildTextField(
                    controller: _emailController,
                    label: 'Email',
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira o email';
                      } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                        return 'Email inválido';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: _plano,
                    decoration: const InputDecoration(
                      labelText: 'Plano',
                      border: OutlineInputBorder(),
                    ),
                    items: const [
                      DropdownMenuItem(value: 'Básico', child: Text('Básico')),
                      DropdownMenuItem(value: 'Premium', child: Text('Premium')),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _plano = value;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    initialValue: _idFly,
                    label: 'ID FLY',
                    onChanged: (value) {
                      _idFly = value;
                    },
                  ),
                  _buildTextField(
                    controller: _observacoesController,
                    label: 'Observações',
                    maxLines: 4,
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _isLoading
                              ? null
                              : () => _salvarAlteracoes(cliente),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: _isLoading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : const Text('Salvar Alterações'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  const Divider(),
                  const SizedBox(height: 8),
                  const Text(
                    'Alterar Status',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0056B3),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _isLoading
                              ? null
                              : () => _atualizarStatus(cliente, 'Concluido'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: const Text('Marcar como Concluído'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _isLoading
                              ? null
                              : () => _atualizarStatus(cliente, 'Cancelado'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: const Text('Marcar como Cancelado'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextField({
    TextEditingController? controller,
    String? initialValue,
    required String label,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
    int maxLines = 1,
    void Function(String)? onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        initialValue: initialValue,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        keyboardType: keyboardType,
        validator: validator,
        maxLines: maxLines,
        onChanged: onChanged,
      ),
    );
  }
} 