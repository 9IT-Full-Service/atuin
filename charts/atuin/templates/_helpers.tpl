{{/*
Expand the name of the chart.
*/}}
{{- define "atuin.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "atuin.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "atuin.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "atuin.labels" -}}
helm.sh/chart: {{ include "atuin.chart" . }}
{{ include "atuin.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "atuin.selectorLabels" -}}
app.kubernetes.io/name: {{ include "atuin.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "atuin.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "atuin.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
PostgreSQL fullname
*/}}
{{- define "atuin.postgresql.fullname" -}}
{{- printf "%s-postgresql" (include "atuin.fullname" .) | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
PostgreSQL labels
*/}}
{{- define "atuin.postgresql.labels" -}}
helm.sh/chart: {{ include "atuin.chart" . }}
{{ include "atuin.postgresql.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
PostgreSQL selector labels
*/}}
{{- define "atuin.postgresql.selectorLabels" -}}
app.kubernetes.io/name: {{ include "atuin.name" . }}-postgresql
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Get the password secret name
*/}}
{{- define "atuin.secretName" -}}
{{- if .Values.postgresql.auth.existingSecret }}
{{- .Values.postgresql.auth.existingSecret }}
{{- else }}
{{- include "atuin.fullname" . }}
{{- end }}
{{- end }}

{{/*
Database URI
*/}}
{{- define "atuin.databaseUri" -}}
{{- printf "postgres://%s:$(ATUIN_DB_PASSWORD)@%s:5432/%s" .Values.postgresql.auth.username (include "atuin.postgresql.fullname" .) .Values.postgresql.auth.database }}
{{- end }}
