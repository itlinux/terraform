variable "gcp-terraform" {
    type = map(string)
    default = {
        sa_json = "/Users/work/Documents/TERRAFORM/.secrets/terraform_sa.json"
        project = "terraform-demo-2020-04-26"
    }
}