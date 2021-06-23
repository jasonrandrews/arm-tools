# Dockerfiles for Arm Tools
This area contains various Docker examples for Arm tools. There are various mixes of Arm compilers, both commercial and open source, as well as Fast Models and Fixed Virtual Platforms. There are also images that are derived from a Gitpod base image so projects can run seamlessly in Gitpod. 

### Arm compilers
An Ubuntu 20.04 container image with [Arm Compiler](https://developer.arm.com/tools-and-software/embedded/arm-compiler) and bare-metal [GNU Toolchains for Arm processors](https://developer.arm.com/tools-and-software/open-source-software/developer-tools/gnu-toolchain). This is a just compilers image.

```bash
$ docker pull armswdev/arm-tools:bare-metal-compilers
```

### Arm Fast Models
An Ubuntu 18.04 container image with [Arm Fast Models](https://developer.arm.com/tools-and-software/simulation-models/fast-models). Fast Models can be used to build custom virtual platforms.

```bash
$ docker pull armswdev/arm-tools:fast-models
```

### Arm compilers and Fast Models
An Ubuntu 18.04 container image combining the above compilers and Fast Models content.
```bash
$ docker pull armswdev/arm-tools:compilers-fastmodels
```

The same content but built on the base Gitpod container is also available.
```bash
$ docker pull armswdev/arm-tools:compilers-fastmodels-gitpod
```


### Arm compilers and Fixed Virtual Platforms
An Ubuntu 18.04 container image combining the above compilers and [Fixed Virtual Platforms](https://developer.arm.com/tools-and-software/simulation-models/fixed-virtual-platforms)

```bash
$ docker pull armswdev/arm-tools:compilers-fvps
```

### Arm compilers and Corstone-300 FVP
An Ubuntu 18.04 container image combining the above compilers and the [Corstone-300 FVP](https://developer.arm.com/tools-and-software/open-source-software/arm-platforms-software/arm-ecosystem-fvps). Tools for working with CMSIS packs are included.

```bash
$ docker pull armswdev/arm-tools:corstone-300-fvp
```

### Arm machine learning evaluation kit
An Ubuntu 18.04 container image to run the [ML evaluation kit](https://review.mlplatform.org/plugins/gitiles/ml/ethos-u/ml-embedded-evaluation-kit/+/HEAD/docs/documentation.md#arm_ml-embedded-evaluation-kit).

```bash
$ docker pull armswdev/arm-tools:corstone-300-eval-kit
```

The same content but built on the base Gitpod container is also available.
```bash
$ docker pull armswdev/arm-tools:corstone-300-eval-kit-gitpod
```

### Running the containers
The containers are available on [Docker Hub](https://hub.docker.com/r/armswdev/arm-tools)

FlexLM licenses are not included. If a trial license is needed follow the [instructions on Arm Developer](https://developer.arm.com/documentation/102441/latest/Generate-Fast-Models-product-license)

### Passing the license server to the containers

To tell the containers where your FlexLM server is located use -e to pass an environemnt variable and insert your license server. 

A typical run command with a port@host licenses server:
```bash
$ docker run --rm -it -e ARMLMD_LICENSE_FILE=7010@licenseserver armswdev/arm-tools:<tag> /bin/bash
```
A typical run command with a license file would be:
```bash
$ docker run --rm -it -e ARMLMD_LICENSE_FILE=/home/ubuntu/license.dat armswdev/arm-tools:<tag> /bin/bash
```

Each variant has a build and run script if you want to make changes.

### Building the container images
```bash
$ ./build.sh
```

### Running the container images
```bash
$ ./run.sh
```

