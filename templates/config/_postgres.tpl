
{{/* DO NOT EDIT: This file was autogenerated. */}}

{{/*
    Postgres Configuration
*/}}

{{/*
Renders the postgres secret name
*/}}
{{- define "airbyte-keycloak.postgres.secretName" }}
{{- if .Values.postgres.secretName }}
    {{- .Values.postgres.secretName }}
{{- else }}
    {{- .Values.secretName | default (printf "%s-airbyte-keycloak-secrets" .Release.Name) }}
{{- end }}
{{- end }}

{{/*
Renders the postgres.name value
*/}}
{{- define "airbyte-keycloak.postgres.name" }}
    {{- .Values.postgres.name | default "keycloak" }}
{{- end }}

{{/*
Renders the postgres.name environment variable
*/}}
{{- define "airbyte-keycloak.postgres.name.env" }}
- name: POSTGRES_DB
  valueFrom:
    configMapKeyRef:
      name: {{ .Release.Name }}-airbyte-keycloak-env
      key: POSTGRES_DB
{{- end }}

{{/*
Renders the postgres.password value
*/}}
{{- define "airbyte-keycloak.postgres.password" }}
    {{- .Values.postgres.password }}
{{- end }}

{{/*
Renders the postgres.password secret key
*/}}
{{- define "airbyte-keycloak.postgres.password.secretKey" }}
	{{- .Values.postgres.passwordSecretKey | default "POSTGRES_PASSWORD" }}
{{- end }}

{{/*
Renders the postgres.password environment variable
*/}}
{{- define "airbyte-keycloak.postgres.password.env" }}
- name: POSTGRES_PASSWORD
  valueFrom:
    secretKeyRef:
      name: {{ include "airbyte-keycloak.postgres.secretName" . }}
      key: {{ include "airbyte-keycloak.postgres.password.secretKey" . }}
{{- end }}

{{/*
Renders the postgres.user value
*/}}
{{- define "airbyte-keycloak.postgres.user" }}
    {{- .Values.postgres.user }}
{{- end }}

{{/*
Renders the postgres.user secret key
*/}}
{{- define "airbyte-keycloak.postgres.user.secretKey" }}
	{{- .Values.postgres.userSecretKey | default "POSTGRES_USER" }}
{{- end }}

{{/*
Renders the postgres.user environment variable
*/}}
{{- define "airbyte-keycloak.postgres.user.env" }}
- name: POSTGRES_USER
  valueFrom:
    secretKeyRef:
      name: {{ include "airbyte-keycloak.postgres.secretName" . }}
      key: {{ include "airbyte-keycloak.postgres.user.secretKey" . }}
{{- end }}

{{/*
Renders the postgres.pgdataDir value
*/}}
{{- define "airbyte-keycloak.postgres.pgdataDir" }}
    {{- "/var/lib/postgresql/data/pgdata" }}
{{- end }}

{{/*
Renders the postgres.pgdataDir environment variable
*/}}
{{- define "airbyte-keycloak.postgres.pgdataDir.env" }}
- name: PGDATA
  valueFrom:
    configMapKeyRef:
      name: {{ .Release.Name }}-airbyte-keycloak-env
      key: PGDATA
{{- end }}

{{/*
Renders the set of all postgres environment variables
*/}}
{{- define "airbyte-keycloak.postgres.envs" }}
{{- include "airbyte-keycloak.postgres.name.env" . }}
{{- include "airbyte-keycloak.postgres.password.env" . }}
{{- include "airbyte-keycloak.postgres.user.env" . }}
{{- include "airbyte-keycloak.postgres.pgdataDir.env" . }}
{{- end }}

{{/*
Renders the set of all postgres config map variables
*/}}
{{- define "airbyte-keycloak.postgres.configVars" }}
POSTGRES_DB: {{ include "airbyte-keycloak.postgres.name" . | quote }}
PGDATA: {{ include "airbyte-keycloak.postgres.pgdataDir" . | quote }}
{{- end }}

{{/*
Renders the set of all postgres secret variables
*/}}
{{- define "airbyte-keycloak.postgres.secrets" }}
POSTGRES_PASSWORD: {{ include "airbyte-keycloak.postgres.password" . | quote }}
POSTGRES_USER: {{ include "airbyte-keycloak.postgres.user" . | quote }}
{{- end }}
