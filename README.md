#Tsung log crunching utility

## Usage

```
RESULTS_DIR=/path/to/tsung/results OUTPUT_DIR=/some/output/location rake crunch
```

The rake crunch task will generate an HTML file under OUTPUT_DIR that contains pretty graphs
comparing all the tsung.log results that could be found in RESULTS_DIR.
