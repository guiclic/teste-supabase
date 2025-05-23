class Cliente {
  final String id;
  final String nome;
  final String telefone;
  final String endereco;
  final String email;
  final String plano;
  final String idFly;
  final String status;
  final String? observacoes;
  final DateTime createdAt;
  final DateTime updatedAt;

  Cliente({
    required this.id,
    required this.nome,
    required this.telefone,
    required this.endereco,
    required this.email,
    required this.plano,
    required this.idFly,
    required this.status,
    this.observacoes,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Cliente.fromJson(Map<String, dynamic> json) {
    return Cliente(
      id: json['id'],
      nome: json['nome'],
      telefone: json['telefone'],
      endereco: json['endereco'],
      email: json['email'],
      plano: json['plano'],
      idFly: json['id_fly'] ?? '',
      status: json['status'],
      observacoes: json['observacoes'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'telefone': telefone,
      'endereco': endereco,
      'email': email,
      'plano': plano,
      'id_fly': idFly,
      'status': status,
      'observacoes': observacoes,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  Cliente copyWith({
    String? nome,
    String? telefone,
    String? endereco,
    String? email,
    String? plano,
    String? idFly,
    String? status,
    String? observacoes,
  }) {
    return Cliente(
      id: this.id,
      nome: nome ?? this.nome,
      telefone: telefone ?? this.telefone,
      endereco: endereco ?? this.endereco,
      email: email ?? this.email,
      plano: plano ?? this.plano,
      idFly: idFly ?? this.idFly,
      status: status ?? this.status,
      observacoes: observacoes ?? this.observacoes,
      createdAt: this.createdAt,
      updatedAt: DateTime.now(),
    );
  }
} 