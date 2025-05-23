# Publicação na Apple App Store

Este diretório contém as instruções e recursos necessários para publicar o aplicativo na Apple App Store.

## Pré-requisitos

1. Conta de desenvolvedor Apple (custo anual de $99 USD)
2. Flutter SDK instalado e configurado
3. Xcode instalado em um Mac
4. Dispositivo físico iOS para testes (recomendado)

## Passos para publicação

### 1. Prepare seu aplicativo

1. Certifique-se de que o código em `mobile_app` está completo e testado
2. Configure o arquivo `pubspec.yaml` com as informações corretas
3. Ajuste as configurações do iOS no diretório `ios`

### 2. Configure o projeto no Xcode

```bash
# Usando o diretório mobile_app como base:
cd mobile_app

# Abra o projeto iOS no Xcode
open ios/Runner.xcworkspace
```

No Xcode:
1. Certifique-se de que o Bundle Identifier seja único (ex: `com.seudominio.gestaoclientes`)
2. Configure a versão do aplicativo e o número de compilação
3. Adicione ícones e recursos de inicialização
4. Configure as capacidades necessárias

### 3. Crie um certificado de distribuição e perfil de provisionamento

1. Acesse o [Apple Developer Portal](https://developer.apple.com/)
2. Crie um certificado de distribuição App Store
3. Registre o App ID
4. Crie um perfil de provisionamento para distribuição
5. Baixe e instale o perfil no Xcode

### 4. Prepare o aplicativo para envio

```bash
# Crie um arquivo IPA de produção
flutter build ipa
```

### 5. Prepare os recursos para a App Store

1. **Capturas de tela**:
   - iPhone: pelo menos 1 captura para cada tamanho (6.5", 5.5", 4.7")
   - iPad: pelo menos 1 captura (se suportado)
   - Requisitos: JPEG ou PNG, RGB

2. **Ícone da aplicação**:
   - Tamanho: 1024x1024 pixels
   - Formato: PNG, RGB, sem transparência
   - Sem cantos arredondados ou efeitos

3. **Metadados**:
   - Título: Gestão de Clientes (até 30 caracteres)
   - Subtítulo (até 30 caracteres)
   - Descrição (até 4000 caracteres)
   - Palavras-chave (até 100 caracteres)
   - URL de suporte
   - URL de marketing (opcional)

4. **Informações da App Review**:
   - Informações de contato
   - Notas da revisão (instruções para testadores)
   - Credenciais de teste (se necessário)

### 6. Envio para a App Store

1. Acesse o [App Store Connect](https://appstoreconnect.apple.com/)
2. Crie um novo aplicativo
3. Preencha todos os metadados e uploads de recursos
4. Faça upload do arquivo IPA usando o Xcode ou Transporter
5. Envie para análise

### 7. Atualizações futuras

1. Atualize a versão e o número de compilação
2. Crie um novo arquivo IPA
3. Faça o upload para o App Store Connect
4. Atualize os metadados, se necessário
5. Envie para análise

## Recursos úteis

- [Documentação oficial do Flutter para publicação iOS](https://flutter.dev/docs/deployment/ios)
- [App Store Connect](https://appstoreconnect.apple.com/)
- [Diretrizes de análise da App Store](https://developer.apple.com/app-store/review/guidelines/)
- [Formulário de envio para a App Store](https://help.apple.com/app-store-connect/#/dev3f2d7bde7) 