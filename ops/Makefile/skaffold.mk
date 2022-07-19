# SKAFFOLD TASKS =======================================================================================================
skaffold-up: ## Run local minikube and set default params
	@skaffold dev --port-forward

skaffold-debug: ## Run local minikube and set default params with debug mode
	@skaffold debug --port-forward
