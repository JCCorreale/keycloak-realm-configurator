  - clientId: {{ .serviceAccount.clientId }}
    enabled: true
    clientAuthenticatorType: client-secret
    directAccessGrantsEnabled: false
    serviceAccountsEnabled: true
    publicClient: false
    protocol: openid-connect

users:
  - username: service-account-{{ .serviceAccount.clientId }}
    enabled: true
    serviceAccountClientId: {{ .serviceAccount.clientId }}

    clientRoles:
      realm-management:
{{- range .serviceAccount.realmManagementRoles }}
        - {{ . }}
{{- end }}