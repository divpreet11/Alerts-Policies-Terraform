module "policies_Conditions" {
  source = "./policies_Conditions"

}
 
module "Workflow" {
  source = "./Workflow"
  policy_id = module.policies_Conditions.policy_id
}