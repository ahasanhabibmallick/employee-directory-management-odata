@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Employee Root View Entity'
define root view entity ZI_EMPLOYEE_HUB
  as select from zemployee_hub
{
  key employee_id as EmployeeID,
  first_name as FirstName,
  last_name as LastName,
  email as Email,
  phone as Phone,
  department as Department,
  designation as Designation,
  joining_date as JoiningDate,
  location as Location,
  status as Status,

  /* RAP Administrative Fields (Required for Managed RAP) */
  @Semantics.user.createdBy: true
  created_by as CreatedBy,
  
  @Semantics.systemDateTime.createdAt: true
  created_at as CreatedAt,
  
  @Semantics.user.lastChangedBy: true
  last_changed_by as LastChangedBy,
  
  @Semantics.systemDateTime.lastChangedAt: true
  last_changed_at as LastChangedAt,
  
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  local_last_changed_at as LocalLastChangedAt
}
