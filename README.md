### Keycloak Realm Configurator

This project is a tool for configuring Keycloak realms using a YAML configuration file. It allows you to define your Keycloak realm, clients, roles, and other settings in a structured format, making it easier to manage and automate the configuration of your Keycloak instances.

It relies on two tools:

- [`gomplate`](https://docs.gomplate.ca) to render the YAML configuration file with environment variables and other data sources.
- [`keycloak-config-cli`](https://github.com/adorsys/keycloak-config-cli) to apply the rendered configuration to a Keycloak instance.

> ⚠️ `keycloak-config-cli` supports incremental Keycloak configuration, but has issues with the first broker login flow which have not yet been resolved. So at the moment it is possible to only initialize the realm from scratch, but not to update an existing realm.

## Prerequisites

- [`gomplate`](https://docs.gomplate.ca/installing/) for template rendering
- Java is required to run the `bin/keycloak-config-cli` JAR.
- A running Keycloak instance

> ⚠️ `keycloak-config-cli` had issues with first broker login flow configuration also in the creation phases, so the `bin/keycloak-config-cli` JAR is required as a custom build with a workaround for this issue.

## Usage

1. Create a YAML configuration file for your Keycloak realm in the project root and name it `realm.yaml`. You can find examples in the `examples` folder. See [Configuration](#configuration) below for more details on the configuration format.

2. Execute the command `gomplate` to generate your keycloak realm configuration file in the `out` folder. See [`gomplate`](https://docs.gomplate.ca/config/) configuration doc for more details on the available parameters and different ways to configure it.

3. Execute the command `java -jar bin/keycloak-config-cli.jar` with the appropriate parameters to apply the configuration to your Keycloak instance, for example:

```powershell
java `
 -jar bin/keycloak-config-cli.jar `
 --keycloak.url=http://localhost:8080 `
 --keycloak.user=user `
 --keycloak.password=admin `
 --import.files.locations=out/realm.yaml `
```

See the [`keycloak-config-cli`](https://github.com/adorsys/keycloak-config-cli?tab=readme-ov-file#configuration) configuration doc for more details on the available parameters.

## Configuration

| Property Path                           | Type    | Description                                                    |
|-----------------------------------------|---------|----------------------------------------------------------------|
| realm                                   | string  | Realm identifier/name                                          |
| emailAsUsername                         | boolean | Configure the realm to use email as username                   |
| registration                            | object  | Registration configuration container                           |
| registration.enabled                    | boolean | Enables user self-registration                                 |
| registration.termsAndConditions         | object  | Terms & Conditions configuration for registration              |
| registration.termsAndConditions.enabled | boolean | Enables Terms & Conditions during registration                 |
| authenticator                           | object  | Custom authenticator configuration                             |
| authenticator.enabled                   | boolean | Enables/disables SIMPL Keycloak Authenticator                  |
| test                                    | object  | Test configuration                                             |
| test.enabled                            | boolean | Enable test configuration                                      |
| eidas                                   | object  | eIDAS integration configuration                                |
| eidas.enabled                           | boolean | Enables eIDAS integration                                      |
| eidas.naturalPerson                     | object  | Natural person eIDAS configuration                             |
| eidas.naturalPerson.enabled             | boolean | Enables natural person eIDAS flow                              |
| eidas.legalPerson                       | object  | Legal person eIDAS configuration                               |
| eidas.legalPerson.enabled               | boolean | Enables legal person eIDAS flow                                |
| eidas.termsAndConditions                | object  | Terms & Conditions for eIDAS                                   |
| eidas.termsAndConditions.enabled        | boolean | Enables Terms & Conditions for eIDAS                           |
| roles                                   | array   | List of role definitions to be added as realm roles            |
| roles[].name                            | string  | Role name                                                      |
| roles[].description                     | string  | Role description                                               |
| roles[].default                         | boolean | Whether role is to be configured as default role for the realm |
| frontendClient                          | object  | Frontend client configuration                                  |
| frontendClient.enabled                  | boolean | Enables frontend client                                        |
| serviceAccount                          | object  | Service account configuration                                  |
| serviceAccount.enabled                  | boolean | Enables service account                                        |
| serviceAccount.clientId                 | string  | Client ID of the service account                               |
| serviceAccount.realmManagementRoles     | array   | Realm management roles assigned to service account             |
| serviceAccount.realmManagementRoles[]   | string  | Individual realm management role                               |

### `test.enabled`

The `test.enabled` property has the following effects:
* Enable direct access grant in frontend client