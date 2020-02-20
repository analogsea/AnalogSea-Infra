# Prerequisites

- `--allow-privileged=true`
- Supported container runtimes:
  - docker
  - crio

# No hardware virtualization support?
- Run these commands before installing KubeVirt
- `kubectl create namespace kubevirt`
- `kubectl create configmap -n kubevirt kubevirt-config  --from-literal debug.useEmulation=true`

# Installation
- Deploy the KubeVirt operator
  - `kubectl apply -f https://github.com/kubevirt/kubevirt/releases/download/v0.25.0/kubevirt-operator.yaml`
- Create the KubeVirt CR
  - `kubectl apply -f https://github.com/kubevirt/kubevirt/releases/download/v0.25.0/kubevirt-cr.yaml`
- Optional: Wait until all KubeVirt components come up
  - `kubectl -n kubevirt wait kv kubevirt --for condition=Available --timeout=-1s`
- Optional: Install KubeVirt kubectl plugin
  - Install krew
  - `kubectl krew install virt`

# Deploy a VM
- This manifest will deploy a 1 vCPU, 1Gi RAM Ubuntu 16.04 VM
- The storage is not persistent, so don't run any real workloads on it
- Replace `$YOUR_KEY_HERE` with an SSH public key, and `$YOUR_PASSWORD_HERE` with a root password (for serial console access)
```
apiVersion: kubevirt.io/v1alpha3
kind: VirtualMachine
metadata:
  name: test-vm
  namespace: default
spec:
  running: true
  template:
    metadata:
      labels:
        kubevirt.io/name: test-vm
    spec:
      domain:
        devices:
          autoattachPodInterface: true # true by default, explicitly setting for clarity
          disks:
          - name: bootdisk
            disk:
              bus: virtio
          - name: cloud-init
            disk:
              bus: virtio
          interfaces:
          - name: default
            bridge: {}
        resources:
          requests:
            memory: 1Gi
            cpu: 1
      terminationGracePeriodSeconds: 0
      networks:
      - name: default
        pod: {}
      volumes:
      - name: bootdisk
        containerDisk:
          image: camelcasenotation/ubuntu1604-containerdisk:latest
      - name: cloud-init
        cloudInitNoCloud:
          userData: |-
            #cloud-config
            users:
              - name: root
                ssh-authorized-keys:
                  - $YOUR_KEY_HERE
            ssh_pwauth: True
            password: $YOUR_PASSWORD_HERE
            chpasswd:
              expire: False
              list: |-
                 root:$YOUR_PASSWORD_HERE
```

# Access the VM
- Be careful when exposing VMs externally with a NodePort service and a weak password
- Serial console is only possible with kubectl `virt` plugin
- SSH in as `root` user
- With virt:
  - SSH access: `kubectl virt expose vmi test-vm --port=22 --name=test-vm-ssh --type=NodePort`
  - Serial console: `virtctl console test-vm`

- Without virt:
```
apiVersion: v1
kind: Service
metadata:
  name: test-vm-ssh
spec:
  ports:
  - name: test-vm-ssh
    protocol: TCP
    port: 22
    targetPort: 22
  selector:
    kubevirt.io/name: test-vm
  type: NodePort
```

# Uninstall
```
export RELEASE=v0.25.0
kubectl delete -n kubevirt kubevirt kubevirt --wait=true # --wait=true should anyway be default
kubectl delete apiservices v1alpha3.subresources.kubevirt.io # this needs to be deleted to avoid stuck terminating namespaces
kubectl delete mutatingwebhookconfigurations virt-api-mutator # not blocking but would be left over
kubectl delete validatingwebhookconfigurations virt-api-validator # not blocking but would be left over
kubectl delete -f https://github.com/kubevirt/kubevirt/releases/download/${RELEASE}/kubevirt-operator.yaml --wait=false
```
- If these commands get stuck, delete the finalizer and rerun the uninstallation commands

### Delete Finalizer
```
kubectl -n kubevirt patch kv kubevirt --type=json -p '[{ "op": "remove", "path": "/metadata/finalizers" }]'
```


# Troubleshooting
- Ensure that Kubernetes has enough spare CPU to deploy your requested VM
- Ensure that the service selector correctly targets the VM pod
- Check that the Docker MTU and CNI plugin MTU are appropriate for your network
- Use `virtctl console $VM_NAME_HERE` to ensure that VM has started and is ready for SSH logins

# References
- [https://kubevirt.io/user-guide/docs/latest/administration/intro.html](https://kubevirt.io/user-guide/docs/latest/administration/intro.html)
