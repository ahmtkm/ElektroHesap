# Data sources and verification status

## Current status

The electrical tables currently bundled in `lib/core/calculations/data/cable_catalog.dart` originate from the prototype and have not yet been independently verified for source, edition, licensing, temperature, installation method, or applicability.

They are therefore labelled:

```text
UNVERIFIED_DATA
```

They must not be described as IEC- or TSE-compliant data.

## Data currently present

- Copper ampacity values used by the preliminary cable lookup.
- Copper resistance values used by the resistive voltage-drop model.
- Aluminium resistance values used by the resistive voltage-drop model.
- Nominal protection-current values used by the preliminary suggestion.

## Required verification record

Before any table is presented as engineering-ready, record the exact source title, publisher, edition, publication date, licence terms, units, conductor temperature, installation assumptions, transformations, and independent engineering review.

Do not copy protected standards or manufacturer tables into the repository unless redistribution rights are clear. When licensing prevents redistribution, implement a documented adapter or user-provided data workflow instead.

## How to propose a data correction

Use the engineering-data issue template. Include the source, licence information, affected values, units, assumptions, and reproducible expected results. Do not silently replace values in a pull request.
