- alias: Custom first broker login
  description: Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account
  providerId: basic-flow
  topLevel: true
  builtIn: false
  authenticationExecutions:
    - authenticatorConfig: review profile config
      authenticator: idp-review-profile
      authenticatorFlow: false
      requirement: REQUIRED
      priority: 10
      userSetupAllowed: false
    - authenticator: custom-toc
      authenticatorFlow: false
      requirement: {{ if .eidas.termsAndConditions.enabled }}REQUIRED{{ else }}DISABLED{{ end }}
      priority: 15
      userSetupAllowed: false
    - authenticatorFlow: true
      requirement: REQUIRED
      priority: 20
      flowAlias: Custom User creation or linking
      userSetupAllowed: false
    - authenticatorFlow: true
      requirement: CONDITIONAL
      priority: 60
      flowAlias: Custom First Broker Login - Conditional Organization
      userSetupAllowed: false
- alias: Custom User creation or linking
  description: Flow for the existing/non-existing user alternatives
  providerId: basic-flow
  topLevel: false
  builtIn: false
  authenticationExecutions:
    - authenticator: create-user-if-tc-accepted
      authenticatorFlow: false
      requirement: {{ if .eidas.termsAndConditions.enabled }}REQUIRED{{ else }}DISABLED{{ end }}
      priority: 5
      userSetupAllowed: false
    - authenticatorConfig: create unique user config
      authenticator: idp-create-user-if-unique
      authenticatorFlow: false
      requirement: {{ if .eidas.termsAndConditions.enabled }}DISABLED{{ else }}ALTERNATIVE{{ end }}
      priority: 10
      userSetupAllowed: false
    - authenticatorFlow: true
      requirement: ALTERNATIVE
      priority: 20
      flowAlias: Custom Handle Existing Account
      userSetupAllowed: false
- alias: Custom First Broker Login - Conditional Organization
  description: Flow to determine if the authenticator that adds organization members is to be used
  providerId: basic-flow
  topLevel: false
  builtIn: false
  authenticationExecutions:
    - authenticator: conditional-user-configured
      authenticatorFlow: false
      requirement: REQUIRED
      priority: 10
      autheticatorFlow: false
      userSetupAllowed: false
    - authenticator: idp-add-organization-member
      authenticatorFlow: false
      requirement: REQUIRED
      priority: 20
      autheticatorFlow: false
      userSetupAllowed: false
- alias: Custom Handle Existing Account
  description: Handle what to do if there is existing account with same email/username like authenticated identity provider
  providerId: basic-flow
  topLevel: false
  builtIn: false
  authenticationExecutions:
    - authenticator: idp-confirm-link
      authenticatorFlow: false
      requirement: REQUIRED
      priority: 10
      userSetupAllowed: false
    - authenticatorFlow: true
      requirement: REQUIRED
      priority: 20
      flowAlias: Custom Account verification options
      userSetupAllowed: false
- alias: Custom Account verification options
  description: Method with which to verity the existing account
  providerId: basic-flow
  topLevel: false
  builtIn: false
  authenticationExecutions:
    - authenticator: idp-email-verification
      authenticatorFlow: false
      requirement: ALTERNATIVE
      priority: 10
      userSetupAllowed: false
    - authenticatorFlow: true
      requirement: ALTERNATIVE
      priority: 20
      flowAlias: Custom Verify Existing Account by Re-authentication
      userSetupAllowed: false
- alias: Custom Verify Existing Account by Re-authentication
  description: Reauthentication of existing account
  providerId: basic-flow
  topLevel: false
  builtIn: false
  authenticationExecutions:
    - authenticator: idp-username-password-form
      authenticatorFlow: false
      requirement: REQUIRED
      priority: 10
      userSetupAllowed: false
    - authenticatorFlow: true
      requirement: CONDITIONAL
      priority: 20
      flowAlias: Custom First broker login - Conditional 2FA
      userSetupAllowed: false
- alias: Custom First broker login - Conditional 2FA
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
    - authenticatorConfig: first-broker-login-conditional-credential
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
