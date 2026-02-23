{{- if .eidas.naturalPerson.enabled }}
- name: idp-mapper
  identityProviderAlias: eidas-demo-natural-person
  identityProviderMapper: hardcoded-user-session-attribute-idp-mapper
  config:
    attribute: idp
    attribute.value: eidas
- name: smssp-response-mapper
  identityProviderAlias: eidas-demo-natural-person
  identityProviderMapper: custom-attribute-mapper
  config:
    sessionNote: smssp_response
{{- end }}
{{- if .eidas.legalPerson.enabled }}
- name: idp-mapper
  identityProviderAlias: eidas-demo-legal-person
  identityProviderMapper: hardcoded-user-session-attribute-idp-mapper
  config:
    attribute: idp
    attribute.value: eidas
- name: smssp-response-mapper
  identityProviderAlias: eidas-demo-legal-person
  identityProviderMapper: custom-attribute-mapper
  config:
    sessionNote: smssp_response
{{- end }}