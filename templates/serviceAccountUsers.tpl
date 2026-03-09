{{- range .serviceAccounts }}
- username: service-account-{{ .clientId }}
  enabled: true
  serviceAccountClientId: {{ .clientId }}
  clientRoles:
    realm-management:
  {{- range .realmManagementRoles }}
      - {{ . }}
  {{- end }}
{{- end }}