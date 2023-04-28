setup() {
  SCRIPT="./terraform-target"

  . ./tests/_setup.sh
}

@test "can check-requirements" {
    run $SCRIPT check-requirements
    assert_output "All requirements are met"
}
