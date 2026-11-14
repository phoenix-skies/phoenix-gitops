{{- define "phoenix.labels" -}}
app.kubernetes.io/part-of: phoenix
app.kubernetes.io/managed-by: {{ .Release.Service }}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version }}
phoenix.dataquaint.com/env: {{ .Values.environment }}
{{- end }}

{{- define "phoenix.image" -}}
{{ .root.Values.imageRegistry }}/{{ .img.repository }}:{{ .img.tag }}
{{- end }}
