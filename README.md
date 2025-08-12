# IBM COS Load Test

This repo is designed to setup and run a simple load test based on IBM og against an existing on-premise IBM COS Solution.  

## Why is this repo here?

Out of the box, this solution is designed to generate a simple load.  Is not designed to generate a load to test/validate performance.   I created the [IBM COS OTEL Demo Environment](https://github.com/bcleonard/ibm_otel_demo_environment) repo to build out a simple OTEL stack to receive OTEL data from an IBM COS on-premise solution.  I found myself needing to see a load on the system (in the form of OBJECT traffic) to see what metrics are available.   I've also found myself in the past, needing the ability to throw a load at an IBM COS solution.

[IBM OG](https://github.com/IBM/og) is a perfect tool for doing that sort of work.  I spent a great deal of time trying to install, configure and generate load.   Way too much time for what I needed.

This repo is the result of the work.

## What type of load is generated?

Out of the box, this repo will build a docker container with [IBM OG](https://github.com/IBM/og) and the [AWS Command Line Interface](https://aws.amazon.com/cli/) installed.  There are four phases of the test:

### Phase 1: Data Wipe

This phase will connect to the IBM COS environment and delete any existing objects in the vaults/buckets via the aws cli.

### Phase 2: Initial Load

This phase will connect to the IBM COS environment and write an initial set of objects to the defined vaults/buckets using IBM og.

### Phase 3: Load Test

This phase will connect to the IBM COS environment and perform the actual load test which consists of reads, writes, and deletes using IBM og.   This phase will run indefinitely unless its killed by you or the test fails.

### Phase 4: Date Wipe

This phase only runs if the load test in phase 3 fails.  Again, this phase will connect to the IBM COS environment and delete objects on the vaults/buckets using the aws cli.

### Default Configuration

By default this repo will allow you to generated a load against an IBM COS solution in vault mode **OR** a against an IBM COS solution in container mode.  Due to IBM og configuration options and different access pools required for Container Mode Vs Vault mode you can only run a load against vaults or buckets at the same time, just not both.

#### For Vault mode

* all connections via https (port 443)
* 3 vaults - ogdata1, ogdata2, ogdata3
* Initial Load:
    * write approximately ~300 objects per vault
    * Object Size Distribution (per every 100 objects)
        * 80 objects evenly distributed between 2kb & 6kb in size
        * 10 objects evenly distributed between 3mb & 5mb in size
        * 10 objects evenly distributed between 90mb & 110mb in size
    * Request Rate
        * 240 Operations per minute
        * ramp up duration of 30 seconds
* Continuous Load:
    * Request Type (per every 100 objects)
        * 80 read requests
        * 10 object writes
        * 10 object delete
    * Object Size Distribution (per every 100 objects)
        * 80 objects evenly distributed between 2kb & 6kb in size
        * 10 objects evenly distributed between 3mb & 5mb in size
        * 10 objects evenly distributed between 90mb & 110mb in size
    * Request Rate
        * 240 Operations per minute
        * ramp up duration of 30 seconds

#### For Container mode

* all connections via https (port 443)
* 3 vaults - ogdata4, ogdata5, ogdata3=6
* Initial Load:
  * write approximately ~300 objects per vault
  * Object Size Distribution (per every 100 objects)
    * 80 objects evenly distributed between 2kb & 6kb in size
    * 10 objects evenly distributed between 3mb & 5mb in size
    * 10 objects evenly distributed between 90mb & 110mb in size
  * Request Rate
    * 240 Operations per minute
    * ramp up duration of 30 seconds
* Continuous Load:
  * Request Type (per every 100 objects)
    * 80 read requests
    * 10 object writes
    * 10 object delete
  * Object Size Distribution (per every 100 objects)
    * 80 objects evenly distributed between 2kb & 6kb in size
    * 10 objects evenly distributed between 3mb & 5mb in size
    * 10 objects evenly distributed between 90mb & 110mb in size
  * Request Rate
    * 240 Operations per minute
    * ramp up duration of 30 seconds

## Requirements

The following requirements are needed to run/execute this repo:

* x86 linux compatible environment
* docker engine (with docker compose) installed and working
* internet connection (need to clone the repo, connect to docker hub and github to build docker image)
* working IBM COS solution running in vault mode, container mode or mixed mode.

## How to configure & run

1. clone the repo
2. For Vault mode, create the following vaults, each vault must be accessible with the same access key & secret key:
  - ogdata1
  - ogdata2
  - ogdata3
3. For Vault Mode, edit the following configuration files:
  * vault_credentials.json - replace MY_ACCESS_KEY & MY_SECRET_KEY with your keys
  * vault_init_test.json - replace MY_ACCESSER with the hostname or IP address of your accesser or load balancer
  * vault_load_test.json - replace MY_ACCESSER with the hostname or IP address of your accesser or load balancer
4. For Container mode, create the following buckets, each bucket must be accessible with the same access key & secret key:
  * ogdata4
  * ogdata5
  * ogdata6
5. For Container Mode, edit the following configuration files:
  * container_credentials.json - replace MY_ACCESS_KEY & MY_SECRET_KEY with your keys
  * container_init_test.json - replace MY_ACCESSER with the hostname or IP address of your accesser or load balancer
  * container_load_test.json - replace MY_ACCESSER with the hostname or IP address of your accesser or load balancer
6. build the docker image:

```bash
docker compose build
```

7. To run the test for vault mode:

```bash
docker compose run
```

8. To run the test for container mode:

```bash
MODE=container docker compose run
```

## Support

This repo is provided as-is.  

If you have any problems or questions, open a issue above.  I'll try to answer any questions and fix any glaring problems when I have time.

## Acknowledgements
