# Commands

```bash
$ storm-pgcl --pgclfile coupon.15-4.v1.pgcl --to-jani coupon.15-4.v1.jani --prop coupon.v1.props
$ storm --jani coupon.15-4.v1.jani --janiproperty --constants B=5 --engine hybrid --bisimulation --bisimulation:quot sparse --exact --timemem --verbose --progress 2
$ storm --jani jobs.15-3.v1.jani --janiproperty --exact --timemem --verbose --progress 2

# Dinning Cryptographers.
$ storm --prism dinning_crypt.prism --prop dinning_crypt.pctl
```

## Partiton Example

```bash
$ storm-conv --prism partition_dtmc.pm --prop partition_dtmc.pctl --tojani partition_dtmc.jani
$ storm --jani partition_dtmc.jani --janiproperty --exact --timemem --verbose --exportjanidot model.dot

# less verbose
$ storm --jani partition_dtmc.jani --janiproperty --exact --sound --exportjanidot model.dot
```
