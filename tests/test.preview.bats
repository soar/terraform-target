setup() {
  . ./tests/_setup.sh
}

@test "do not show resource that does not exist" {
    run $SCRIPT preview $CLEAN_PLAN_OUTPUT 'null_resource.sample_resource_with_count'
    assert_success
    assert_output ""
}

@test "properly handle a resource with count" {
    for i in 0 1; do
        run $SCRIPT preview $CLEAN_PLAN_OUTPUT "null_resource.sample_resource_with_count[$i]"
        assert_success
        assert_output --partial "\"counter\" = \"$i\""
        refute_output "\"counter\" = \"$((i-1))\""
        refute_output "\"counter\" = \"$((i+1))\""
    done
}

@test "properly handle a resource with for" {
    for n in one two three; do
        run $SCRIPT preview $CLEAN_PLAN_OUTPUT "null_resource.sample_resource_with_for[\"$n\"]"
        assert_success
        assert_output --partial "\"name\" = \"$n\""
    done
}
