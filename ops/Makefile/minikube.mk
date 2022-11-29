# MINIKUBE TASKS =======================================================================================================

minikube-up: ## run minikube for dev mode
	@minikube start \
		--memory "1984" \
		--driver=docker \
		--addons=registry-creds,ingress \
		--extra-config=apiserver.authorization-mode=Node,RBAC

	# Addons enable
	@eval $(minikube docker-env) # Set docker env

	# Change context (optional)
	-kubectx minikube

minikube-down: ## minikube delete
	@minikube delete
