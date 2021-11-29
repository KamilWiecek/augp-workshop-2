# SECTION 1 - RG

# resource "azurerm_resource_group" "sandbox" {
#   count    = length(var.teams)
#   name     = "rg-${var.teams[count.index].abbreviation}-dev"
#   location = "West Europe"
# }

# SECTION 2 - AZURE AD GROUPS

# resource "azuread_group" "teams" {
#   count            = length(var.teams)
#   display_name     = "tg-${var.teams[count.index].abbreviation}"
#   mail_enabled     = "false"
#   security_enabled = "true"
# }

# SECTION 3 - AZURE AD ROLE ASSIGNMENT

# resource "azurerm_role_assignment" "sandbox_contributor" {
#   count                = length(var.teams)
#   scope                = azurerm_resource_group.sandbox[count.index].id
#   principal_id         = azuread_group.teams[count.index].object_id
#   role_definition_name = "Contributor"
# }

# SECTION 4 - AZURE DEVOPS PROJECT

# resource "azuredevops_project" "project" {
#   count       = length(var.teams)
#   name        = var.teams[count.index].abbreviation
#   description = "${var.teams[count.index].full_name} team project. Project members are indirectly managed by HR system"
# }


# SECTION 5 - AZURE DEVOPS PERMISSIONS

# data "azuredevops_group" "contributor" {
#   count      = length(var.teams)
#   project_id = azuredevops_project.project[count.index].id
#   name       = "Contributors"
# }

# resource "azuredevops_group" "contributor" {
#   count      = length(var.teams)
#   origin_id    = azuread_group.teams[count.index].id
# }

# resource "azuredevops_group_membership" "contr" {
#   count      = length(var.teams)
#   group = data.azuredevops_group.contributor[count.index].descriptor
#   members = [
#     azuredevops_group.contributor[count.index].descriptor
#   ]
# }


# SECTION 6 - AZURE AD APP REGISTRATION

# data "azuread_application_template" "example" {
#   display_name = "Marketo"
# }

# resource "azuread_application" "appreg" {
#   count        = length(var.teams)
#   display_name = "app-${var.teams[count.index].abbreviation}"
#   owners       = []
#   template_id = data.azuread_application_template.example.template_id
# }

# resource "azuread_application_password" "example" {
#   count        = length(var.teams)
#   application_object_id = azuread_application.appreg[count.index].object_id
# }
