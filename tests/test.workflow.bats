setup() {
  . ./tests/_setup.sh
}

@test "can apply changes" {
    run $SCRIPT apply
    assert_output --partial "1 to add, 0 to change, 0 to destroy."
    assert_output --partial "Applied changes may be incomplete"
    assert_output --partial "Apply complete! Resources: 1 added, 0 changed, 0 destroyed."
}

@test "can destroy resources" {
    run $SCRIPT destroy
    assert_output --partial "0 to add, 0 to change, 1 to destroy."
    assert_output --partial "Applied changes may be incomplete"
    assert_output --partial "Destroy complete! Resources: 1 destroyed."
}
