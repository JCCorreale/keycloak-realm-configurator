{{- $realm := .realm }}
{{- $defaultRoles := jq "[.roles[] | select(.default==true)]" . }}

{{- range .roles }}

- name: {{ .name }}
  description: {{ .description }}
  composite: false
  clientRole: false

{{- end }}

- name: default-roles-{{ $realm }}
  description: ${role_default-roles}
  composite: true
  clientRole: false
  composites:
    realm:
{{- range $defaultRoles }}
      - {{ .name }}
{{- end }}
      - offline_access
      - uma_authorization
    client:
      account:
        - manage-account
        - view-profile