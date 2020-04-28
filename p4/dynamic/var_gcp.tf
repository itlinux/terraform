variable "gcp-terraform" {
    type = map(string)
    default = {
        sa_json = "CHANGE_IT_service_account.json"
        project = "terraform-demo"
    }
}
