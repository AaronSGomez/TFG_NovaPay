# 💳 NovaPay — Frontend Mobile

Aplicación móvil multiplataforma desarrollada con **Flutter**. Interfaz de usuario para una plataforma de pagos con reproducción de vídeo, base de datos local y arquitectura limpia.

---

## Stack Tecnológico

- **Framework:** Flutter (Dart)
- **State Management:** GetX
- **Base de datos local:** Isar
- **Reproductor de vídeo:** media_kit
- **Inyección de dependencias:** get_it
- **Programación funcional:** dartz (Either, Option)
- **Plataformas:** Android, iOS, Windows, Web, macOS

---

## Características

- 📹 Reproducción de vídeo nativo con media_kit
- 💾 Persistencia local con Isar (NoSQL embebido)
- 🎯 Inyección de dependencias con get_it
- ⚡ Estado reactivo con GetX
- 🧩 Arquitectura limpia con dartz para manejo de errores funcional
- 🌐 Multiplataforma: móvil, escritorio y web

---

## Instalación

### Requisitos previos

- Flutter SDK >= 3.10.0
- Dart >= 3.0.0

```bash
# 1. Clonar el repositorio
git clone https://github.com/kabalera82/novapay-frontend.git
cd novapay-frontend

# 2. Instalar dependencias
flutter pub get

# 3. Generar código (Isar)
dart run build_runner build --delete-conflicting-outputs

# 4. Ejecutar la app
flutter run
```

---

## Estructura del Proyecto

```
lib/
├── main.dart               # Punto de entrada
└── (features en desarrollo)

assets/
├── images/
│   └── novapay.webp        # Imagen de presentación
└── videos/
    └── novapay.mp4         # Vídeo de presentación
```

---

## Dependencias Principales

| Paquete | Versión | Uso |
|---------|---------|-----|
| `get` | ^4.6.5 | State management |
| `get_it` | ^7.6.0 | Inyección de dependencias |
| `isar` | ^3.1.0 | Base de datos local |
| `media_kit` | ^1.2.6 | Reproducción de vídeo |
| `dartz` | ^0.10.0 | Programación funcional |
| `intl` | ^0.19.0 | Internacionalización |

---

## Autor

**kabalera82** — [GitHub](https://github.com/kabalera82)

## arranque limpio
flutter run --dart-define=TEST_RESET_ON_START=true