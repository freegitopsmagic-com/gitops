module "argo" {
  source = "./modules/oidc-client"

  depends_on = [
    vault_identity_oidc_provider.kubefirst
  ]

  app_name               = "argo"
  identity_group_ids     = [vault_identity_group.admins.id, vault_identity_group.developers.id, vault_identity_group.livestream.id]
  oidc_provider_key_name = vault_identity_oidc_key.key.name
  redirect_uris = [
    "https://argo.freegitopsmagic.com/oauth2/callback",
  ]
  secret_mount_path = vault_mount.secret.path
}

module "argocd" {
  source = "./modules/oidc-client"

  depends_on = [
    vault_identity_oidc_provider.kubefirst
  ]

  app_name               = "argocd"
  identity_group_ids     = [vault_identity_group.admins.id, vault_identity_group.developers.id, vault_identity_group.livestream.id]
  oidc_provider_key_name = vault_identity_oidc_key.key.name
  redirect_uris = [
    "https://argocd.freegitopsmagic.com/auth/callback",
  ]
  secret_mount_path = vault_mount.secret.path
}

module "console" {
  source = "./modules/oidc-client"

  depends_on = [
    vault_identity_oidc_provider.kubefirst
  ]

  app_name               = "console"
  identity_group_ids     = [vault_identity_group.admins.id, vault_identity_group.developers.id, vault_identity_group.livestream.id]
  oidc_provider_key_name = vault_identity_oidc_key.key.name
  redirect_uris = [
    "https://kubefirst.freegitopsmagic.com/api/auth/callback/vault",
  ]
  secret_mount_path = vault_mount.secret.path
}

# todo kubectl-oidc
