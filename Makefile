APP_VERSION ?= 0.1.0
CHART_VERSION ?= dev-$(shell git rev-parse --short HEAD)

.PHONY: gen.config
gen.config:
	via helm gen-config-templates --config config.yaml --out-dir ./templates/config --chart-name airbyte-keycloak

.PHONY: helm.publish
helm.publish:
	via helm publish \
		--name airbyte-keycloak \
		--ref main \
		--version $(CHART_VERSION) \
		--app-version $(APP_VERSION) \
		--src-repo https://github.com/airbytehq/airbyte-keycloak-chart.git \
		--dst-repo https://github.com/airbytehq/helm-charts.git
