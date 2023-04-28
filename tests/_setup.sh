load '../test/test_helper/bats-support/load.bash'
load '../test/test_helper/bats-assert/load.bash'

export PATH="$(pwd)/tests:$PATH"
export SCRIPT="../terraform-target"
export CLEAN_PLAN_OUTPUT="./clean-plan.output"

cd ./tests

if [ ! -f .terraform.lock.hcl ]; then
    terraform init
    terraform plan >$CLEAN_PLAN_OUTPUT
fi
