- clientId: cli
  enabled: true
  publicClient: true

  {{- if .test.enabled }}
  directAccessGrantsEnabled: true
  {{- end }}

  redirectUris:
    - '*'

  webOrigins:
    - '*'

  protocolMappers:
    - name: roles-mapper
      protocol: openid-connect
      protocolMapper: oidc-usermodel-realm-role-mapper
      config:
        multivalued: true
        claim.name: client-roles
        jsonType.label: String
        access.token.claim: true
        userinfo.token.claim: true
        id.token.claim: true
        introspection.token.claim: true
