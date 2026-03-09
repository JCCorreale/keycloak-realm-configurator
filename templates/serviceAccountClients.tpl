{{- range .serviceAccounts }}
- clientId: {{ .clientId }}
  enabled: true
  clientAuthenticatorType: client-secret
  directAccessGrantsEnabled: false
  serviceAccountsEnabled: true
  publicClient: false
  protocol: openid-connect
{{- end }}