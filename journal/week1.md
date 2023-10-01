# Terraform Beginner Bootcamp 2023 - Week 1

## Root Module Structure

Our root module structure is as follows: 

```
- PROJECT_ROOT
  |- main.tf             - everything else
  |- variables.tf        - stores the structure of input variables 
  |- terraform.tfvars    - the data of variables we want to load into our terraform project
  |- providers.tf        - defined required providers and their configuration
  |- outputs.tf          - stores our outputs
  |- README.md           - required for root modules
```


[Standard Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)

# Terraform and Input Variables

## Terraform Cloud Variables

In Terraform, we can set two kinds of variables:

**Environment Variables**: These are set in your bash terminal, e.g., AWS credentials.

**Terraform Variables**: These are typically set in your `.tfvars` file.

We can set Terraform Cloud variables to be sensitive so they are not visibly shown in the UI.

## Loading Terraform Input Variables

[Terraform Input Variables](https://developer.hashicorp.com/terraform/language/values/variables)

### Terraform Input Variables

### var flag
You can use the `-var` flag to set an input variable or override a variable in the `.tfvars` file. For example:

```bash
terraform -var user_id="my-user_id"
```

## `var-file` Flag

This is the default file to load in terraform variables in blunk

## `terraform.tfvars`

This is the default file used to load Terraform variables in blank.

## `auto.tfvars`

This file used by Terraform to automatically load variable values without requiring explicit command-line arguments or user interaction.

## Order of Terraform Variables

The order of precedence for Terraform variables is: 

1. Command-line arguments
2. Environment variables
3. Variable files (*.tfvars)
4. auto.tfvars
5. Default values in the configuration
