- alias: Custom browser
  description: Browser based authentication
  providerId: basic-flow
  topLevel: true
  builtIn: false
  authenticationExecutions:
    - authenticator: auth-cookie
      authenticatorFlow: false
      requirement: ALTERNATIVE
      priority: 10
      userSetupAllowed: false
    - authenticator: auth-spnego
      authenticatorFlow: false
      requirement: DISABLED
      priority: 20
      userSetupAllowed: false
    - authenticator: identity-provider-redirector
      authenticatorFlow: false
      requirement: ALTERNATIVE
      priority: 25
      userSetupAllowed: false
    - authenticatorFlow: true
      requirement: ALTERNATIVE
      priority: 26
      flowAlias: Custom Organization
      userSetupAllowed: false
    - authenticatorFlow: true
      requirement: ALTERNATIVE
      priority: 30
      flowAlias: Custom forms
      userSetupAllowed: false
- alias: Custom Organization
  providerId: basic-flow
  topLevel: false
  builtIn: false
  authenticationExecutions:
    - authenticatorFlow: true
      requirement: CONDITIONAL
      priority: 10
      flowAlias: Custom Browser - Conditional Organization
      userSetupAllowed: false
- alias: Custom Browser - Conditional Organization
  description: Flow to determine if the organization identity-first login is to be used
  providerId: basic-flow
  topLevel: false
  builtIn: false
  authenticationExecutions:
    - authenticator: conditional-user-configured
      authenticatorFlow: false
      requirement: REQUIRED
      priority: 10
      userSetupAllowed: false
    - authenticator: organization
      authenticatorFlow: false
      requirement: ALTERNATIVE
      priority: 20
      userSetupAllowed: false
- alias: Custom forms
  description: Username, password, otp and other auth forms.
  providerId: basic-flow
  topLevel: false
  builtIn: false
  authenticationExecutions:
    - authenticator: auth-username-password-form
      authenticatorFlow: false
      requirement: REQUIRED
      priority: 10
      userSetupAllowed: false
{{- if .authenticator.enabled }}
    - authenticator: attribute-authenticator
      authenticatorFlow: false
      requirement: REQUIRED
      priority: 15
      userSetupAllowed: false
{{- end }}
    - authenticatorFlow: true
      requirement: CONDITIONAL
      priority: 20
      flowAlias: Custom Browser - Conditional 2FA
      userSetupAllowed: false
- alias: Custom Browser - Conditional 2FA
  description: Flow to determine if any 2FA is required for the authentication
  providerId: basic-flow
  topLevel: false
  builtIn: false
  authenticationExecutions:
    - authenticator: conditional-user-configured
      authenticatorFlow: false
      requirement: REQUIRED
      priority: 10
      userSetupAllowed: false
    - authenticatorConfig: browser-conditional-credential
      authenticator: conditional-credential
      authenticatorFlow: false
      requirement: REQUIRED
      priority: 20
      userSetupAllowed: false
    - authenticator: auth-otp-form
      authenticatorFlow: false
      requirement: ALTERNATIVE
      priority: 30
      userSetupAllowed: false
    - authenticator: webauthn-authenticator
      authenticatorFlow: false
      requirement: DISABLED
      priority: 40
      userSetupAllowed: false
    - authenticator: auth-recovery-authn-code-form
      authenticatorFlow: false
      requirement: DISABLED
      priority: 50
      userSetupAllowed: false
