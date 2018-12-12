# bolt_compliance

Welcome to your new module. A short overview of the generated parts can be found in the PDK documentation at https://puppet.com/pdk/latest/pdk_generating_modules.html .

The README template below provides a starting point with details about what information to include in your README.

#### Table of Contents

1. [Description](#description)
2. [Setup - The basics of getting started with bolt_compliance](#setup)
   - [What bolt_compliance affects](#what-bolt_compliance-affects)
   - [Setup requirements](#setup-requirements)
   - [Beginning with bolt_compliance](#beginning-with-bolt_compliance)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Limitations - OS compatibility, etc.](#limitations)

## Description

An example module showing how to implement CIS compliance testing tasks and plans which can send the output to Splunk.

## Setup

### Install the bolt_compliance module

```bash
puppet module install puppetlabs-stdlib
mkdir ~/modules
cd ~/modules
git clone https://github.com/timidri/bolt_compliance.git
cd bolt_compliance
```

### Configure Splunk

To use bolt_compliance, you need to create a Splunk HTTP Event Collector token in a Splunk Enterprise instance available to you. See [Splunk HEC Service](https://docs.splunk.com/Documentation/Splunk/latest/Data/UsetheHTTPEventCollector) for guidance.

Then, create a configuration file `splunk-config.yaml`:

```bash
cp splunk-config-default.yaml splunk-config.yaml
```

and configure the Splunk HEC endpoint and token there.

## Usage

To run a compliance plan, make sure you have some CentOS or Red Hat 7 nodes configured in the inventory.yaml. Then, you can run the plan as follows:

```bash
bolt plan run bolt_compliance::run --params '{"controls": ["1_1_2", "5_1_1"]}' -n all
```

to perform both available control checks on all the configured nodes.

## Limitations

The examples are for PoC / educational purposes only and only work on RHEL7 target nodes.
