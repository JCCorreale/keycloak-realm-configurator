- clientId: frontend-cli
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
    {{- if .eidas.enabled }}
    - name: idp-mapper
      protocol: openid-connect
      protocolMapper: oidc-usersessionmodel-note-mapper
      config:
        user.session.note: idp
        claim.name: idp
        jsonType.label: String
        access.token.claim: true

    - name: smssp-response-mapper
      protocol: openid-connect
      protocolMapper: oidc-usersessionmodel-note-mapper
      config:
        user.session.note: smssp_response
        claim.name: smssp_response
        jsonType.label: String
        userinfo.token.claim: true
    {{- end }}