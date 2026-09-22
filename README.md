# ElektroHesap

ElektroHesap is an open-source Flutter application for preliminary electrical engineering calculations. It currently provides current, cable, voltage-drop, and preliminary protection-device calculations for single-phase and three-phase systems.

> **Engineering notice:** Results are preliminary calculations and must be reviewed by a qualified electrical engineer before design, installation, procurement, or commissioning. The bundled cable and resistance tables are marked `UNVERIFIED_DATA`; this project does not claim IEC or TSE compliance.

## Features

- Single-phase and three-phase current calculations
- Active power, voltage, power factor, and optional efficiency inputs
- Preliminary copper cable ampacity selection
- Copper and aluminium voltage-drop calculations
- Preliminary nominal protection-current suggestion
- Input validation and explainable calculation results
- Unit-tested calculation core

## Technology

- Flutter 3.41.5
- Dart 3.11.3
- Material UI
- No network service, account, or API key is required

## Getting started

Install Flutter, then run:

```bash
flutter pub get
flutter analyze
flutter test
flutter run
```

To build the web target:

```bash
flutter build web
```

## Project structure

```text
lib/
  core/calculations/   Calculation models, validation, services, and data
  screens/             Flutter screens
  widgets/             Shared UI widgets
test/                  Unit and widget tests
docs/                  Engineering assumptions and data-source notes
```

## Engineering scope and limitations

The calculation core intentionally uses explicit assumptions. The current voltage-drop model is resistive-only and does not model reactance, installation method, grouping, ambient temperature, conductor temperature, short-circuit withstand, or protective coordination. Protection-device curve selection is not inferred from power factor.

See:

- [Engineering assumptions](docs/ENGINEERING.md)
- [Data sources and verification status](docs/DATA_SOURCES.md)
- [Roadmap](ROADMAP.md)

## Contributing

Contributions are welcome. Please read [CONTRIBUTING.md](CONTRIBUTING.md) and include tests for calculation changes. Engineering-data changes require a traceable source and must not be presented as standards-compliant until reviewed.

## Security

Please report suspected vulnerabilities privately as described in [SECURITY.md](SECURITY.md). Do not include credentials, private keys, or personal data in issues or pull requests.

## License

ElektroHesap is released under the [MIT License](LICENSE).
