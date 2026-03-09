{{- range .serviceAccounts }}
- username: service-account-{{ .clientId }}
  enabled: true
  serviceAccountClientId: {{ .clientId }}
  clientRoles:
    realm-management:
  {{- range .realmManagementRoles }}
      - {{ . }}
  {{- end }}
  {{ with .realmRoles }}
  realmRoles: 
  {{- range .realmRoles }}
      - {{ . }}
  {{- end }}
  {{- end }}
{{- end }}