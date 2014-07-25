/**********************************************************
 *							  
 *  The section below contains the database 
  *  data changes from ITIM 5.0 to ITIM 5.1
 *                                                        
 **********************************************************/
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_POLICIES-MANAGE_SOD_POLICIES',1,'N');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_POLICIES-MANAGE_SOD_POLICIES',2,'N');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_POLICIES-MANAGE_SOD_POLICIES',4,'N');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_POLICIES-MANAGE_SOD_POLICIES',5,'N');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_POLICIES-MANAGE_SOD_POLICIES',6,'N');

update tasks_viewable set viewable = 'Y' where task_id='SET_SYSTEM_SECURITY-MANAGE_GROUPS' and view_id=5;

insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_ORPHAN_ACCOUNTS',5,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_ORPHAN_ACCOUNTS-ASSIGN_ORPHAN_ACCOUNT',5,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_ORPHAN_ACCOUNTS-DELETE_ORPHAN_ACCOUNT',5,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_ORPHAN_ACCOUNTS-SUSPEND_ORPHAN_ACCOUNT',5,'Y');


/**********************************************************
 *							  
 *  The section below contains the database 
 *  data changes in ITIM 6.0
 *                                                        
 **********************************************************/
insert into aci_categories (id, name) values (1, 'Account');
insert into aci_categories (id, name) values (2, 'BusinessPartnerOrganization');
insert into aci_categories (id, name) values (3, 'BPPerson');
insert into aci_categories (id, name) values (4, 'SystemUser');
insert into aci_categories (id, name) values (5, 'DynamicRole');
insert into aci_categories (id, name) values (6, 'Location');
insert into aci_categories (id, name) values (7, 'OrganizationUnit');
insert into aci_categories (id, name) values (8, 'Role');
insert into aci_categories (id, name) values (9, 'Person');
insert into aci_categories (id, name) values (10, 'SystemRole');
insert into aci_categories (id, name) values (11, 'IdentityPolicy');
insert into aci_categories (id, name) values (12, 'PasswordPolicy');
insert into aci_categories (id, name) values (13, 'ProvisioningPolicy');
insert into aci_categories (id, name) values (14, 'SecurityDomain');
insert into aci_categories (id, name) values (15, 'Service');
insert into aci_categories (id, name) values (16, 'Group');
insert into aci_categories (id, name) values (17, 'HostSelectionPolicy');
insert into aci_categories (id, name) values (18, 'CustomProcess');
insert into aci_categories (id, name) values (19, 'RecertificationPolicy');
insert into aci_categories (id, name) values (20, 'AccountTemplate');
insert into aci_categories (id, name) values (21, 'SeparationOfDutyPolicy');


insert into task_tree (parent, task_id, sequence_no, admin_only) values ('DV_ADMIN_CONSOLE', 'CHANGE_OTHERS_PASSWORDS',10, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('DV_ADMIN_CONSOLE', 'MANAGE_ROLES',20, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('DV_ADMIN_CONSOLE', 'MANAGE_ORGANIZATION_STRUCTURE',30, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('DV_ADMIN_CONSOLE', 'MANAGE_USERS', 40, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('DV_ADMIN_CONSOLE', 'MANAGE_SERVICES',50, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('DV_ADMIN_CONSOLE', 'MANAGE_ORPHAN_ACCOUNTS',55, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('DV_ADMIN_CONSOLE', 'SET_SYSTEM_SECURITY-MANAGE_GROUPS',60, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('DV_ADMIN_CONSOLE', 'MANAGE_POLICIES',70, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('DV_ADMIN_CONSOLE', 'DESIGN_WORKFLOWS',90, 'N');  
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('DV_ADMIN_CONSOLE', 'SET_SYSTEM_SECURITY',100, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('DV_ADMIN_CONSOLE', 'REPORTS',110, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('DV_ADMIN_CONSOLE', 'VIEW_REQUESTS',120, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('DV_ADMIN_CONSOLE', 'MANAGE_TODO_LIST', 130, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('DV_ADMIN_CONSOLE', 'CONFIGURE_SYSTEM', 140, 'Y');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('DV_ADMIN_CONSOLE','CHANGE_PASSWORD_EXPIRED',150,'Y');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('DV_ADMIN_CONSOLE','DEFINE_FORGOTTEN_PASSWORD_QUESTIONS',160,'Y');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('DV_ADMIN_CONSOLE','FORGOTTEN_PASSWORD',170,'Y');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('DV_ADMIN_CONSOLE','ABOUT',180,'Y');

insert into tasks_viewable (task_id, view_id, viewable) values ('VIEW_REQUESTS-VIEW_MY_ALL_REQUEST',1,'N');
insert into tasks_viewable (task_id, view_id, viewable) values ('VIEW_REQUESTS-VIEW_MY_ALL_REQUEST',2,'N');
insert into tasks_viewable (task_id, view_id, viewable) values ('VIEW_REQUESTS-VIEW_MY_ALL_REQUEST',4,'N');
insert into tasks_viewable (task_id, view_id, viewable) values ('VIEW_REQUESTS-VIEW_MY_ALL_REQUEST',5,'N');
insert into tasks_viewable (task_id, view_id, viewable) values ('VIEW_REQUESTS-VIEW_MY_ALL_REQUEST',6,'N');

insert into task_tree (parent, task_id, sequence_no, admin_only) values ('MANAGE_USERS', 'MANAGE_PEOPLE-CREATE_PERSON',10, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('MANAGE_USERS', 'MANAGE_PEOPLE-CHANGE_PERSON',20, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('MANAGE_USERS', 'MANAGE_PEOPLE-DELETE_PERSON',30, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('MANAGE_USERS', 'MANAGE_PEOPLE-SUSPEND_PERSON',40, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('MANAGE_USERS', 'MANAGE_PEOPLE-RESTORE_PERSON',50, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('MANAGE_USERS', 'MANAGE_USERS-TRANSFER_USER',60, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('MANAGE_USERS', 'MANAGE_USERS-CHANGE_PASSWORDS',70, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('MANAGE_USERS', 'MANAGE_PEOPLE-DELEGATE_ACTIVITIES_SYSTEMUSER',80, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('MANAGE_USERS', 'MANAGE_PEOPLE-ACCOUNTS',90, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('MANAGE_USERS', 'MANAGE_USERS-MANAGE_ACCESS',100, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('MANAGE_USERS', 'RECERTIFY_USER',110, 'Y');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('MANAGE_PEOPLE-ACCOUNTS', 'MANAGE_PEOPLE-REQUEST_ACCOUNT',10, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('MANAGE_PEOPLE-ACCOUNTS', 'MANAGE_PEOPLE-CHANGE_ACCOUNT',20, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('MANAGE_PEOPLE-ACCOUNTS', 'MANAGE_PEOPLE-DELETE_ACCOUNT',30, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('MANAGE_PEOPLE-ACCOUNTS', 'MANAGE_USERS_ACCOUNTS-CHANGE_PASSWORD',40, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('MANAGE_PEOPLE-ACCOUNTS', 'MANAGE_PEOPLE-SUSPEND_ACCOUNT',50, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('MANAGE_PEOPLE-ACCOUNTS', 'MANAGE_PEOPLE-RESTORE_ACCOUNT',60, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('MANAGE_USERS-MANAGE_ACCESS', 'MANAGE_USERS-REQUEST_ACCESS',10, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('MANAGE_USERS-MANAGE_ACCESS', 'MANAGE_USERS-DELETE_ACCESS',20, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('MANAGE_SERVICES', 'MANAGE_SERVICES-CREATE_SERVICE', 10, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('MANAGE_SERVICES', 'MANAGE_SERVICES-CHANGE_SERVICE', 20, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('MANAGE_SERVICES', 'MANAGE_SERVICES-DELETE_SERVICE', 30, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('MANAGE_SERVICES', 'MANAGE_SERVICES-POLICY_ENFORCEMENT', 40, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('MANAGE_SERVICES', 'MANAGE_SERVICES-CUSTOMIZE_ACCOUNT_FORM', 50, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('MANAGE_SERVICES', 'MANAGE_SERVICES-DELETE_ACCOUNT_FORM', 60, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('MANAGE_SERVICES', 'MANAGE_SERVICES-MANAGE_GROUPS', 70, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('MANAGE_SERVICES', 'MANAGE_SERVICES-ACCOUNTS',80, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('MANAGE_SERVICES', 'MANAGE_SERVICES-ACCOUNT_RECERTIFICATION_STATUS', 90, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('MANAGE_SERVICES', 'MANAGE_SERVICES-MANAGE_ACCOUNT_DEFAULTS', 100, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('MANAGE_SERVICES', 'MANAGE_SERVICES-RECONCILE_NOW', 110, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('MANAGE_SERVICES', 'MANAGE_SERVICES-SETUP_RECON', 120, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('MANAGE_SERVICES', 'MANAGE_SERVICES-ENFORCE_POLICY', 130, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('MANAGE_SERVICES', 'MANAGE_SERVICES-RETRY_PENDING', 140, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('MANAGE_SERVICES-MANAGE_GROUPS', 'MANAGE_SERVICES-GROUP_MEMBERSHIP', 10, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('MANAGE_SERVICES-MANAGE_GROUPS', 'MANAGE_SERVICES-DEFINE_ACCESS', 20, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('MANAGE_SERVICES-MANAGE_GROUPS', 'MANAGE_SERVICES-ACCESS_RECERTIFICATION_STATUS', 30, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('MANAGE_SERVICES-ACCOUNTS', 'MANAGE_SERVICES-REQUEST_ACCOUNT', 10, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('MANAGE_SERVICES-ACCOUNTS', 'MANAGE_SERVICES-CHANGE_ACCOUNT', 20, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('MANAGE_SERVICES-ACCOUNTS', 'MANAGE_SERVICES-DELETE_ACCOUNT', 30, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('MANAGE_SERVICES-ACCOUNTS', 'MANAGE_SERVICES_ACCOUNTS-CHANGE_PASSWORD', 40, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('MANAGE_SERVICES-ACCOUNTS', 'MANAGE_SERVICES-SUSPEND_ACCOUNT', 50, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('MANAGE_SERVICES-ACCOUNTS', 'MANAGE_SERVICES-RESTORE_ACCOUNT', 60, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('MANAGE_SERVICES-ACCOUNTS', 'MANAGE_SERVICES-ASSIGN_ACCOUNT', 70, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('MANAGE_SERVICES-ACCOUNTS', 'MANAGE_SERVICES-ORPHAN_ACCOUNT', 80, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('MANAGE_ORPHAN_ACCOUNTS', 'MANAGE_ORPHAN_ACCOUNTS-ASSIGN_ORPHAN_ACCOUNT', 10, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('MANAGE_ORPHAN_ACCOUNTS', 'MANAGE_ORPHAN_ACCOUNTS-DELETE_ORPHAN_ACCOUNT', 20, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('MANAGE_ORPHAN_ACCOUNTS', 'MANAGE_ORPHAN_ACCOUNTS-SUSPEND_ORPHAN_ACCOUNT', 30, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('MANAGE_POLICIES', 'MANAGE_POLICIES-MANAGE_ADOPTION_RULES', 10, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('MANAGE_POLICIES', 'MANAGE_POLICIES-MANAGE_IDENTITY_POLICIES', 20, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('MANAGE_POLICIES', 'MANAGE_POLICIES-MANAGE_PASSWORD_POLICIES', 30, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('MANAGE_POLICIES', 'MANAGE_POLICIES-MANAGE_PROVISIONING_POLICIES', 40, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('MANAGE_POLICIES', 'MANAGE_POLICIES-MANAGE_SERVICE_SELECTION_POLICIES', 50, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('MANAGE_POLICIES', 'MANAGE_POLICIES-MANAGE_RECERTIFICATION_POLICIES', 60, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('MANAGE_POLICIES', 'MANAGE_POLICIES-MANAGE_SOD_POLICIES', 70, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('DESIGN_WORKFLOWS', 'DESIGN_WORKFLOWS-MANAGE_ACCOUNT_REQUEST_WORKFLOWS',10, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('DESIGN_WORKFLOWS', 'DESIGN_WORKFLOWS-MANAGE_ACCESS_REQUEST_WORKFLOWS',20, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('SET_SYSTEM_SECURITY', 'SET_SYSTEM_SECURITY-MANAGE_ACI', 10, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('SET_SYSTEM_SECURITY', 'SET_SYSTEM_SECURITY-DEFINE_VIEWS', 20, 'Y');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('SET_SYSTEM_SECURITY', 'CONFIGURE_SYSTEM-SET_SYSTEM_PROPERTIES', 30, 'Y');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('SET_SYSTEM_SECURITY', 'CONFIGURE_SYSTEM-SET_CHALLENGE_RESPONSE', 40, 'Y');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('REPORTS', 'REPORTS-REQUESTS', 10, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('REPORTS', 'REPORTS-USER-AND-ACCOUNTS', 20, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('REPORTS', 'REPORTS-AUDIT-AND-SECURITY', 30, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('REPORTS', 'REPORTS-SERVICES', 40, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('REPORTS', 'REPORTS-CUSTOM', 50, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('REPORTS', 'REPORTS-SCHEMA', 60, 'Y');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('REPORTS', 'REPORTS-DESIGN', 70, 'Y');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('REPORTS', 'REPORTS-PROPERTIES', 80, 'Y');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('VIEW_REQUESTS', 'VIEW_REQUESTS-VIEW_OTHERS_PENDING_REQUESTS', 10, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('VIEW_REQUESTS', 'VIEW_REQUESTS-VIEW_ALL_OTHERS_REQUEST', 20, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('VIEW_REQUESTS', 'VIEW_REQUESTS-VIEW_ALL_PENDING_REQUESTS_BY_SERVICE', 30, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('VIEW_REQUESTS', 'VIEW_REQUESTS-VIEW_REQUEST_BY_SERVICE', 40, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('VIEW_REQUESTS', 'ADMIN_CONSOLE_VIEW_REQUESTS-VIEW_ALL_REQUEST', 50, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('MANAGE_TODO_LIST', 'ADMIN_CONSOLE_VIEW_TODO_LIST', 10, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('MANAGE_TODO_LIST', 'VIEW_TODOS_BY_USER', 20, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('MANAGE_TODO_LIST', 'ADMIN_CONSOLE_DELEGATE_TODOS', 30, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('CONFIGURE_SYSTEM', 'CONFIGURE_SYSTEM-MANAGE_SERVICE_TYPES', 10, 'Y');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('CONFIGURE_SYSTEM', 'CONFIGURE_SYSTEM-MANAGE_ACCESS_TYPES', 20, 'Y');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('CONFIGURE_SYSTEM', 'CONFIGURE_SYSTEM-MANAGE_OWNERSHIP_TYPES', 30, 'Y');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('CONFIGURE_SYSTEM', 'CONFIGURE_SYSTEM-GLOBAL_ADOPTION_RULES', 40, 'Y');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('CONFIGURE_SYSTEM', 'CONFIGURE_SYSTEM-WORKFLOW_NOTIFICATION_PROPERTIES', 50, 'Y');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('CONFIGURE_SYSTEM', 'CONFIGURE_SYSTEM-POST_OFFICE_CONFIG', 60, 'Y');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('CONFIGURE_SYSTEM', 'CONFIGURE_SYSTEM-DESIGN_FORMS', 70, 'Y');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('CONFIGURE_SYSTEM', 'CONFIGURE_SYSTEM-MANAGE_ENTITIES', 80, 'Y');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('CONFIGURE_SYSTEM', 'CONFIGURE_SYSTEM-MANAGE_OPERATIONS', 90, 'Y');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('CONFIGURE_SYSTEM', 'CONFIGURE_SYSTEM-MANAGE_LIFECYCLE_RULES', 100, 'Y');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('CONFIGURE_SYSTEM', 'CONFIGURE_SYSTEM-CONFIGURE_MANUAL_NOTIFICATION_MESSAGES', 110, 'Y');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('CONFIGURE_SYSTEM', 'CONFIGURE_SYSTEM-CONFIGURE_POLICY_JOIN_BEHAVIOR', 120, 'Y');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('CONFIGURE_SYSTEM', 'CONFIGURE_SYSTEM-CONFIGURE_GLOBAL_POLICY_ENFORCEMENT', 130, 'Y');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('CONFIGURE_SYSTEM', 'CONFIGURE_SYSTEM-CONFIGURE_IMPORT_DATA', 140, 'Y');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('CONFIGURE_SYSTEM', 'CONFIGURE_SYSTEM-CONFIGURE_EXPORT_DATA', 150, 'Y');

insert into task_tree (parent, task_id, sequence_no, admin_only) values ('DV_SELF_SERVICE', 'CHANGE_PASSWORDS', 10, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('DV_SELF_SERVICE', 'CHANGE_PERSONAL_PROFILE', 20, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('DV_SELF_SERVICE', 'VIEW_PERSONAL_PROFILE', 30, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('DV_SELF_SERVICE', 'MANAGE_MY_ACCOUNTS-REQUEST_ACCOUNT', 40, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('DV_SELF_SERVICE', 'MANAGE_MY_ACCOUNTS-REQUEST_ACCOUNT_ADVANCED', 50, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('DV_SELF_SERVICE', 'MANAGE_MY_ACCOUNTS-CHANGE_ACCOUNT', 60, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('DV_SELF_SERVICE', 'MANAGE_MY_ACCOUNTS-DELETE_ACCOUNT', 70, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('DV_SELF_SERVICE', 'MANAGE_MY_ACCOUNTS-VIEW_ACCOUNT', 80, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('DV_SELF_SERVICE', 'SELF_SERVICE-REQUEST_ACCESS', 90, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('DV_SELF_SERVICE', 'SELF_SERVICE-DELETE_ACCESSES', 100, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('DV_SELF_SERVICE', 'SELF_SERVICE-VIEW_ACCESSES', 110, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('DV_SELF_SERVICE', 'VIEW_REQUESTS-VIEW_ALL_MY_REQUEST', 120, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('DV_SELF_SERVICE', 'VIEW_TODO_LIST', 130, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('DV_SELF_SERVICE', 'DELEGATE_TODOS', 140, 'N');

insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_SERVICES-ENFORCE_POLICY',5,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_SERVICES-RETRY_PENDING',5,'Y');

insert into entity_column (entity_name, column_name, attribute_name, multi_valued, implicitly_mapped, available_for_reporting, table_name) values ('DefaultCredential','DN','DN','N','N','external_view_dropped','V_CREDENTIAL');
insert into entity_column (entity_name, column_name, attribute_name, multi_valued, implicitly_mapped, available_for_reporting, table_name) values ('DefaultCredential','eraccount','eraccount','N','N','external_view_dropped','V_CREDENTIAL');
insert into entity_column (entity_name, column_name, attribute_name, multi_valued, implicitly_mapped, available_for_reporting, table_name) values ('DefaultCredential','eruseglobalsettings','eruseglobalsettings','N','N','external_view_dropped','V_CREDENTIAL');
insert into entity_column (entity_name, column_name, attribute_name, multi_valued, implicitly_mapped, available_for_reporting, table_name) values ('DefaultCredential','ersearchoption','ersearchoption','N','N','external_view_dropped','V_CREDENTIAL');
insert into entity_column (entity_name, column_name, attribute_name, multi_valued, implicitly_mapped, available_for_reporting, table_name) values ('DefaultCredential','erexclusive','erexclusive','N','N','external_view_dropped','V_CREDENTIAL');
insert into entity_column (entity_name, column_name, attribute_name, multi_valued, implicitly_mapped, available_for_reporting, table_name) values ('DefaultCredential','erpasswordviewable','erpasswordviewable','N','N','external_view_dropped','V_CREDENTIAL');
insert into entity_column (entity_name, column_name, attribute_name, multi_valued, implicitly_mapped, available_for_reporting, table_name) values ('DefaultCredential','erresetpassword','erresetpassword','N','N','external_view_dropped','V_CREDENTIAL');
insert into entity_column (entity_name, column_name, attribute_name, multi_valued, implicitly_mapped, available_for_reporting, table_name) values ('DefaultCredential','ermaxcheckouttime','ermaxcheckouttime','N','N','external_view_dropped','V_CREDENTIAL');
insert into entity_column (entity_name, column_name, attribute_name, multi_valued, implicitly_mapped, available_for_reporting, table_name) values ('DefaultCredential','erobjectprofilename','erobjectprofilename','N','N','external_view_dropped','V_CREDENTIAL');
insert into entity_column (entity_name, column_name, attribute_name, multi_valued, implicitly_mapped, available_for_reporting, table_name) values ('DefaultCredential','ercredentialname','ercredentialname','N','N','external_view_dropped','V_CREDENTIAL');
insert into entity_column (entity_name, column_name, attribute_name, multi_valued, implicitly_mapped, available_for_reporting, table_name) values ('DefaultCredential','erparent','erparent','N','N','external_view_dropped','V_CREDENTIAL');
insert into entity_column (entity_name, column_name, attribute_name, multi_valued, implicitly_mapped, available_for_reporting, table_name) values ('DefaultCredential','description','description','Y','N','external_view_dropped','V_CREDENTIAL_DESC');
insert into entity_column (entity_name, column_name, attribute_name, multi_valued, implicitly_mapped, available_for_reporting, table_name) values ('DefaultCredentialLease', 'DN', 'DN', 'N', 'N', 'external_view_dropped', 'V_CREDENTIALLEASE');
insert into entity_column (entity_name, column_name, attribute_name, multi_valued, implicitly_mapped, available_for_reporting, table_name) values ('DefaultCredentialLease', 'ercvcatalog', 'ercvcatalog', 'N', 'N', 'external_view_dropped', 'V_CREDENTIALLEASE');
insert into entity_column (entity_name, column_name, attribute_name, multi_valued, implicitly_mapped, available_for_reporting, table_name) values ('DefaultCredentialLease', 'ercredentialpooldn', 'ercredentialpooldn', 'N', 'N', 'external_view_dropped', 'V_CREDENTIALLEASE');
insert into entity_column (entity_name, column_name, attribute_name, multi_valued, implicitly_mapped, available_for_reporting, table_name) values ('DefaultCredentialLease', 'erlessee', 'erlessee', 'N', 'N', 'external_view_dropped', 'V_CREDENTIALLEASE');
insert into entity_column (entity_name, column_name, attribute_name, multi_valued, implicitly_mapped, available_for_reporting, table_name) values ('DefaultCredentialLease', 'erjustification', 'erjustification', 'N', 'N', 'external_view_dropped', 'V_CREDENTIALLEASE');
insert into entity_column (entity_name, column_name, attribute_name, multi_valued, implicitly_mapped, available_for_reporting, table_name) values ('DefaultCredentialLease', 'erparent', 'erparent', 'N', 'N', 'external_view_dropped', 'V_CREDENTIALLEASE');
insert into entity_column (entity_name, column_name, attribute_name, multi_valued, implicitly_mapped, available_for_reporting, table_name) values ('DefaultCredentialLease', 'erleaseexpirationtime', 'erleaseexpirationtime', 'N', 'N', 'external_view_dropped', 'V_CREDENTIALLEASE');
insert into entity_column (entity_name, column_name, attribute_name, multi_valued, implicitly_mapped, available_for_reporting, table_name) values ('DefaultCredentialLease', 'erleasestatus', 'erleasestatus', 'N', 'N', 'external_view_dropped', 'V_CREDENTIALLEASE');
insert into entity_column (entity_name, column_name, attribute_name, multi_valued, implicitly_mapped, available_for_reporting, table_name) values ('DefaultCredentialLease', 'ercustomattribute1', 'ercustomattribute1', 'N', 'N', 'external_view_dropped', 'V_CREDENTIALLEASE');
insert into entity_column (entity_name, column_name, attribute_name, multi_valued, implicitly_mapped, available_for_reporting, table_name) values ('DefaultCredentialLease', 'ercustomattribute2', 'ercustomattribute2', 'N', 'N', 'external_view_dropped', 'V_CREDENTIALLEASE');
insert into entity_column (entity_name, column_name, attribute_name, multi_valued, implicitly_mapped, available_for_reporting, table_name) values ('DefaultCredentialLease', 'ercustomattribute3', 'ercustomattribute3', 'N', 'N', 'external_view_dropped', 'V_CREDENTIALLEASE');
insert into entity_column (entity_name, column_name, attribute_name, multi_valued, implicitly_mapped, available_for_reporting, table_name) values ('DefaultCredentialLease', 'ercustomattribute4', 'ercustomattribute4', 'N', 'N', 'external_view_dropped', 'V_CREDENTIALLEASE');
insert into entity_column (entity_name, column_name, attribute_name, multi_valued, implicitly_mapped, available_for_reporting, table_name) values ('DefaultCredentialLease', 'ercustomattribute5', 'ercustomattribute5', 'N', 'N', 'external_view_dropped', 'V_CREDENTIALLEASE');
insert into entity_column (entity_name, column_name, attribute_name, multi_valued, implicitly_mapped, available_for_reporting, table_name) values ('DefaultCredentialLease', 'erlastnotification', 'erlastnotification', 'N', 'N', 'external_view_dropped', 'V_CREDENTIALLEASE');
insert into entity_column (entity_name, column_name, attribute_name, multi_valued, implicitly_mapped, available_for_reporting, table_name) values ('DefaultCredentialLease', 'erleasecreatetime', 'erleasecreatetime', 'N', 'N', 'external_view_dropped', 'V_CREDENTIALLEASE');
insert into entity_column (entity_name, column_name, attribute_name, multi_valued, implicitly_mapped, available_for_reporting, table_name) values ('DefaultSharedAccessPolicy', 'DN', 'DN', 'N', 'N', 'external_view_dropped', 'V_SAPOLICY');
insert into entity_column (entity_name, column_name, attribute_name, multi_valued, implicitly_mapped, available_for_reporting, table_name) values ('DefaultSharedAccessPolicy', 'erparent', 'erparent', 'N', 'N', 'external_view_dropped', 'V_SAPOLICY');
insert into entity_column (entity_name, column_name, attribute_name, multi_valued, implicitly_mapped, available_for_reporting, table_name) values ('DefaultSharedAccessPolicy', 'erpolicyenabled', 'erpolicyenabled', 'N', 'N', 'external_view_dropped', 'V_SAPOLICY');
insert into entity_column (entity_name, column_name, attribute_name, multi_valued, implicitly_mapped, available_for_reporting, table_name) values ('DefaultSharedAccessPolicy', 'erpolicyitemname', 'erpolicyitemname', 'N', 'N', 'external_view_dropped', 'V_SAPOLICY');
insert into entity_column (entity_name, column_name, attribute_name, multi_valued, implicitly_mapped, available_for_reporting, table_name) values ('DefaultSharedAccessPolicy', 'erscope', 'erscope', 'N', 'N', 'external_view_dropped', 'V_SAPOLICY');
insert into entity_column (entity_name, column_name, attribute_name, multi_valued, implicitly_mapped, available_for_reporting, table_name) values ('DefaultSharedAccessPolicy', 'description', 'description', 'Y', 'N', 'external_view_dropped', 'V_SAPOLICY_DESC');
insert into entity_column (entity_name, column_name, attribute_name, multi_valued, implicitly_mapped, available_for_reporting, table_name) values ('DefaultSharedAccessPolicy', 'ersharedaccessrole', 'ersharedaccessrole', 'Y', 'N', 'external_view_dropped', 'V_SAPOLICY_MEMBERSHIP');
insert into entity_column (entity_name, column_name, attribute_name, multi_valued, implicitly_mapped, available_for_reporting, table_name) values ('DefaultSharedAccessPolicy', 'ersharedaccesstarget', 'ersharedaccesstarget', 'Y', 'N', 'external_view_dropped', 'V_SAPOLICY_ENTITLEMENT');
insert into entity_column (entity_name, column_name, attribute_name, multi_valued, implicitly_mapped, available_for_reporting, table_name) values ('DefaultSharedAccessPolicy', 'eruri', 'eruri', 'Y', 'N', 'external_view_dropped', 'V_SAPOLICY_ERURI');
insert into entity_column (entity_name, column_name, attribute_name, multi_valued, implicitly_mapped, available_for_reporting, table_name) values ('DefaultCredentialPool', 'DN', 'DN', 'N', 'N', 'external_view_dropped', 'V_CREDENTIALPOOL');
insert into entity_column (entity_name, column_name, attribute_name, multi_valued, implicitly_mapped, available_for_reporting, table_name) values ('DefaultCredentialPool', 'ercredentialname', 'ercredentialname', 'N', 'N', 'external_view_dropped', 'V_CREDENTIALPOOL');
insert into entity_column (entity_name, column_name, attribute_name, multi_valued, implicitly_mapped, available_for_reporting, table_name) values ('DefaultCredentialPool', 'erobjectprofilename', 'erobjectprofilename', 'N', 'N', 'external_view_dropped', 'V_CREDENTIALPOOL');
insert into entity_column (entity_name, column_name, attribute_name, multi_valued, implicitly_mapped, available_for_reporting, table_name) values ('DefaultCredentialPool', 'erparent', 'erparent', 'N', 'N', 'external_view_dropped', 'V_CREDENTIALPOOL');
insert into entity_column (entity_name, column_name, attribute_name, multi_valued, implicitly_mapped, available_for_reporting, table_name) values ('DefaultCredentialPool', 'erservice', 'erservice', 'N', 'N', 'external_view_dropped', 'V_CREDENTIALPOOL');
insert into entity_column (entity_name, column_name, attribute_name, multi_valued, implicitly_mapped, available_for_reporting, table_name) values ('DefaultCredentialPool', 'eruseglobalsettings', 'eruseglobalsettings', 'N', 'N', 'external_view_dropped', 'V_CREDENTIALPOOL');
insert into entity_column (entity_name, column_name, attribute_name, multi_valued, implicitly_mapped, available_for_reporting, table_name) values ('DefaultCredentialPool', 'description', 'description', 'Y', 'N', 'external_view_dropped', 'V_CREDENTIALPOOL_DESC');
insert into entity_column (entity_name, column_name, attribute_name, multi_valued, implicitly_mapped, available_for_reporting, table_name) values ('DefaultCredentialPool', 'erservicegroup', 'erservicegroup', 'Y', 'N', 'external_view_dropped', 'V_CREDENTIALPOOL_GROUP');
insert into entity_column (entity_name, column_name, attribute_name, multi_valued, implicitly_mapped, available_for_reporting, table_name) values ('DefaultCredentialPool', 'owner', 'owner', 'Y', 'N', 'external_view_dropped', 'V_CREDENTIALPOOL_OWNER');
