# SKAFFOLD TASKS =======================================================================================================
devspace-up: ## Run devspace and set default params
	-kubectl create namespace remote-debug
	@devspace use namespace remote-debug
	@devspace build

devspace-down: ## Delete devspace deployment
	@devspace purge
	@devspace cleanup images
