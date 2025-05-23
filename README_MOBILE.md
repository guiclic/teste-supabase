# Projeto Gestão de Clientes - Mobile

Este projeto contém a estrutura necessária para transformar o aplicativo web de Gestão de Clientes em aplicativos móveis para publicação nas lojas Android e iOS.

## Estrutura do Projeto

```
./
├── mobile_app/           # Código-fonte do aplicativo Flutter (multiplataforma)
│   ├── lib/              # Código Dart
│   ├── assets/           # Recursos (imagens, fontes)
│   └── pubspec.yaml      # Configuração do projeto Flutter
│
├── android_app/          # Recursos e instruções para publicação no Google Play
│   └── README.md         # Guia de publicação na Google Play Store
│
└── ios_app/              # Recursos e instruções para publicação na App Store
    └── README.md         # Guia de publicação na Apple App Store
```

## Sobre o Aplicativo

Este aplicativo móvel mantém as mesmas funcionalidades do aplicativo web:

- Lista de clientes com status "Em aberto"
- Detalhes do cliente com formulário para edição
- Atualização de status (Em aberto, Concluído, Cancelado)
- Validação de formulários

O aplicativo usa o mesmo banco de dados Supabase, garantindo que os dados sejam compartilhados entre as versões web e móvel.

## Próximos Passos

Para completar o desenvolvimento e publicação do aplicativo, siga estas etapas:

### 1. Configurar o ambiente Flutter

```bash
# Instalar o Flutter (veja instruções para seu sistema operacional)
# https://flutter.dev/docs/get-started/install

# Verificar instalação
flutter doctor
```

### 2. Desenvolver o aplicativo

```bash
# Entrar no diretório do projeto
cd mobile_app

# Obter dependências
flutter pub get

# Executar o aplicativo em modo de desenvolvimento
flutter run
```

### 3. Testar em dispositivos reais

```bash
# Listar dispositivos conectados
flutter devices

# Executar em um dispositivo específico
flutter run -d [ID-DO-DISPOSITIVO]
```

### 4. Gerar versões de produção

```bash
# Para Android
flutter build apk --release
# ou
flutter build appbundle --release

# Para iOS (apenas em macOS)
flutter build ipa
```

### 5. Publicar nas lojas

Siga as instruções detalhadas nos seguintes arquivos:
- Para Android: `android_app/README.md`
- Para iOS: `ios_app/README.md`

## Recursos Adicionais

- [Flutter Documentation](https://flutter.dev/docs)
- [Supabase Flutter SDK](https://supabase.com/docs/reference/dart/start)
- [Flutter Cookbook](https://flutter.dev/docs/cookbook)

## Notas Importantes

1. **Chaves de API**: O aplicativo já está configurado com as credenciais do Supabase, mas em um ambiente de produção, você deve proteger essas chaves.

2. **Testes**: Antes de publicar, realize testes completos em diferentes dispositivos para garantir compatibilidade.

3. **Políticas das lojas**: Revise cuidadosamente as políticas da Google Play Store e Apple App Store para garantir que seu aplicativo esteja em conformidade. 