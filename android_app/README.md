# Publicação na Google Play Store

Este diretório contém as instruções e recursos necessários para publicar o aplicativo na Google Play Store.

## Pré-requisitos

1. Conta de desenvolvedor Google Play (custo único de $25 USD)
2. Flutter SDK instalado e configurado
3. Android Studio instalado

## Passos para publicação

### 1. Prepare seu aplicativo

1. Certifique-se de que o código em `mobile_app` está completo e testado
2. Configure o arquivo `pubspec.yaml` com as informações corretas
3. Ajuste as configurações do Android no arquivo `android/app/build.gradle`

### 2. Gere um APK assinado ou App Bundle

```bash
# Usando o diretório mobile_app como base:
cd mobile_app

# Gere a chave de assinatura se ainda não tiver uma
keytool -genkey -v -keystore android/app/upload-keystore.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias upload

# Configure as chaves no arquivo key.properties 
# (crie o arquivo em android/key.properties)

# Gere o App Bundle para a Play Store (recomendado)
flutter build appbundle

# OU gere um APK assinado
flutter build apk --release
```

### 3. Prepare os recursos para a loja

1. **Capturas de tela**:
   - Smartphone: pelo menos 2 capturas (máximo 8)
   - Tablet: pelo menos 2 capturas (recomendado)
   - Requisitos: JPEG ou PNG, RGB, max 8MB

2. **Ícone da aplicação**:
   - Tamanho: 512x512 pixels
   - Formato: PNG 32-bit
   - Fundo opaco (sem transparência)

3. **Gráfico de recurso**:
   - Tamanho: 1024x500 pixels
   - Formato: JPG ou PNG 24-bit (sem transparência)
   - Sem cantos arredondados

4. **Vídeo promocional** (opcional):
   - YouTube URL
   - Não mais que 2 minutos
   - Resolução: 720p ou maior

5. **Descrição do aplicativo**:
   - Título: Gestão de Clientes
   - Descrição completa (até 4000 caracteres)
   - Descrição curta (até 80 caracteres)
   - Palavras-chave

### 4. Envio para a Play Store

1. Acesse o [Google Play Console](https://play.google.com/console/)
2. Crie um novo aplicativo
3. Preencha todas as informações da loja
4. Envie o App Bundle ou APK
5. Configurar preço e distribuição
6. Enviar para revisão

### 5. Atualizações futuras

1. Atualize a versão no arquivo `pubspec.yaml`
2. Gere um novo App Bundle ou APK
3. Faça o upload na Play Store como uma nova versão

## Recursos úteis

- [Documentação oficial do Flutter para publicação](https://flutter.dev/docs/deployment/android)
- [Google Play Console](https://play.google.com/console/)
- [Requisitos da Google Play Store](https://developer.android.com/distribute/best-practices/launch/launch-checklist)
- [Política da Google Play](https://play.google.com/about/developer-content-policy/) 