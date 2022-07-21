# SKAFFOLD TASKS =======================================================================================================
skaffold-up: ## Run skaffold and set default params
	-kubectl create namespace remote-debug
	@skaffold dev --port-forward

skaffold-debug: ## Run skaffold with debug mode
	@skaffold debug --port-forward

skaffold-down: ## Delete skaffold deployment
	@skaffold delete --force
	-kubectl delete namespace remote-debug
