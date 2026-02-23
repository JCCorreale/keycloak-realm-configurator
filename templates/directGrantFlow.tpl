- alias: Custom direct grant
  description: OpenID Connect Resource Owner Grant
  providerId: basic-flow
  topLevel: true
  builtIn: false
  authenticationExecutions:
    - authenticator: direct-grant-validate-username
      authenticatorFlow: false
      requirement: REQUIRED
      priority: 10
      userSetupAllowed: false
    - authenticator: direct-grant-validate-password
      authenticatorFlow: false
      requirement: REQUIRED
      priority: 20
      userSetupAllowed: false
{{- if .authenticator.enabled }}
    - authenticator: attribute-authenticator
      authenticatorFlow: false
      requirement: REQUIRED
      priority: 25
      userSetupAllowed: false
{{- end }}
    - authenticatorFlow: true
      requirement: CONDITIONAL
      priority: 30
      flowAlias: Custom Direct Grant - Conditional OTP
      userSetupAllowed: false
- alias: Custom Direct Grant - Conditional OTP
  description: Flow to determine if the OTP is required for the authentication
  providerId: basic-flow
  topLevel: false
  builtIn: false
  authenticationExecutions:
    - authenticator: conditional-user-configured
      authenticatorFlow: false
      requirement: REQUIRED
      priority: 10
      userSetupAllowed: false
    - authenticator: direct-grant-validate-otp
      authenticatorFlow: false
      requirement: REQUIRED
      priority: 20
      userSetupAllowed: false
