# Contents
`terraform`: Terraform templates and configuration to create all Cloud API resources

`version`: 0.12.9

## MacOS Specific Dependency Installations:
The following 3rd party tools will need to be installed for this to work:
```
$ brew install terraform  
```

## For other operating systems and architectures
Download the proper package [here](https://www.terraform.io/downloads.html).

It is distributed as a single binary. Unzip the downloaded file and move the binary to a directory included in your system's PATH .

## Verifying the installation
```
$ terraform
Usage: terraform [--version] [--help] <command> [args]

The available commands for execution are listed below.
...

Common commands:
    apply              Builds or changes infrastructure
    plan               Generate and show an execution plan
    providers          Prints a tree of the providers used in the configuration
    refresh            Update local state file against real resources
# ...
```
## Applying changes with terraform
First, ensure that the work is being done in the right environment. See environments directory.

To create an execution plan and review all changes before applying:
```
$ export ENV=(dev|prod)
$ terraform plan -var-file=environments/$ENV/config.tfvars
```

Apply the changes required to reach the desired state of the configuration:
```
$ terraform apply -var-file=environments/$ENV/config.tfvars
```

Learn more about [terraform](https://www.terraform.io/docs/index.html).
