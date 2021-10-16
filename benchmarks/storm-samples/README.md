# Commands

```bash
$ storm-pgcl --pgclfile coupon.15-4.v1.pgcl --to-jani coupon.15-4.v1.jani --prop coupon.v1.props
$ storm --jani coupon.15-4.v1.jani --janiproperty --constants B=5 --engine hybrid --bisimulation --bisimulation:quot sparse --exact --timemem --verbose --progress 2
$ storm --jani jobs.15-3.v1.jani --janiproperty --exact --timemem --verbose --progress 2

# Dinning Cryptographers.
$ storm --prism dinning_crypt.prism --prop dinning_crypt.pctl
```
