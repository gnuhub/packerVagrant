insert into aci_categories (id, name) values (22, 'Credential');
insert into aci_categories (id, name) values (23, 'CredentialPool');
insert into aci_categories (id, name) values (24, 'SharedAccessPolicy');
insert into aci_categories (id, name) values (25, 'CredentialLease');

insert into tasks_viewable (task_id, view_id, viewable) values ('SELF_SERVICE-ACCESS_SHARED_PRIVILEGE',1,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('SELF_SERVICE-ACCESS_SHARED_PRIVILEGE',2,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('SELF_SERVICE-ACCESS_SHARED_PRIVILEGE',4,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('SELF_SERVICE-ACCESS_SHARED_PRIVILEGE',5,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('SELF_SERVICE-ACCESS_SHARED_PRIVILEGE',6,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('SHARED_ACCESS_MODULE-MANAGE_CV',5,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_CV-ADD_TO_VAULT',5,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_CV-REGISTER_PASSWORD',5,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_CV-CHANGE_CREDENTIAL_PROPERTIES',5,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_CV-CHECKIN_FOR_OTHERS',5,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_CV-REMOVE',5,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('SHARED_ACCESS_MODULE-MANAGE_CP',5,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_CP-CREATE_CREDENTIAL_POOL',5,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_CP-CHANGE_CREDENTIAL_POOL',5,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_CP-DELETE_CREDENTIAL_POOL',5,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_CP-VIEW_POOL_CREDENTIALS',5,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('SHARED_ACCESS_MODULE-SHARED_ACCESS_BULK_LOAD',5,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('SHARED_ACCESS_MODULE-MANAGE_CV',2,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_CV-CHECKIN_FOR_OTHERS',2,'Y');

insert into task_tree (parent, task_id, sequence_no, admin_only) values ('DV_SELF_SERVICE', 'SELF_SERVICE-ACCESS_SHARED_PRIVILEGE', 150, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('DV_ADMIN_CONSOLE', 'SHARED_ACCESS_MODULE', 80, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('SHARED_ACCESS_MODULE', 'SHARED_ACCESS_MODULE-MANAGE_CV', 10, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('SHARED_ACCESS_MODULE', 'SHARED_ACCESS_MODULE-MANAGE_SAP', 20, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('SHARED_ACCESS_MODULE', 'SHARED_ACCESS_MODULE-MANAGE_CP', 30, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('SHARED_ACCESS_MODULE', 'SHARED_ACCESS_MODULE-CONFIGURE_GLOBAL_DEFAULT_SETTING', 40, 'Y');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('SHARED_ACCESS_MODULE', 'SHARED_ACCESS_MODULE-SHARED_ACCESS_BULK_LOAD', 50, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('SHARED_ACCESS_MODULE-MANAGE_CV', 'MANAGE_CV-ADD_TO_VAULT', 10, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('SHARED_ACCESS_MODULE-MANAGE_CV', 'MANAGE_CV-REGISTER_PASSWORD', 20, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('SHARED_ACCESS_MODULE-MANAGE_CV', 'MANAGE_CV-VIEW_PASSWORD_HISTORY', 30, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('SHARED_ACCESS_MODULE-MANAGE_CV', 'MANAGE_CV-CHANGE_CREDENTIAL_PROPERTIES', 40, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('SHARED_ACCESS_MODULE-MANAGE_CV', 'MANAGE_CV-CHECKIN_FOR_OTHERS', 50, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('SHARED_ACCESS_MODULE-MANAGE_CV', 'MANAGE_CV-REMOVE', 60, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('SHARED_ACCESS_MODULE-MANAGE_CP', 'MANAGE_CP-CREATE_CREDENTIAL_POOL', 10, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('SHARED_ACCESS_MODULE-MANAGE_CP', 'MANAGE_CP-CHANGE_CREDENTIAL_POOL', 20, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('SHARED_ACCESS_MODULE-MANAGE_CP', 'MANAGE_CP-DELETE_CREDENTIAL_POOL', 30, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('SHARED_ACCESS_MODULE-MANAGE_CP', 'MANAGE_CP-VIEW_POOL_CREDENTIALS', 40, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('SHARED_ACCESS_MODULE-MANAGE_SAP', 'MANAGE_SAP-CREATE_POLICY', 10, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('SHARED_ACCESS_MODULE-MANAGE_SAP', 'MANAGE_SAP-CHANGE_POLICY', 20, 'N');
insert into task_tree (parent, task_id, sequence_no, admin_only) values ('SHARED_ACCESS_MODULE-MANAGE_SAP', 'MANAGE_SAP-DELETE_POLICY', 30, 'N');

insert into DB_REPLICATION_CONFIG (ID, OBJECT_CLASS_NAME, ATTRIBUTE_NAME, DB_TABLE_NAME, KEY_COLUMN_NAME, REPLICATE_COLUMN_NAME, MULTI_VALUE, UPDATE_ONLY, CASE_SENSITIVE ) values (1, 'eraccountitem', 'eruid', 'sa_evaluation_credential', 'account_dn', 'account_uid', 'n', 'y', 'y');
insert into DB_REPLICATION_CONFIG (ID, OBJECT_CLASS_NAME, ATTRIBUTE_NAME, DB_TABLE_NAME, KEY_COLUMN_NAME, REPLICATE_COLUMN_NAME, MULTI_VALUE, UPDATE_ONLY, CASE_SENSITIVE ) values (2, 'eraccountitem', 'eraccountstatus', 'sa_evaluation_credential', 'account_dn', 'account_status', 'n', 'y', null);
insert into DB_REPLICATION_CONFIG (ID, OBJECT_CLASS_NAME, ATTRIBUTE_NAME, DB_TABLE_NAME, KEY_COLUMN_NAME, REPLICATE_COLUMN_NAME, MULTI_VALUE, UPDATE_ONLY, CASE_SENSITIVE ) values (3, 'eraccountitem', 'erservice', 'sa_evaluation_credential', 'account_dn', 'service_dn', 'n', 'y', 'y');
insert into DB_REPLICATION_CONFIG (ID, OBJECT_CLASS_NAME, ATTRIBUTE_NAME, DB_TABLE_NAME, KEY_COLUMN_NAME, REPLICATE_COLUMN_NAME, MULTI_VALUE, UPDATE_ONLY, CASE_SENSITIVE ) values (4, 'ercredential', 'eraccount', 'sa_evaluation_credential', 'dn', 'account_dn', 'n', 'n', 'y');
insert into DB_REPLICATION_CONFIG (ID, OBJECT_CLASS_NAME, ATTRIBUTE_NAME, DB_TABLE_NAME, KEY_COLUMN_NAME, REPLICATE_COLUMN_NAME, MULTI_VALUE, UPDATE_ONLY, CASE_SENSITIVE ) values (5, 'ercredential', 'ersearchoption', 'sa_evaluation_credential', 'dn', 'is_searchable', 'n', 'n', null);
insert into DB_REPLICATION_CONFIG (ID, OBJECT_CLASS_NAME, ATTRIBUTE_NAME, DB_TABLE_NAME, KEY_COLUMN_NAME, REPLICATE_COLUMN_NAME, MULTI_VALUE, UPDATE_ONLY, CASE_SENSITIVE ) values (6, 'ercredential', 'erexclusive', 'sa_evaluation_credential', 'dn', 'is_exclusive', 'n', 'n', null);
insert into DB_REPLICATION_CONFIG (ID, OBJECT_CLASS_NAME, ATTRIBUTE_NAME, DB_TABLE_NAME, KEY_COLUMN_NAME, REPLICATE_COLUMN_NAME, MULTI_VALUE, UPDATE_ONLY, CASE_SENSITIVE ) values (7, 'ercredential', 'erpasswordviewable', 'sa_evaluation_credential', 'dn', 'is_password_viewable', 'n', 'n', null);
insert into DB_REPLICATION_CONFIG (ID, OBJECT_CLASS_NAME, ATTRIBUTE_NAME, DB_TABLE_NAME, KEY_COLUMN_NAME, REPLICATE_COLUMN_NAME, MULTI_VALUE, UPDATE_ONLY, CASE_SENSITIVE ) values (8, 'ercredential', 'ercredentialname', 'sa_policy_entitlement', 'target_dn', 'name', 'n', 'y', 'y');
insert into DB_REPLICATION_CONFIG (ID, OBJECT_CLASS_NAME, ATTRIBUTE_NAME, DB_TABLE_NAME, KEY_COLUMN_NAME, REPLICATE_COLUMN_NAME, MULTI_VALUE, UPDATE_ONLY, CASE_SENSITIVE ) values (9, 'ercredentialpool', 'ercredentialname', 'sa_evaluation_credential_pool', 'dn', 'name', 'n', 'n', 'y');
insert into DB_REPLICATION_CONFIG (ID, OBJECT_CLASS_NAME, ATTRIBUTE_NAME, DB_TABLE_NAME, KEY_COLUMN_NAME, REPLICATE_COLUMN_NAME, MULTI_VALUE, UPDATE_ONLY, CASE_SENSITIVE ) values (10, 'ercredentialpool', 'erservice', 'sa_evaluation_credential_pool', 'dn', 'service_dn', 'n', 'n', 'y');
insert into DB_REPLICATION_CONFIG (ID, OBJECT_CLASS_NAME, ATTRIBUTE_NAME, DB_TABLE_NAME, KEY_COLUMN_NAME, REPLICATE_COLUMN_NAME, MULTI_VALUE, UPDATE_ONLY, CASE_SENSITIVE ) values (11, 'ercredentialpool', 'erparent', 'sa_evaluation_credential_pool', 'dn', 'bu_dn', 'n', 'n', 'y');
insert into DB_REPLICATION_CONFIG (ID, OBJECT_CLASS_NAME, ATTRIBUTE_NAME, DB_TABLE_NAME, KEY_COLUMN_NAME, REPLICATE_COLUMN_NAME, MULTI_VALUE, UPDATE_ONLY, CASE_SENSITIVE ) values (12, 'erserviceitem', 'erservicename', 'sa_evaluation_service', 'dn', 'name', 'n', 'n', 'y');	
insert into DB_REPLICATION_CONFIG (ID, OBJECT_CLASS_NAME, ATTRIBUTE_NAME, DB_TABLE_NAME, KEY_COLUMN_NAME, REPLICATE_COLUMN_NAME, MULTI_VALUE, UPDATE_ONLY, CASE_SENSITIVE ) values (13, 'erserviceitem', 'profilename', 'sa_evaluation_service', 'dn', 'type', 'n', 'n', 'y');	
insert into DB_REPLICATION_CONFIG (ID, OBJECT_CLASS_NAME, ATTRIBUTE_NAME, DB_TABLE_NAME, KEY_COLUMN_NAME, REPLICATE_COLUMN_NAME, MULTI_VALUE, UPDATE_ONLY, CASE_SENSITIVE ) values (14, 'erserviceitem', 'erparent', 'sa_evaluation_service', 'dn', 'bu_dn', 'n', 'n', 'y');	
insert into DB_REPLICATION_CONFIG (ID, OBJECT_CLASS_NAME, ATTRIBUTE_NAME, DB_TABLE_NAME, KEY_COLUMN_NAME, REPLICATE_COLUMN_NAME, MULTI_VALUE, UPDATE_ONLY, CASE_SENSITIVE ) values (15, 'erserviceitem', 'ertag', 'sa_evaluation_service_tag', 'service_dn', 'tag', 'y', 'y', 'y');	
insert into DB_REPLICATION_CONFIG (ID, OBJECT_CLASS_NAME, ATTRIBUTE_NAME, DB_TABLE_NAME, KEY_COLUMN_NAME, REPLICATE_COLUMN_NAME, MULTI_VALUE, UPDATE_ONLY, CASE_SENSITIVE ) values (16, 'erorganizationitem', 'o', 'sa_evaluation_bu', 'dn', 'name', 'n', 'n', 'y');	
insert into DB_REPLICATION_CONFIG (ID, OBJECT_CLASS_NAME, ATTRIBUTE_NAME, DB_TABLE_NAME, KEY_COLUMN_NAME, REPLICATE_COLUMN_NAME, MULTI_VALUE, UPDATE_ONLY, CASE_SENSITIVE ) values (17, 'erlocationitem', 'l', 'sa_evaluation_bu', 'dn', 'name', 'n', 'n', 'y');	
insert into DB_REPLICATION_CONFIG (ID, OBJECT_CLASS_NAME, ATTRIBUTE_NAME, DB_TABLE_NAME, KEY_COLUMN_NAME, REPLICATE_COLUMN_NAME, MULTI_VALUE, UPDATE_ONLY, CASE_SENSITIVE ) values (18, 'erbporgitem', 'ou', 'sa_evaluation_bu', 'dn', 'name', 'n', 'n', 'y');	
insert into DB_REPLICATION_CONFIG (ID, OBJECT_CLASS_NAME, ATTRIBUTE_NAME, DB_TABLE_NAME, KEY_COLUMN_NAME, REPLICATE_COLUMN_NAME, MULTI_VALUE, UPDATE_ONLY, CASE_SENSITIVE ) values (19, 'erorgunititem', 'ou', 'sa_evaluation_bu', 'dn', 'name', 'n', 'n', 'y');	
insert into DB_REPLICATION_CONFIG (ID, OBJECT_CLASS_NAME, ATTRIBUTE_NAME, DB_TABLE_NAME, KEY_COLUMN_NAME, REPLICATE_COLUMN_NAME, MULTI_VALUE, UPDATE_ONLY, CASE_SENSITIVE ) values (20, 'ersecuritydomainitem', 'ou', 'sa_evaluation_bu', 'dn', 'name', 'n', 'n', 'y');
insert into DB_REPLICATION_CONFIG (ID, OBJECT_CLASS_NAME, ATTRIBUTE_NAME, DB_TABLE_NAME, KEY_COLUMN_NAME, REPLICATE_COLUMN_NAME, MULTI_VALUE, UPDATE_ONLY, CASE_SENSITIVE ) values (21, 'ercredential', 'eruseglobalsettings', 'sa_evaluation_credential', 'dn', 'use_global_settings', 'n', 'n', null);	
insert into DB_REPLICATION_CONFIG (ID, OBJECT_CLASS_NAME, ATTRIBUTE_NAME, DB_TABLE_NAME, KEY_COLUMN_NAME, REPLICATE_COLUMN_NAME, MULTI_VALUE, UPDATE_ONLY, CASE_SENSITIVE ) values (22, 'ercredential', 'erresetpassword', 'sa_evaluation_credential', 'dn', 'reset_password', 'n', 'n', null);
insert into DB_REPLICATION_CONFIG (ID, OBJECT_CLASS_NAME, ATTRIBUTE_NAME, DB_TABLE_NAME, KEY_COLUMN_NAME, REPLICATE_COLUMN_NAME, MULTI_VALUE, UPDATE_ONLY, CASE_SENSITIVE ) values (23, 'ercredential', 'description', 'sa_eval_cred_description', 'dn', 'description', 'y', 'n', 'y');
insert into DB_REPLICATION_CONFIG (ID, OBJECT_CLASS_NAME, ATTRIBUTE_NAME, DB_TABLE_NAME, KEY_COLUMN_NAME, REPLICATE_COLUMN_NAME, MULTI_VALUE, UPDATE_ONLY, CASE_SENSITIVE ) values (24, 'ercredential', 'ermaxcheckouttime', 'sa_evaluation_credential', 'dn', 'max_checkout_time', 'n', 'n', null);
insert into DB_REPLICATION_CONFIG (ID, OBJECT_CLASS_NAME, ATTRIBUTE_NAME, DB_TABLE_NAME, KEY_COLUMN_NAME, REPLICATE_COLUMN_NAME, MULTI_VALUE, UPDATE_ONLY, CASE_SENSITIVE ) values (25, 'ercredential', 'erobjectprofilename', 'sa_evaluation_credential', 'dn', 'objectprofile_name', 'n', 'n', 'y');
insert into DB_REPLICATION_CONFIG (ID, OBJECT_CLASS_NAME, ATTRIBUTE_NAME, DB_TABLE_NAME, KEY_COLUMN_NAME, REPLICATE_COLUMN_NAME, MULTI_VALUE, UPDATE_ONLY, CASE_SENSITIVE ) values (26, 'ercredential', 'ercredentialname', 'sa_evaluation_credential', 'dn', 'name', 'n', 'n', 'y');
insert into DB_REPLICATION_CONFIG (ID, OBJECT_CLASS_NAME, ATTRIBUTE_NAME, DB_TABLE_NAME, KEY_COLUMN_NAME, REPLICATE_COLUMN_NAME, MULTI_VALUE, UPDATE_ONLY, CASE_SENSITIVE ) values (27, 'ercredentialpool', 'description', 'sa_credpool_description', 'dn', 'description', 'y', 'n', 'y');
insert into DB_REPLICATION_CONFIG (ID, OBJECT_CLASS_NAME, ATTRIBUTE_NAME, DB_TABLE_NAME, KEY_COLUMN_NAME, REPLICATE_COLUMN_NAME, MULTI_VALUE, UPDATE_ONLY, CASE_SENSITIVE ) values (28, 'ercredentialpool', 'owner', 'sa_credpool_owner', 'dn', 'owner', 'y', 'n', 'y');
insert into DB_REPLICATION_CONFIG (ID, OBJECT_CLASS_NAME, ATTRIBUTE_NAME, DB_TABLE_NAME, KEY_COLUMN_NAME, REPLICATE_COLUMN_NAME, MULTI_VALUE, UPDATE_ONLY, CASE_SENSITIVE ) values (29, 'ercredentialpool', 'erservicegroup', 'sa_credpool_group', 'dn', 'erservicegroup', 'y', 'n', 'y');
insert into DB_REPLICATION_CONFIG (ID, OBJECT_CLASS_NAME, ATTRIBUTE_NAME, DB_TABLE_NAME, KEY_COLUMN_NAME, REPLICATE_COLUMN_NAME, MULTI_VALUE, UPDATE_ONLY, CASE_SENSITIVE ) values (30, 'ercredentialpool', 'erobjectprofilename', 'sa_evaluation_credential_pool', 'dn', 'objectprofile_name', 'n', 'n', 'n');
insert into DB_REPLICATION_CONFIG (ID, OBJECT_CLASS_NAME, ATTRIBUTE_NAME, DB_TABLE_NAME, KEY_COLUMN_NAME, REPLICATE_COLUMN_NAME, MULTI_VALUE, UPDATE_ONLY, CASE_SENSITIVE ) values (31, 'ercredentialpool', 'eruseglobalsettings', 'sa_evaluation_credential_pool', 'dn', 'use_global_settings', 'n', 'n', null);
insert into DB_REPLICATION_CONFIG (ID, OBJECT_CLASS_NAME, ATTRIBUTE_NAME, DB_TABLE_NAME, KEY_COLUMN_NAME, REPLICATE_COLUMN_NAME, MULTI_VALUE, UPDATE_ONLY, CASE_SENSITIVE ) values (32, 'eraccountitem', 'owner', 'sa_evaluation_credential', 'account_dn', 'owner_dn', 'n', 'y', 'y');
insert into DB_REPLICATION_CONFIG (ID, OBJECT_CLASS_NAME, ATTRIBUTE_NAME, DB_TABLE_NAME, KEY_COLUMN_NAME, REPLICATE_COLUMN_NAME, MULTI_VALUE, UPDATE_ONLY, CASE_SENSITIVE ) values (33, 'eraccountitem', 'eraccountownershiptype', 'sa_evaluation_credential', 'account_dn', 'ownership_type', 'n', 'y', 'y');

insert into SA_GLOBAL_CONFIGURATION(ID,ACCESS_MODE,MAX_CHECKOUT_DURATION,PASSWORD_VIEWABLE,SHAREDACCOUNTS_SEARCH,PASSWORD_RESET,OPERATION_NAME, LEASE_EXP_HANDLING, LEASE_EXP_HANDLING_OPTION, VIOLATION_NOTIFY_PARTICIPANT, NOTIFICATION_PARTICIPANT_DN, SCHEDULE_FREQUENCY_MINUTES, NOTIFY_FREQUENCY_MINUTES) values(1,0,8,0,0,0,'','T',0,'SA',null,60,1440);

insert into view_definition (id, name, description) values (7, 'Privileged Administrator View', 'Default view for administrative users managing privileged IDs');
insert into view_definition (id, name, description) values (8, 'Privileged User View', 'Default view for users needing self-care capabilities for privileged IDs');
insert into tasks_viewable (task_id, view_id, viewable) values ('DESIGN_WORKFLOWS-MANAGE_ACCOUNT_REQUEST_WORKFLOWS',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('DESIGN_WORKFLOWS-MANAGE_ACCESS_REQUEST_WORKFLOWS',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_SERVICES',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_SERVICES-ACCOUNTS',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_SERVICES-CREATE_SERVICE',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_SERVICES-CHANGE_SERVICE',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_SERVICES-DELETE_SERVICE',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_SERVICES-SETUP_RECON',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_SERVICES-POLICY_ENFORCEMENT',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_SERVICES-DEFINE_ACCESS',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_SERVICES-MANAGE_GROUPS',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_SERVICES-GROUP_MEMBERSHIP',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_SERVICES-ACCESS_RECERTIFICATION_STATUS',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_SERVICES-REQUEST_ACCOUNT',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_SERVICES-CHANGE_ACCOUNT',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_SERVICES-DELETE_ACCOUNT',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_SERVICES_ACCOUNTS-CHANGE_PASSWORD',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_SERVICES-SUSPEND_ACCOUNT',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_SERVICES-RESTORE_ACCOUNT',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_SERVICES-ASSIGN_ACCOUNT',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_SERVICES-ORPHAN_ACCOUNT',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_SERVICES-ACCOUNT_RECERTIFICATION_STATUS',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_SERVICES-MANAGE_ACCOUNT_DEFAULTS',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_SERVICES-RECONCILE_NOW',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_SERVICES-CUSTOMIZE_ACCOUNT_FORM',7,'y');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_SERVICES-DELETE_ACCOUNT_FORM',7,'y');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_SERVICES-ENFORCE_POLICY',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_SERVICES-RETRY_PENDING',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_ORPHAN_ACCOUNTS',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_ORPHAN_ACCOUNTS-ASSIGN_ORPHAN_ACCOUNT',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_ORPHAN_ACCOUNTS-DELETE_ORPHAN_ACCOUNT',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_ORPHAN_ACCOUNTS-SUSPEND_ORPHAN_ACCOUNT',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_POLICIES',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_POLICIES-MANAGE_ADOPTION_RULES',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_POLICIES-MANAGE_IDENTITY_POLICIES',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_POLICIES-MANAGE_PASSWORD_POLICIES',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_POLICIES-MANAGE_PROVISIONING_POLICIES',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_POLICIES-MANAGE_SERVICE_SELECTION_POLICIES',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_POLICIES-MANAGE_RECERTIFICATION_POLICIES',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_POLICIES-MANAGE_SOD_POLICIES',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('SET_SYSTEM_SECURITY-MANAGE_GROUPS',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('REPORTS',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('REPORTS-USER-AND-ACCOUNTS',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('REPORTS-SERVICES',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('REPORTS-AUDIT-AND-SECURITY',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('REPORTS-REQUESTS',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('REPORTS-CUSTOM',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('VIEW_REQUESTS',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('VIEW_REQUESTS-VIEW_ALL_PENDING_REQUESTS_BY_SERVICE',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('VIEW_REQUESTS-VIEW_REQUEST_BY_SERVICE',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('VIEW_REQUESTS-VIEW_ALL_OTHERS_REQUEST',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('VIEW_REQUESTS-VIEW_OTHERS_PENDING_REQUESTS',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('ADMIN_CONSOLE_VIEW_REQUESTS-VIEW_ALL_REQUEST',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_TODO_LIST',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('ADMIN_CONSOLE_VIEW_TODO_LIST',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('ADMIN_CONSOLE_DELEGATE_TODOS',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('SHARED_ACCESS_MODULE',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('SHARED_ACCESS_MODULE-MANAGE_CV',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_CV-ADD_TO_VAULT',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_CV-REGISTER_PASSWORD',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_CV-CHANGE_CREDENTIAL_PROPERTIES',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_CV-CHECKIN_FOR_OTHERS',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_CV-REMOVE',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_CV-VIEW_PASSWORD_HISTORY',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('SHARED_ACCESS_MODULE-MANAGE_CP',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_CP-CREATE_CREDENTIAL_POOL',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_CP-CHANGE_CREDENTIAL_POOL',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_CP-DELETE_CREDENTIAL_POOL',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_CP-VIEW_POOL_CREDENTIALS',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('SHARED_ACCESS_MODULE-MANAGE_SAP',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_SAP-CHANGE_POLICY',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_SAP-CREATE_POLICY',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_SAP-DELETE_POLICY',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('SHARED_ACCESS_MODULE-SHARED_ACCESS_BULK_LOAD',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_ROLES',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_ORGANIZATION_STRUCTURE',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_PEOPLE-ACCOUNTS',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_PEOPLE-CHANGE_ACCOUNT',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_PEOPLE-CHANGE_PERSON',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_PEOPLE-CREATE_PERSON',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_PEOPLE-DELEGATE_ACTIVITIES_SYSTEMUSER',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_PEOPLE-DELETE_ACCOUNT',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_PEOPLE-DELETE_PERSON',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_PEOPLE-REQUEST_ACCOUNT',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_PEOPLE-RESTORE_ACCOUNT',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_PEOPLE-RESTORE_PERSON',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_PEOPLE-SUSPEND_ACCOUNT',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_PEOPLE-SUSPEND_PERSON',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_USERS',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_USERS-CHANGE_PASSWORDS',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_USERS-DELETE_ACCESS',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_USERS-MANAGE_ACCESS',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_USERS-REQUEST_ACCESS',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_USERS-TRANSFER_USER',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_USERS_ACCOUNTS-CHANGE_PASSWORD',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('CHANGE_OTHERS_PASSWORDS',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('DESIGN_WORKFLOWS',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('SET_SYSTEM_SECURITY',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('SET_SYSTEM_SECURITY-MANAGE_ACI',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('VIEW_TODOS_BY_USER',7,'Y');

insert into tasks_viewable (task_id, view_id, viewable) values ('CHANGE_PASSWORDS',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('VIEW_PERSONAL_PROFILE',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('VIEW_REQUESTS-VIEW_ALL_MY_REQUEST',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('SELF_SERVICE-ACCESS_SHARED_PRIVILEGE',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_MY_ACCOUNTS-REQUEST_ACCOUNT',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_MY_ACCOUNTS-DELETE_ACCOUNT',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('MANAGE_MY_ACCOUNTS-VIEW_ACCOUNT',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('SELF_SERVICE-REQUEST_ACCESS',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('SELF_SERVICE-DELETE_ACCESSES',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('SELF_SERVICE-VIEW_ACCESSES',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('VIEW_TODO_LIST',7,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('DELEGATE_TODOS',7,'Y');

insert into tasks_viewable (task_id, view_id, viewable) values ('CHANGE_PASSWORDS',8,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('SELF_SERVICE-ACCESS_SHARED_PRIVILEGE',8,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('VIEW_PERSONAL_PROFILE',8,'Y');
insert into tasks_viewable (task_id, view_id, viewable) values ('VIEW_REQUESTS-VIEW_ALL_MY_REQUEST',8,'Y');


