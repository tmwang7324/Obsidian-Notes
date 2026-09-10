# Overview
All of Google's frontier software ran on proprietary containers. To manage these containers, they build in-house systems named Borg and Omega. Kubernetes is a combination of both sent to the open-source environment.



### Nodes
A Kubernetes node is netiher a Pod nor the entire orchestration system; it is a machine (physical server or VM) either runs Pods or controls them.


## Structure
A Kubernetes cluster is primarily composed of Master Nodes and Worker Nodes.

The master node controls worker node self-healing
![[Pasted image 20260817172430.png]]