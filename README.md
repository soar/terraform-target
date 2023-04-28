# Terraform-Target

Shell-based wrapper to simplify resource [targeting](https://developer.hashicorp.com/terraform/tutorials/state/resource-targeting)

[![asciicast](https://user-images.githubusercontent.com/30570/235063700-061a0c38-f75d-478f-99b3-c29d1e3a1c6c.gif)](https://asciinema.org/a/581159)

- Works with wrappers like `tfenv`
- Works and tested with Terraform 1.0 and higher
- Allows passing any parameters to the `terraform` binary
- Allows reviewing the changes once more

## Installation

- Install [fzf](https://github.com/junegunn/fzf)
- Download the script `terraform-target`
- Place it into your `PATH`
- Check, that all required tools are installed: `terraform-target check-requirements`

## Usage

All commands can be supplied with additional Terraform parameters, they all are passed as is

### terraform-target apply

Executes `terraform plan` and shows possible targets list to choose from.
After that, executes `terraform apply -target=...` on the targets selected.

### terraform-target apply-repeat

Executes `terraform apply -target=...` on targets, that were previously selected in this shell.
Useful, when you need to re-apply the same changes, if the previous apply failed.

### terraform-target replace

Shows known resources in the state to choose from.
After that, executes `terraform apply -replace=...` on the targets selected.

### terraform-target destroy

Shows known resources in the state to choose from.
After that, executes `terraform destroy -target=...` on the targets selected.

---

Written with ❤️ and without ChatGPT help ☺️
