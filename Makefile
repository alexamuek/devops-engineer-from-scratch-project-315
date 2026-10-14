deploy:
	ansible-playbook -i inventory.ini -u alexamuek -K --vault-password-file password playbook-roles.yml