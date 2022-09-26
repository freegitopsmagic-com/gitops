module "argo" {
  source = "./modules/oidc-client"

  app_name               = "argo"
  oidc_provider_key_name = vault_identity_oidc_key.key.name
  redirect_uris = [
    "https://argo.<AWS_HOSTED_ZONE_NAME>/oauth2/callback",
  ]
  secret_mount_path = vault_mount.secret.path
}

module "argocd" {
  source = "./modules/oidc-client"

  app_name               = "argocd"
  oidc_provider_key_name = vault_identity_oidc_key.key.name
  redirect_uris = [
    "https://argocd.<AWS_HOSTED_ZONE_NAME>/auth/callback",
  ]
  secret_mount_path = vault_mount.secret.path
}

module "gitlab" {
  source = "./modules/oidc-client"

  app_name               = "gitlab"
  oidc_provider_key_name = vault_identity_oidc_key.key.name
  redirect_uris = [
    "https://gitlab.<AWS_HOSTED_ZONE_NAME>/users/auth/openid_connect/callback",
  ]
  secret_mount_path = vault_mount.secret.path
}

# todo kubectl-oidc
