module "kubefirst_demo_bot" {
  source = "../modules/user/github"

  acl_policies            = ["livestream"]
  email                   = "kubefirst-demo-bot@kubefirst.io"
  first_name              = "kubefirst"
  github_username         = "kubefirst-demo-bot"
  team_id                 = data.github_team.livestream.id
  last_name               = "demobot"
  username                = "kdemobot"
  user_disabled           = false
  userpass_accessor       = data.vault_auth_backend.userpass.accessor
}

