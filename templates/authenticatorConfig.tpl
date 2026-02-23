authenticatorConfig:
  - alias: browser-conditional-credential
    config:
      credentials: webauthn-passwordless
  - alias: create unique user config
    config:
      require.password.update.after.registration: 'false'
  - alias: first-broker-login-conditional-credential
    config:
      credentials: webauthn-passwordless
  - alias: review profile config
    config:
      update.profile.on.first.login: missing
