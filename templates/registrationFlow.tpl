- alias: Custom registration
  description: Registration flow
  providerId: basic-flow
  topLevel: true
  builtIn: false
  authenticationExecutions:
    - authenticator: registration-page-form
      authenticatorFlow: true
      requirement: REQUIRED
      priority: 10
      flowAlias: Custom registration form
      userSetupAllowed: false
- alias: Custom registration form
  description: Registration form
  providerId: form-flow
  topLevel: false
  builtIn: false
  authenticationExecutions:
    - authenticator: registration-user-creation
      authenticatorFlow: false
      requirement: REQUIRED
      priority: 20
      userSetupAllowed: false
    - authenticator: registration-password-action
      authenticatorFlow: false
      requirement: REQUIRED
      priority: 50
      userSetupAllowed: false
    - authenticator: registration-recaptcha-action
      authenticatorFlow: false
      requirement: DISABLED
      priority: 60
      userSetupAllowed: false
    - authenticator: registration-terms-and-conditions
      authenticatorFlow: false
      requirement: {{ if .registration.termsAndConditions.enabled }}REQUIRED{{ else }}DISABLED{{ end }}
      priority: 70
      userSetupAllowed: false
