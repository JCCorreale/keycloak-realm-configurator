enabled: true
realm: {{ .realm }}

registrationAllowed: {{ .registration.enabled }}
registrationEmailAsUsername: {{ .emailAsUsername }}

{{- if .registration.enabled }}
registrationFlow: Custom registration
{{- end }}
{{- if .eidas.enabled }}
firstBrokerLoginFlow: Custom first broker login
{{- end }}
{{- if .authenticator.enabled }}
browserFlow: Custom browser
directGrantFlow: Custom direct grant
{{- end }}

roles:
  realm:
{{ tmpl.Exec "templates/roles.tpl" . | indent 4 }}

clients:
{{- if .frontendClient.enabled }}
{{ tmpl.Exec "templates/frontendClient.tpl" . | indent 2 }}
{{- end }}

{{/* Service account template includes both last client and start user list, should be at the end for now */}}
{{- if .serviceAccount.enabled }}
{{ tmpl.Exec "templates/serviceAccount.tpl" . }}
{{- end }}

{{- if .eidas.enabled }}
identityProviders:
{{ tmpl.Exec "templates/identityProviders.tpl" . | indent 2 }}
{{- end }}

{{- if .eidas.enabled }}
identityProviderMappers:
{{ tmpl.Exec "templates/identityProviderMappers.tpl" . | indent 2 }}
{{- end }}

authenticationFlows:
{{- if .registration.enabled }}
{{ tmpl.Exec "templates/registrationFlow.tpl" . | indent 2 }}
{{- end }}
{{- if .eidas.enabled }}
{{ tmpl.Exec "templates/firstBrokerLoginFlow.tpl" . | indent 2 }}
{{- end }}
{{- if .authenticator.enabled }}
{{ tmpl.Exec "templates/browserFlow.tpl" . | indent 2 }}
{{ tmpl.Exec "templates/directGrantFlow.tpl" . | indent 2 }}
{{- end }}

{{ tmpl.Exec "templates/authenticatorConfig.tpl" . }}
