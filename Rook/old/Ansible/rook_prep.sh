cd "${0%/*}"
ansible-playbook -K -i new_inventory.yaml rook_prep.yaml
