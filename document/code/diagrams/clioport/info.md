# CoreLAB

**Modular Processor Simulation Framework**

Copyright (C) 2026 Pozsár Zsolt <pozsarzs@gmail.com>  

## CLIOPort application class diagram

### Meaning of the symbols used

* `..>`:  Dashed arrow, indicates dependency.
* `-->`:  Continuous arrow, indicates directed association, structural connection.
* `o-->`: Continuous arrow with empty rhombus on the starting side.
          It means aggregation, it loosely "contains" / expresses a possession
          relationship.

### Dependencies

* `TForm2 ..> TAboutLabels : uses`
Dependency: `TForm2` uses the `TAboutLabels` record (upward dashed arrow, "uses" label).
* `TForm1 ..> TPluginAttributes : uses`
Dependency: `TForm1` uses the `TPluginAttributes` record.
* `TForm1 ..> TOpDirection : uses`
Dependency: `TForm1` uses the `TOpDirection` enumeration.
* `TForm1 --> TForm2 : opens`
Association: `TForm1` knows and interacts with `TForm2` (continuous arrow, "opens" indicates opening).
* `TForm1 --> TForm3 : opens`
Association: `TForm1` knows and opens `TForm3`.
* `TForm1 --> TForm4 : opens`
Association: `TForm1` knows and opens `TForm4`.
* `TForm1 o--> TIOPort : CurrentPort`
Aggregation: `TForm1` contains (owns) a `TIOPort` object. The name of the connection is "CurrentPort" (empty rhombus from `TForm1`, arrow towards `TIOPort`).
* `TPluginAttributes --> TLineMode : uses`
Association: `TPluginAttributes` refers directly to the type `TLineMode` as a field.
* `TForm1 ..> TGIOPort : casts`
Dependency: `TForm1` knows the `TGIOPort` class because it converts to that type at runtime ("casts" tag).
* `TForm1 ..> TCreatePortFunc : uses`
Dependency: `TForm1` uses the function type `TCreatePortFunc` for the API call.
