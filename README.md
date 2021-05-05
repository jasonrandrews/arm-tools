# Dockerfiles for Arm Tools
This area contains various Docker examples for Arm tools. 

### Arm compilers
An Ubuntu 20.04 container image with [Arm Compiler](https://developer.arm.com/tools-and-software/embedded/arm-compiler) and bare-metal [GNU Toolchains for Arm processors](https://developer.arm.com/tools-and-software/open-source-software/developer-tools/gnu-toolchain)

### Arm Fast Models
An Ubuntu 18.04 container image with [Arm Fast Models](https://developer.arm.com/tools-and-software/simulation-models/fast-models)

### Running the containers
The containers are avialble on Docker Hub.
```bash
$ docker pull armswdev/arm-bare-metal-compilers
$ docker pull armswdev/arm-fast-models
```

FlexLM licenses are not included. If a trial license is needed follow the [instructions on Arm Developer](https://developer.arm.com/documentation/102441/latest/Generate-Fast-Models-product-license)

### Passing the license server to the containers

To tell the containers where your FlexLM server is located use -e to pass an environemnt variable and insert your license server. 
```bash
$ ./run.sh -e ARMLMD_LICENSE_FILE=7010@licenseserver
```

### Building the container images
```bash
$ ./build.sh
```

### Running the container images
```bash
$ ./run.sh
```
