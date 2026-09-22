# Engineering assumptions

ElektroHesap is a preliminary calculation aid. It is not a substitute for a complete electrical design, a qualified engineer’s review, local regulations, manufacturer instructions, or a verified standard-based design process.

## Current calculation

For active power `P` in kW, RMS voltage `V`, power factor `cosφ`, and efficiency `η`:

- Single phase: `I = P × 1000 / (V × cosφ × η)`
- Three phase: `I = P × 1000 / (√3 × V × cosφ × η)`

The default efficiency is `1.0`. Inputs must be finite, positive, and within the supported unit interval for `cosφ` and `η`.

## Voltage drop

The current implementation uses the original resistive model:

- Single phase: `ΔV = 2 × I × L × R / 1000`
- Three phase: `ΔV = √3 × I × L × R / 1000`
- Percentage: `ΔV% = ΔV / V × 100`

`L` is metres and `R` is represented as ohms per kilometre. Reactance, phase-angle effects, conductor temperature, installation method, grouping, and other correction factors are not currently modelled.

## Cable selection

Cable selection is a preliminary lookup against bundled data. It does not establish allowable current for a real installation. Installation method, insulation, ambient temperature, grouping, loaded conductors, short-circuit withstand, and protective coordination are not currently modelled.

Aluminium ampacity is intentionally not inferred from copper data or from a fixed multiplier. The application reports that aluminium ampacity data is unverified instead of presenting a manufactured engineering result.

## Protection selection

The protection calculator suggests the first nominal current that is not below the calculated load current, when such a value exists in the local catalogue. This is only a preliminary nominal suggestion. Cable coordination, overload protection, short-circuit protection, breaking capacity, selectivity, inrush current, and trip curves require separate review.

Curve types are not inferred from `cosφ`.

## Compliance statement

This repository makes no IEC, TSE, manufacturer, or regulatory compliance claim. Any future compliance statement requires documented source review, licensing review, engineering review, and tests appropriate to the claimed scope.
