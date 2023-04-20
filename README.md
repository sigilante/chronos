#   `%chronos`:  An Urbit Library for Calendrics

**wip ~2023.4.20**

We need a library for all manner of date/time representations and conversions, including time zone and date line shenanigans.

This library should handle:

- `da` Urbit-native `@da` and `@dr` values
- `ju` Julian days
- `iso` [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601)
  - Regex:  `'/^([\+-]?\d{4}(?!\d{2}\b))((-?)((0[1-9]|1[0-2])(\3([12]\d|0[1-9]|3[01]))?|W([0-4]\d|5[0-2])(-?[1-7])?|(00[1-9]|0[1-9]\d|[12]\d{2}|3([0-5]\d|6[1-6])))([T\s]((([01]\d|2[0-3])((:?)[0-5]\d)?|24\:?00)([\.,]\d+(?!:))?)?(\17[0-5]\d([\.,]\d+)?)?([zZ]|([\+-])([01]\d|2[0-3]):?([0-5]\d)?)?)?)?$/'`
- `gc` Gregorian calendar
- `jc` Julian calendar
- `hb` Jewish Hebrew calendar
- `hj` Islamic Hijri calendar
- `ch` Chinese calendar
- `zo` Zoroastrian
- `shire` Shire time
- `local` Hyperlocal time based on longitude
- `med` Catholic saints (medieval)
- `fr` French Revolutionary calendar

It will canonically convert values via `@da` or Julian days at Coordinated Universal Time (UTC/GMT).

https://en.wikipedia.org/wiki/Calendar




##  Resources

Regular Expressions:

- Evelyn Kokemoor `lynko` `/lib/regex.hoon`
- [Regex 101 Tool](https://regex101.com/)

ISO 8601:

- [“ISO 8601 Date Validation That Doesn't Suck”, Intervals Blog](https://www.myintervals.com/blog/2009/05/20/iso-8601-date-validation-that-doesnt-suck/)
- [DenCode ISO 8601 Date Converter Online](https://dencode.com/en/date/iso8601)
