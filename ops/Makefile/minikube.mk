# MINIKUBE TASKS =======================================================================================================

minikube-up: ## run minikube for dev mode
	@minikube start \
		--memory "4192" \
		--driver=docker \
		--container-runtime=containerd \
		--listen-address=0.0.0.0 \
		--addons=ingress \
		--extra-config=apiserver.authorization-mode=Node,RBAC

	# Addons enable
	@eval $(minikube docker-env) # Set docker env

	# Change context (optional)
	-kubectx minikube

minikube-down: ## minikube delete
	@minikube delete
