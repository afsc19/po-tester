# Automatic Tests for the OOP Project -- PO25 @ LEIC-A

This repository maintains and runs a set of input-output tests for the OOP project.

Full information can be found on the [official Fénix page](https://fenix.tecnico.ulisboa.pt/disciplinas/PO112/2025-2026/1-semestre) ([Projecto](https://fenix.tecnico.ulisboa.pt/disciplinas/PO112/2025-2026/1-semestre/projecto)) or on the [OOP wiki](https://web.tecnico.ulisboa.pt/~david.matos/w/pt/index.php/Programa%C3%A7%C3%A3o_com_Objectos) ([Projecto](https://web.tecnico.ulisboa.pt/~david.matos/w/pt/index.php/Programa%C3%A7%C3%A3o_com_Objectos/Projecto_de_Programa%C3%A7%C3%A3o_com_Objectos)). 

In these scripts and directories, "e0" is the frst delivery (UML), "ei" is the
intermediate delivery, and "ef" is the final delivery.

All deliveries are mandatory.

## Structure

This repository is structured as follows:
* `auto-tests` -- test cases (input-output)
* `logs` -- per-group test results (`.res` is a summary, `.log` provides details)
* `sane` -- canonical materials (will replace the ones in individual projects)
* test scripts

## Test scripts 

The tests runner uses the main `run.sh` script to run all the tests.

The individual scripts have the following functions:
* `0-begin` -- prepare the new report
* `1-clone` -- fetch projects to be tested (by default, all in the `prj` sibling subgroup)
* `2-clean` -- remove extraneous materials
* `3-prepare` -- restore canonical materials and prepare for testing
* `4-test` -- run the input/output tests (uses the `test-group.sh` script)
* `5-summarize` -- analyse test results
* `6-end` -- close the report

The `test-group.sh` script tests a single project against a test suite.

A global summary of all tests for all groups is provided in [`GLOBAL-REPORT.md`](GLOBAL-REPORT.md).
Students whose result is **NO DELIVERY** (at each deadline) will be excluded from the course.
Other specific conditions may apply at each delivery (check the evaluation conditions and the report file).

## Input/Output Tests
* Descriptions: [`auto-tests/README.md`](auto-tests/README.md)

## Delivery results

* Entrega Inicial (UML): [`GLOBAL-REPORT-e0.md`](GLOBAL-REPORT-e0.md)
* Entrega Intermédia: [`GLOBAL-REPORT-e1.md`](GLOBAL-REPORT-e1.md)
* Entrega Final: [`GLOBAL-REPORT-e2.md`](GLOBAL-REPORT-e2.md)

## Forking this project

If you fork this project to run your tests, you will need to adapt (at least) the `1-clone` scripts.
By default, it tries to clone all the projects in the `prj` subgroup. In general, this is not allowed for regular users.

## Support 

Questions should be directed to [po25@inesc-id.pt](mailto:po25@inesc-id.pt).

