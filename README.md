# install-etcd

Install etcd with the operator on Kubernetes via helm

## Prereqs

Get `helm` and `kubectl` if they are not installed.

`brew install kubernetes-helm kubernetes-cli`

Add the bitnami repo to your local config:

`helm repo add bitnami https://charts.bitnami.com/bitnami`

## Build

`time make all  2>&1 | tee /tmp/etcd-all.out`

## Checkout it out

```bash
$ helm list
NAME          	REVISION	UPDATED                 	STATUS  	CHART              	APP VERSION	NAMESPACE
configs-stage 	1       	Sun May 26 13:32:46 2019	DEPLOYED	etcd-2.2.3         	3.3.13     	default  
etcd-ops-stage	1       	Sun May 26 13:32:44 2019	DEPLOYED	etcd-operator-0.8.3	0.9.3      	default 
```

```bash
$ kubectl get pods
NAME                                                              READY   STATUS    RESTARTS   AGE
configs-stage-etcd-0                                              1/1     Running   0          17m
configs-stage-etcd-1                                              1/1     Running   0          17m
configs-stage-etcd-2                                              1/1     Running   0          17m
etcd-ops-stage-etcd-operator-etcd-backup-operator-7ddc5589nbkmp   1/1     Running   0          17m
etcd-ops-stage-etcd-operator-etcd-operator-756bd69f8f-rksxk       1/1     Running   0          17m
etcd-ops-stage-etcd-operator-etcd-restore-operator-f656b78qr2cb   1/1     Running   0          17m
```