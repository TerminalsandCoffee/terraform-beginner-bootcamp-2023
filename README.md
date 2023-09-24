# Terraform Beginner Bootcamp 2023

## Semantic Versioning :mage:

This project is going to utilize semactic versioning for its tagging. 
[semver.org](https://semver.org/)


The general format: 

 **MAJOR.MINOR.PATCH**, eg. `1.0.1`

- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes

## Install the Terraform CLI

The Terraform CLI installation instructions have changed due to gpg keyring changes. So we needed to refer to the latest install CLI instructions via Terraform Documentation and change the scripting for install. 

[Install Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

### Considerations for Linux Distributions 

This project is built against Ubuntu. 
Please consider checking your Linux Distribution and consider changing to your distribution needs. 
[How to Check the OS Version in Linux](https://www.cyberciti.biz/faq/how-to-check-os-version-in-linux-command-line/)

Example of checking OS Version:
```
$ cat /etc/os-release
PRETTY_NAME="Ubuntu 22.04.3 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.3 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy
```


### Refactoring into Bash Scripts

While fixing the Terraform CLI gpg depreciation issues we noticed that the bash scripts steps were a considerable amount more code. So we decided to create a bash script to install the Terraform CLI.

This bash script is located here: [./bin/install_terraform_cli](./bin/install_terraform_cli)


- This will keep the Gitpod Task File ([.gitpod.yml](.gitpod.yml)) tidy. 
- This allows us an easier to debug and execute manually Terraform CLI install
- This will allow better portability for other porjects that will need to install the Terraform CLI 


### Shebang Considerations

A Shebang tells the bash script what program the interpreter will interpret the script. eg. '#!/bin/bash'

ChatGPT recommended this format for bash: '#!/usr/bin/env bash'

- for portability for different OS distributions 
- will search the user's PATH for the bash executable

## Execution Considerations 

When executing the bash script we can use the './' shorthand notation to execute the bash script.

eg. './bin/install_terraform_cli'

If we are using a script in gitpod.yml we need to point the script to a program to interpret it. 

eg. 'source ./bin/install_terraform_cli'

https://en.wikipedia.org/wiki/Shebang_(Unix)

#### Linux Permission Considerations

In order to make our bash scripts executable we need to change linux permissions for the fix to be executable at the user mode. 

```sh
chmod u+x ./bin/install_terraform_cli 
```
alternatively:

```sh
chmod 744 ./bin/install_terraform_cli 
```

https://en.wikipedia.org/wiki/Chmod


### Github Lifecycle (Before, Init, Command)

We need to be careful when using the Init because it will not rerun if we restart an exisiting workspace. 

https://www.gitpod.io/docs/configure/workspaces/tasks



### Working with Env Vars

#### env command

We can list out all Environment Varibales (Env Vars) using the 'env' command

We can filter specific env vars using grep eg. 'env | grep AWS_'

#### Setting and Unsetting Env Vars

In the terminal we can set using 'export Hello='world'

In the terminal we unset using 'unset HELLO'

We can set an env var temporarily when just running a command 

```sh
HELLO='world' ./bin/print_message
```

Within a bash script we can set env without writing export eg. 

```sh
#!/usr/bin/env bash
HELLO='world'

echo $HELLO
```

## Printing Env Vars

We can print an Env Var using echo eg. 'echo $HELLO'

#### Scoping of Env Vars

When you open up new bash terminals in VSCode it will not be aware of env vars that you have set in another window

If you want Env Vars to persist across all future bash terminals that are open you need to set env vars in your bash profile. eg. '.bash_profile'

#### Persisting Env Vars in Gitpod

We can persist Env Vars into Gitpod by storing them in Gitpod Secrets Storage. 

```
gp env HELLO='world'
```

All future workspaces launched will set the env vars for all bash terminals opened in those workspaces. 

You can also set Env Vars in the '.gitpod.yml' but this can only contain non-sensitive env vars.

### AWS CLI Installation

AWS CLI is installed for the project via the bash script ['./bin/install_aws_cli'](./bin/install_aws_cli)


https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html

[Getting Started Install (AWS CLI)]
(https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)[AWS CLI Env Vars](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

We can check if our AWS credentials are configured correctly by running the following command:
```sh
aws sts get-caller-identity
```

If it is successful you should see a json payload return that looks like this: 

```json
{
    "UserId": "ATIAVZXBZ3AI2X2IALE3H",
    "Account": "123456789012",
    "Arn": "arn:aws:iam::123456789012:user/terraform-beginner-bootcamp"
}

```

We'll need to generate AWS CLI credits from IAM User in order to use the AWS CLI. 

## Terraform Basics

### Terraform Registry 

Terraform sources their providers and modules from the Terraform registrory which located at [registry.terraform.io](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string)

- **Providers** is an interface to APIs that will allow us to create resources in terraform.
- **Modules** are a way to make large amount of terraform code modular, portable, and sharebale. 

[Random Terraform Provider](https://registry.terraform.io/providers/hashicorp/random)

### Terraform Console

We can see alist of all Terraform commands by simply typing 'terraform'

#### Terraform Init

At the start of a new terraform project we will run 'terraform init' to download the binaries for the terraform providers that we'll use in this project. 

#### Terraform Plan

'terraform plan'

This will generate out a changeset, about the stat of our infrastructure and what will be changed. 

We can output this changeset ie "plan" to be passed to apply, but often you can just ignore output information. 

#### Terraform Apply 

'terraform apply'

This will run a plan and pass the changeset to be execute by terraform. Apply should prompt yes or no. 

If we want to automatically approve an apply we can provide the auto approve flag eg. 'terraform apply --auto-approve'

#### Terrform Destroy

'terraform destroy'
This will destroy resources.

You can also use the auto-approve flag to skip the approve prompt 

### Terraform Lock Files

'.terraform.lock.hcl' contains the locked versioning for the providers or modules that should be used with this project. 

The Terraform Lock File **should be committed** to your Version Control System (VSC) eg. GitHub

### Terraform State Files 

'.terraform.tfstate' contains information about the current state of your infransctructure. 

This file should **not be commited** to your Version Control System (VSC) 

This file can contain sensitive data. 

If you lose this file, you lose knowing the state of your infrastructure. 

.'terraform.tfstate.backup' is the previous state file state.

### Terraform Directory 

'.terraform' directory contains binaries and metadata of terraform providers. 


#### Issues with Terraform Cloud Login and Gitpod Workspaces

We have automated the process of the Terraform Cloud Login with Gitpod Workspace that some users may have (I did not have this issue). 

The bash script is found at [bin/generate_tfrc_credentials](bin/generate_tfrc_credentials)

The workaround is manually generate a token in Terraform Cloud

[](https://app.terraform.io/app/settings/tokens?source=terraform-login)

Then create open the file manually here:

```sh
touch /home/gitpod/.terraform.d/credentials.tfrc.json
open /home/gitpod/.terraform.d/credentials.tfrc.json
```

Provide the following code (replace your token in the file):
```json
{
  "credentials": {
    "app.terraform.io": {
      "token": "YOUR-TERRAFORM-CLOUD-TOKEN"
    }
  }
}
```




















