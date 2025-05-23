# Aplicativo de Gestão de Clientes

Aplicativo móvel para gerenciamento de clientes desenvolvido com Flutter e Supabase.

## Funcionalidades

- Lista de clientes com status "Em aberto"
- Detalhes do cliente com formulário para edição
- Atualização de status (Em aberto, Concluído, Cancelado)
- Validação de formulários
- Armazenamento de dados na nuvem via Supabase

## Estrutura do Projeto

```
mobile_app/
├── lib/
│   ├── models/           # Modelos de dados (Cliente)
│   ├── screens/          # Telas da aplicação
│   ├── services/         # Serviços (conexão com Supabase)
│   ├── widgets/          # Widgets reutilizáveis
│   └── main.dart         # Ponto de entrada da aplicação
├── assets/
│   └── images/           # Imagens e ícones
└── pubspec.yaml          # Configuração do projeto e dependências
```

## Pré-requisitos

- Flutter SDK 3.16.0 ou superior
- Dart 3.2.0 ou superior
- Conexão com internet (para acesso ao Supabase)

## Configuração do Ambiente

1. Instale o Flutter SDK:
   ```
   https://flutter.dev/docs/get-started/install
   ```

2. Clone este repositório:
   ```
   git clone https://seu-repositorio.git
   cd mobile_app
   ```

3. Instale as dependências:
   ```
   flutter pub get
   ```

## Execução

### Desenvolvimento

```bash
# Para executar o aplicativo em modo de desenvolvimento
flutter run
```

### Produção

```bash
# Para Android
flutter build apk --release

# Para iOS
flutter build ipa
```

## Tecnologias Utilizadas

- **Flutter**: Framework UI para desenvolvimento multiplataforma
- **Supabase**: Backend como serviço para armazenamento e autenticação
- **Provider**: Gerenciamento de estado
- **Flutter Masked Text**: Formatação de campos de texto

## Publicação nas Lojas

Para publicar o aplicativo nas lojas, siga as instruções nos diretórios:

- **Android**: Veja o arquivo `android_app/README.md`
- **iOS**: Veja o arquivo `ios_app/README.md` 