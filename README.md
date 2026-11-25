# Interface Demo (Android)

Projeto Flutter novo, independente e de demonstração visual. Recria a organização visual da tela inicial de referência, sem integração bancária, autenticação financeira ou operações reais.

## APK
A cada push na branch main, o GitHub Actions compila um APK de release e publica o arquivo como artefato por 14 dias. Também é possível iniciar a compilação manualmente em Actions → Build Android Demo APK → Run workflow.

## Build local
```bash
flutter create --platforms=android --org com.demo --project-name nubank_interface_demo .
flutter pub get
flutter analyze
flutter build apk --release
```
