verify: fmt init validate

fmt:
		docker-compose run --rm terraform fmt -recursive .

init:
		docker-compose run --rm terraform init

validate:
		docker-compose run --rm terraform validate

workspace-list:
		docker-compose run --rm terraform workspace list

select-dev:
		docker-compose run --rm terraform workspace select dev

select-prod:
		docker-compose run --rm terraform workspace select production

plan-dev: select-dev
		docker-compose run --rm terraform plan -var-file=environments/dev/cluster.tfvars

plan-prod: select-prod
		docker-compose run --rm terraform plan -var-file=environments/production/cluster.tfvars

apply-dev: select-dev
		docker-compose run --rm terraform apply -var-file=environments/dev/cluster.tfvars

apply-prod: select-prod
		docker-compose run --rm terraform apply -var-file=environments/production/cluster.tfvars

help:
		@echo "Usage: make [target]"
		@echo ""
		@echo "Targets:"
		@echo "\tverify  \tFormatar, inicializar e validar o código."
		@echo "\tfmt     \tFormatar o código."
		@echo "\tinit    \tInicializar o Terraform."
		@echo "\tvalidate \tValidar as configurações do Terraform."
		@echo "\tworkspace-list \tListar todos os ambientes."
		@echo "\tselect-dev \tSelecionar o ambiente: dev."
		@echo "\tselect-prod \tSelecionar o ambiente: production."
		@echo "\tplan-dev \tPlanejar as configurações do ambiente: dev."
		@echo "\tplan-prod \tPlanejar as configurações do ambiente: production."
		@echo "\tapply-dev \tAplicar as configurações do ambiente: dev."
		@echo "\tapply-prod \tAplicar as configurações do ambiente: production."
		@echo "\thelp \t\tExibir esta mensagem de ajuda."