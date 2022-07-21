# SKAFFOLD TASKS =======================================================================================================
devspace-up: ## Run devspace and set default params
	-kubectl create namespace remote-debug
	@devspace use namespace remote-debug
	@devspace dev --force-build --force-deploy

devspace-down: ## Delete devspace deployment
	@devspace purge
	@devspace cleanup images
