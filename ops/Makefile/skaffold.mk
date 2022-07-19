# SKAFFOLD TASKS =======================================================================================================
skaffold-up: ## Run local minikube and set default params
	-kubectl create namespace remote-debug
	@skaffold dev --port-forward

skaffold-debug: ## Run local minikube and set default params with debug mode
	@skaffold debug --port-forward
