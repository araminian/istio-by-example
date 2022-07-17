{{/*
Expand the name of the chart.
*/}}
{{- define "frontend.name" -}}
{{- .Values.name | default "frontend-mesh" -}}
{{- end }}

{{/*
Common labels
*/}}
app.kubernetes.io/part-of: 'istio-by-example'
app.kubernetes.io/branch: '{{ .Values.branch }}'
{{- define "frontend.labels" -}}
{{ include "frontend.selectorLabels" . }}
app.kubernetes.io/version: '{{ .Values.image.tag }}'
{{- end }}

{{/*
Selector labels
*/}}
{{- define "frontend.selectorLabels" -}}
app.kubernetes.io/name: {{ include "frontend.name" . }}
app.kubernetes.io/component: {{ .Chart.Name }}
environment: {{ .Values.environment }}
{{- end }}
