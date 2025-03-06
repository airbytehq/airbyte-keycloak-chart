
{{/* DO NOT EDIT: This file was autogenerated. */}}

{{/*
    Admin Configuration
*/}}

{{/*
Renders the admin secret name
*/}}
{{- define "airbyte-keycloak.admin.secretName" }}
{{- if .Values.admin.secretName }}
    {{- .Values.admin.secretName }}
{{- else }}
    {{- .Values.secretName | default (printf "%s-airbyte-keycloak-secrets" .Release.Name) }}
{{- end }}
{{- end }}

{{/*
Renders the admin.user value
*/}}
{{- define "airbyte-keycloak.admin.user" }}
    {{- .Values.admin.user }}
{{- end }}

{{/*
Renders the admin.user secret key
*/}}
{{- define "airbyte-keycloak.admin.user.secretKey" }}
	{{- .Values.admin.userSecretKey | default "KEYCLOAK_ADMIN_USER" }}
{{- end }}

{{/*
Renders the admin.user environment variable
*/}}
{{- define "airbyte-keycloak.admin.user.env" }}
- name: KEYCLOAK_ADMIN_USER
  valueFrom:
    secretKeyRef:
      name: {{ include "airbyte-keycloak.admin.secretName" . }}
      key: {{ include "airbyte-keycloak.admin.user.secretKey" . }}
{{- end }}

{{/*
Renders the admin.password value
*/}}
{{- define "airbyte-keycloak.admin.password" }}
    {{- .Values.admin.password }}
{{- end }}

{{/*
Renders the admin.password secret key
*/}}
{{- define "airbyte-keycloak.admin.password.secretKey" }}
	{{- .Values.admin.passwordSecretKey | default "KEYCLOAK_ADMIN_PASSWORD" }}
{{- end }}

{{/*
Renders the admin.password environment variable
*/}}
{{- define "airbyte-keycloak.admin.password.env" }}
- name: KEYCLOAK_ADMIN_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ include "airbyte-keycloak.admin.secretName" . }}
      key: {{ include "airbyte-keycloak.admin.password.secretKey" . }}
{{- end }}

{{/*
Renders the admin.hostnameUrl value
*/}}
{{- define "airbyte-keycloak.admin.hostnameUrl" }}
    {{- .Values.admin.hostnameUrl | default (printf "http://localhost:%d/auth" (int (include "airbyte-keycloak.keycloak.port" .))) }}
{{- end }}

{{/*
Renders the admin.hostnameUrl environment variable
*/}}
{{- define "airbyte-keycloak.admin.hostnameUrl.env" }}
- name: KEYCLOAK_ADMIN_HOSTNAME_URL
  valueFrom:
    configMapKeyRef:
      name: {{ .Release.Name }}-airbyte-keycloak-env
      key: KEYCLOAK_ADMIN_HOSTNAME_URL
{{- end }}

{{/*
Renders the set of all admin environment variables
*/}}
{{- define "airbyte-keycloak.admin.envs" }}
{{- include "airbyte-keycloak.admin.user.env" . }}
{{- include "airbyte-keycloak.admin.password.env" . }}
{{- include "airbyte-keycloak.admin.hostnameUrl.env" . }}
{{- end }}

{{/*
Renders the set of all admin config map variables
*/}}
{{- define "airbyte-keycloak.admin.configVars" }}
KEYCLOAK_ADMIN_HOSTNAME_URL: {{ include "airbyte-keycloak.admin.hostnameUrl" . | quote }}
{{- end }}

{{/*
Renders the set of all admin secret variables
*/}}
{{- define "airbyte-keycloak.admin.secrets" }}
KEYCLOAK_ADMIN_USER: {{ include "airbyte-keycloak.admin.user" . | quote }}
KEYCLOAK_ADMIN_PASSWORD: {{ include "airbyte-keycloak.admin.password" . | quote }}
{{- end }}
