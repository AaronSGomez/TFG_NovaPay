<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-7C3AED?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-7C3AED?style=for-the-badge&logo=dart&logoColor=white)
![Cross Platform](https://img.shields.io/badge/Cross--Platform-Windows%20%7C%20Android-7C3AED?style=for-the-badge&logo=windows&logoColor=white)
![Isar](https://img.shields.io/badge/Database-Isar-7C3AED?style=for-the-badge&logo=isar&logoColor=white)
![GetX](https://img.shields.io/badge/State-GetX-7C3AED?style=for-the-badge&logo=getx&logoColor=white)

<div align="center">
  <img src="https://cdn.simpleicons.org/flutter" height="50" alt="Flutter" />
  <img src="https://cdn.simpleicons.org/dart" height="50" alt="Dart" />
  <img src="https://cdn.simpleicons.org/windows" height="50" alt="Windows" />
  <img src="https://cdn.simpleicons.org/android" height="50" alt="Android" />
  <img src="https://cdn.simpleicons.org/github/ffff" height="50" alt="GitHub" />
</div>

<div align="center">
  <h1>
    <img src="assets/images/ico.png" width="45" height="45" alt="NovaPay Logo" />
    NovaPay TPV — Solution
  </h1>
  <p><b>Solución integral de gestión comercial para hostelería y comercio con alto rendimiento offline</b></p>
</div>

[Características](#-características) • [Arquitectura](#-arquitectura)• [Uso](#-uso) • [Instalación](#-instalación)  

</div>

---

## 📸 Capturas de pantalla

<div align="center">
  <img src="assets/images/novapay.webp" width="800" alt="Interfaz de Ventas" />
</div>

<div align="center">
  <sub>Vista Principal de Comandas y Gestión de Mesas</sub>
</div>

---

## 📋 Descripción

**NovaPay** es una aplicación de Terminal Punto de Venta (TPV) de última generación, diseñada para la gestión eficiente de ventas, inventario y fiscalidad. La aplicación ofrece una interfaz táctil optimizada que permite realizar operaciones complejas de forma intuitiva, garantizando la persistencia de los datos en entornos sin conexión y proporcionando una experiencia de usuario premium mediante elementos multimedia dinámicos.

## ✨ Características

### 💰 Gestión de Ventas (Sala)
- **Comandas interactivas** - Selección rápida de productos por categorías.
- **Control de mesas** - Gestión visual de pedidos y estados.
- **Multitarea** - Múltiples tickets abiertos de forma simultánea.
- **Cálculo automático** - Desglose de impuestos (IVA) y totales en tiempo real.

### 📦 Inventario y Almacén
- **Catálogo dinámico** - Gestión completa de productos con imágenes y categorías.
- **Control de Stock** - Seguimiento de existencias y precios de coste/venta.
- **Configuración Fiscal** - Personalización de tipos impositivos por producto.

### 📄 Fiscalidad y Reportes
- **Generación de Tickets** - Creación de tickets en formato PDF listos para impresión.
- **Trazabilidad** - Registro histórico de cada transacción para auditoría.
- **Informes Diarios** - Cierres de caja y resúmenes de actividad automatizados.

### 👤 Seguridad y Sistema
- **Autenticación robusta** - Sistema de login con roles de administrador y usuario.
- **Persistencia NoSQL** - Base de datos Isar integrada para máxima velocidad.
- **Multimedia Splash** - Bienvenida dinámica con vídeo nativo.

## 🧩 Arquitectura

La aplicación sigue una arquitectura modular y limpia, garantizando la escalabilidad:

- **Data Models** → Definiciones tipadas y esquemas de Isar.
- **Business Services** → Lógica de negocio encapsulada (UserService, TicketService).
- **Controllers (GetX)** → Gestión reactiva del estado y flujo de datos.
- **Presentation Layer** → UI desacoplada mediante widgets reutilizables.

## 🛠️ Tecnologías

- **Framework**: Flutter 
- **Lenguaje**: Dart
- **Base de Datos**: Isar (Local-First)
- **Gestión de Estado**: GetX
- **Multimedia**: media_kit (Native Video Engine)
- **Reportes**: PDF & Printing Service
- **Control de versiones**: Git & GitHub

## 💻 Instalación

### Requisitos previos
- Flutter SDK >= 3.10.0
- Dart >= 3.0.0

```bash
# 1. Clonar el repositorio
git clone https://github.com/AaronSGomez/TFG_NovaPay.git

# 2. Instalar dependencias
flutter pub get

# 3. Generar código de base de datos
dart run build_runner build --delete-conflicting-outputs

# 4. Ejecutar (Modo Desarrollo)
flutter run
```

---

## 👥 Autores

**Aaron Gómez**
- GitHub: [@aaronsgomez](https://github.com/aaronsgomez)

**kabalera82**
- GitHub: [@kabalera82](https://github.com/kabalera82)

## 🙏 Agradecimientos
- **Olga Mª Moreno Martín** (Por su valiosa guía y apoyo)
- Profesores de DAM de Prometeo

---

<div align="center">
  <sub>Desarrollado para la excelencia en la gestión comercial</sub>
</div>
