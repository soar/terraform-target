locals {
  sample_count = 3
  sample_list = ["one", "two", "three"]
}

resource "null_resource" "sample_resource" {
  triggers = {
    name = "sample"
  }
}

resource "null_resource" "sample_resource_with_count" {
  count = local.sample_count

  triggers = {
    counter = count.index
  }
}

resource "null_resource" "sample_resource_with_for" {
  for_each = toset(local.sample_list)

  triggers = {
    name = each.key
  }
}
