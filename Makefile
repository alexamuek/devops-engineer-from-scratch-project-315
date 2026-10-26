deploy:
	ansible-playbook -i inventory.ini -u root -K --vault-password-file password --skip-tags reload_nginx,restart_app,restart_db playbook.yml
restart-nginx:
	ansible-playbook -i inventory.ini -u root -K --vault-password-file password -t reload_nginx playbook.yml
update-app:
	ansible-playbook -i inventory.ini -u root -K --vault-password-file password -t update_app playbook.yml
restart-app:
	ansible-playbook -i inventory.ini -u root -K --vault-password-file password -t restart_app playbook.yml
restart-db:
	ansible-playbook -i inventory.ini -u root -K --vault-password-file password -t restart_db playbook.yml
install-roles:
	ansible-galaxy install -r requirements.yml
install-collections:
	ansible-galaxy collection install -r requirements.yml