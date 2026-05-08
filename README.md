# phoronix-test-suite-cloud
This directory contains a Phoronix Test Suite run script. This can be used to benchmark server performance for various purposes, such as testing server specs, comparing cloud providers, testing impact of security softwares, etc.

## Usage

### Docker Compose
From this directory (where `docker-compose.yml` lives):

```
docker compose up -d
docker compose exec pts /phoronix-test-suite/phoronix-test-suite batch-run local/lmwn
docker compose exec pts /phoronix-test-suite/phoronix-test-suite result-file-to-csv "mytestresults"
```

The argument to `result-file-to-csv` must match the saved results identifier. By default the compose file sets `TEST_RESULTS_NAME` to `mytestresults`; override it (for example in a `.env` file or `docker compose exec -e TEST_RESULTS_NAME=mytestresults ...`) so it matches the name you pass to `result-file-to-csv`.

* Currently there is no formatted output, so it might be a good idea to add `-v` to see test progress.
* The benchmark is run using a prebuilt Docker image with benchmarks already installed (see [suite-definition.xml](data/custom-suites/lmwn/suite-definition.xml) for the full test suite definition used.)
* The test can take several hours to complete. Estimated time by the tool is ~5 hours.
* The result will be exported in CSV format using `phoronix-test-suite result-file-to-csv <test_results_name>` command which will write the file to the mounted directory `./data/output` on the host machine (relative to the directory containing `docker-compose.yml`).
