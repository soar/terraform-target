setup() {
  . ./tests/_setup.sh
}

@test "do not allow repeats before an apply" {
    run $SCRIPT apply-repeat
    assert_output --partial "Terraform targets are not set"
    assert_failure 1
}

@test "fail state-related commands if no state available" {
    run $SCRIPT replace
    assert_output --regexp ".*No state file was found!.*"
    assert_failure 1
}

@test "can apply changes" {
    run $SCRIPT apply
    assert_success
    assert_output --partial "1 to add, 0 to change, 0 to destroy."
    assert_output --partial "Applied changes may be incomplete"
    assert_output --partial "Apply complete! Resources: 1 added, 0 changed, 0 destroyed."

    run bash -c 'terraform state list | wc -l | tr -d " "'
    assert_success
    assert_output "1"
}

@test "can repeat applying changes" {
    export TERRAFORM_PARTIAL_APPLY_TARGET_FILE=$(mktemp -t test-targets.XXXXXX)

    run $SCRIPT apply
    assert_success
    assert_output --partial "1 to add, 0 to change, 0 to destroy."
    assert_output --partial "Applied changes may be incomplete"
    assert_output --partial "Apply complete! Resources: 1 added, 0 changed, 0 destroyed."

    run $SCRIPT apply-repeat
    assert_success
    assert_output --partial "Your infrastructure matches the configuration."
    assert_output --partial "Applied changes may be incomplete"
    assert_output --partial "Apply complete! Resources: 0 added, 0 changed, 0 destroyed."

    run bash -c 'terraform state list | wc -l | tr -d " "'
    assert_success
    assert_output "2"
}

@test "can replace resources" {
    run $SCRIPT replace
    assert_success
    assert_output --regexp "will be .*replaced.*, as requested"
    assert_output --partial "1 to add, 0 to change, 1 to destroy."
    assert_output --partial "Applied changes may be incomplete"
    assert_output --partial "Apply complete! Resources: 1 added, 0 changed, 1 destroyed."
}

@test "can pass variables" {
    run $SCRIPT apply -var "sample_resource_name=can-pass-variable-test"
    assert_success
    assert_output --regexp '"name" = "sample".+->.+"can-pass-variable-test"'
    assert_output --partial "1 to add, 0 to change, 1 to destroy."
    assert_output --partial "Applied changes may be incomplete"
    assert_output --partial "Apply complete! Resources: 1 added, 0 changed, 1 destroyed."
}

@test "can destroy resources" {
    run $SCRIPT destroy
    assert_success
    assert_output --partial "0 to add, 0 to change, 1 to destroy."
    assert_output --partial "Applied changes may be incomplete"
    assert_output --partial "Destroy complete! Resources: 1 destroyed."
}
