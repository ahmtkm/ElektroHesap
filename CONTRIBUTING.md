# Contributing to ElektroHesap

Thank you for contributing to ElektroHesap. The project values small, reviewable changes, reproducible calculations, and clear engineering assumptions.

## Before opening a pull request

1. Read the relevant documentation in `docs/`.
2. Keep the calculation core independent from Flutter UI code.
3. Add or update unit tests for calculation and validation changes.
4. Run `flutter pub get`, `flutter analyze`, `flutter test`, and `flutter build web`.
5. Explain any changed assumptions, constants, or data sources.

## Engineering data

Do not add electrical tables or constants without a traceable source. Clearly label values that have not been independently verified as `UNVERIFIED_DATA`. Do not claim IEC, TSE, or other standards compliance without documented review.

## Pull requests

Pull requests should have a focused scope, a descriptive title, test evidence, and notes about user-visible or engineering effects. Avoid committing generated build output, local SDK configuration, credentials, or signing keys.

## Code style

Use Dart formatting and existing project conventions. Prefer typed models, explicit validation, immutable calculation inputs, and clear error messages.
