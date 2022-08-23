# Descrição

This project is a starting point for a Flutter application with Firebase Firestor.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)
- [Firebase w/ Flutter](https://firebase.google.com/docs/android/setup) 
- [Firestore w/ Flutter](https://firebase.google.com/docs/flutter/setup?platform=android) 

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# Instalando

- Leia: https://firebase.google.com/docs/flutter/setup?platform=android
- Baixe o flutter, descompacte em um diretório e adicione o caminho <code>[flutter_home]\bin</code> no path.
- Abra o VSCode. Abra o terminal e digite <code>flutter doctor</code>.
- Caso esteja dando algum erro, corrija. Alguns erros comuns são referentes à necessidade de reinstalar ou atualizar programas como o Visual Studio ou o Java. No caso do Visual Studio, ainda é necessário instalar o componente "Desktop development with C++".
- Instale o plugin do Flutter no VSCode (e as dependências que forem solicitadas, como o Dart).
- Abra o VSCode e baixe o código do repositório (https://github.com/gaaj-ufrpe/dsi_flutterfire_app).
- Abra o arquivo <code>main.dart</code> e rode o programa (<code>Executar > Executar sem Depuração (CTRL+F5)</code>). Pode ser necessário configurar um emulador android. Fique atento à instalação atualizada do JDK do Java e do Flutter. Se necessário ajuste o arquivo build.gradle para a versão específica do SDK do android.

# Getting Started




///LEIA:
///
///
///1) Para saber o nome do app, abra o arquivo 'android/app/build.gradle'
/// e procure a propriedade 'applicationId'. Por padrão o nome é:
/// [pacote completo].[nome do projeto]
/// Ex.: br.ufrpe.gaaj.dsi_flutterfire_app
///
///2) No Flutter Console, na página de "Visão Geral do Projeto", abaixo do nome do
/// projeto, há um botão "+Adicionar app". É nele que se deve clicar para liberar
/// o acesso do app ao firebase.
///
///3) Copiar o arquivo gerado para 'android/app'
///
///4) Ajustar o arquivo 'android/build.gradle' conforme orientação do Console do Firebase;
///
///5) Ajustar o arquivo 'android/app/build.gradle' conforme orientação do Console do Firebase.
///Tenha atenção para acessar a opção Java ou Kotlin conforme a linguagem utilizada no projeto.
///
///6) A aba de problemas do AndroidStudio, pode acusar alguma incompatibilidade de
/// versões do Kotlin ou outra lib. Faça os ajustes recomendados.
/// Ex.: neste projeto foi necessário alterar a propriedade 'ext.kotlin_version'
/// para a versão '1.5.31' no arquivo 'android/build.gradle'
///
///7) Acesse https://firebase.flutter.dev/ procure a lib 'firebase_core' e
///Acesse a pagina 'Installing', copie o código indicado para ser adicionado no
///pubspec.yaml e cole lá. Atenção para usar as últimas versões.
///Os tutoriais da internet geralmente utilizam versões mais antigas.
///Faça a mesma coisa para o plugin 'cloud_firestore'
///(No tutorial do vídeo abaixo, utiliza-se o Firebase Realtime e nã
///o o Firestore).
///
///
///DÚVIDAS? VEJA:
///https://www.youtube.com/watch?v=EXp0gq9kGxI
///
/// ADICIONAL:
/// https://firebase.flutter.dev/docs/firestore/usage/
/// https://medium.com/firebase-tips-tricks/how-to-use-cloud-firestore-in-flutter-9ea80593ca40
///