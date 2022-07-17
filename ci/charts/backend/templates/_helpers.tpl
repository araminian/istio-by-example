{{/*
Expand the name of the chart.
*/}}
{{- define "backend.name" -}}
{{- .Values.name | default "backend-mesh" -}}
{{- end }}

{{/*
Common labels
*/}}
app.kubernetes.io/part-of: 'istio-by-example'
app.kubernetes.io/branch: '{{ .Values.branch }}'
{{- define "backend.labels" -}}
{{ include "backend.selectorLabels" . }}
app.kubernetes.io/version: '{{ .Values.image.tag }}'
{{- end }}

{{/*
Selector labels
*/}}
{{- define "backend.selectorLabels" -}}
app.kubernetes.io/name: {{ include "backend.name" . }}
app.kubernetes.io/component: {{ .Chart.Name }}
environment: {{ .Values.environment }}
{{- end }}
