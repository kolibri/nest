INVENTORY=real
system-init:
	ssh root@$(HOST) 'bash -s' < scripts/arch_x64/install.sh
	echo "now wait and continue with make HOST=$(HOST) provision-init"

provision-init:
	ansible-playbook -v -u root -i inventory/$(INVENTORY) -t init -l $(HOST) site.yml

provision:
	ansible-playbook -v -i inventory/$(INVENTORY) -l $(HOST) site.yml
