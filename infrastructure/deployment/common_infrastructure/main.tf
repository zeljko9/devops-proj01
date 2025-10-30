module "infrastructure" {
  source = "../../modules/support/common_infrastructure"

  environment = var.environment
  tags        = var.tags

  settings = var.settings
}