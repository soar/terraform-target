load '../test/test_helper/bats-support/load.bash'
load '../test/test_helper/bats-assert/load.bash'

export PATH="$(pwd)/tests:$PATH"
export SCRIPT="../terraform-target"
export CLEAN_PLAN_OUTPUT="./clean-plan.output"

export TF_INPUT=0
export TF_IN_AUTOMATION=1
export TF_CLI_ARGS_apply="-auto-approve"
export TF_CLI_ARGS_destroy="-auto-approve"

cd ./tests

if [ ! -f .terraform.lock.hcl ]; then
    terraform init
    terraform plan >$CLEAN_PLAN_OUTPUT
fi
