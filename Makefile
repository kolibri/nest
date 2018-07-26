default:
	echo "No default task"

ansible-galaxy:
	ansible-galaxy install -r roles_galaxy/requirements.yml -p roles_galaxy
