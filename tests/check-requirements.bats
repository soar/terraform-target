setup() {
  SCRIPT="./terraform-target"

  . ./tests/_setup.sh
}

@test "check terraform version" {
    [ -z $TERRAFORM_VERSION ] && exit 1
    run terraform -version
    assert_output --partial "Terraform v${TERRAFORM_VERSION}"
}

@test "can check-requirements" {
    run $SCRIPT check-requirements
    assert_output "All requirements are met"
}
