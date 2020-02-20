cd "${0%/*}"
ansible-playbook -K -i inventory.yaml rook_prep.yaml
