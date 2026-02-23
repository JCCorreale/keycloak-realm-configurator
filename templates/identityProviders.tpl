{{- if .eidas.naturalPerson.enabled }}
- alias: eidas-demo-natural-person
  providerId: eidas-demo-natural-person
  displayName: eIDAS Demo Natural Person
  enabled: true
  config:
    clientId: eidas-client
    clientSecret: eidas-client-secret
    specificConnectorUrl: http://eidas-demo-node.dev.simpl-europe.eu:8080/SpecificConnector/ServiceProvider
    serviceProviderCountryOfOrigin: CA
    levelOfAssurance: A
    comparisonOfLoa: Minimum
    providerType: Public
    mandatoryAttributes: Current Family Name (Natural Person)##Current First Names (Natural Person)##Date of Birth (Natural Person)##Unique Identifier (Natural Person)
    optionalAttributes:
    availableCountries: CA - Country A##CB - Country B##CC - Country C##DE - Germany##FR - France##IT - Italy
{{- end }}
{{- if .eidas.legalPerson.enabled }}
- alias: eidas-demo-legal-person
  providerId: eidas-demo-legal-person
  displayName: eIDAS Demo Legal Person
  enabled: true
  config:
    clientId: eidas-client
    clientSecret: eidas-client-secret
    specificConnectorUrl: http://eidas-demo-node.dev.simpl-europe.eu:8080/SpecificConnector/ServiceProvider
    serviceProviderCountryOfOrigin: CA
    levelOfAssurance: A
    comparisonOfLoa: Minimum
    providerType: Public
    mandatoryAttributes: Current Legal Name (Legal Person)##Legal Email Address (Legal Person)##Legal Person Identifier (Legal Person)
    optionalAttributes:
    availableCountries: CA - Country A##CB - Country B##CC - Country C##DE - Germany##FR - France##IT - Italy
{{- end }}