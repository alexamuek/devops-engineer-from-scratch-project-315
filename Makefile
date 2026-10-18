deploy:
	ansible-playbook -i inventory.ini -u alexamuek -K --vault-password-file password --skip-tags reload_nginx,restart_app,restart_db playbook-roles.yml
restart-nginx:
	ansible-playbook -i inventory.ini -u alexamuek -K --vault-password-file password -t reload_nginx playbook-roles.yml
update-app:
	ansible-playbook -i inventory.ini -u alexamuek -K --vault-password-file password -t update_app playbook-roles.yml
restart-app:
	ansible-playbook -i inventory.ini -u alexamuek -K --vault-password-file password -t restart_app playbook-roles.yml
restart-db:
	ansible-playbook -i inventory.ini -u alexamuek -K --vault-password-file password -t restart_db playbook-roles.yml