class Account < ActiveRecord::Base
  def self.get_saml_settings(url_base)
    # this is just for testing purposes.
    # should retrieve SAML-settings based on subdomain, IP-address, NameID or similar
    idp_metadata_parser = OneLogin::RubySaml::IdpMetadataParser.new
    # settings = idp_metadata_parser.parse_remote("https://app.onelogin.com/saml/metadata/590593")
    settings = idp_metadata_parser.parse_remote("https://dev-273206.oktapreview.com/app/exk8bhuwt4gxPA65Z0h7/sso/saml/metadata")
    # settings = idp_metadata_parser.parse_remote("https://login.windows.net/82d1d663-c551-4c69-9731-bf8530732b08/FederationMetadata/2007-06/FederationMetadata.xml")
    url_base ||= "http://localhost:3000"

    # Example settings data, replace this values!

    # When disabled, saml validation errors will raise an exception.
    settings.soft = true


    #SP section
    settings.issuer                         = url_base + "/saml/metadata"
    settings.assertion_consumer_service_url = url_base + "/saml/acs"
    settings.assertion_consumer_logout_service_url = url_base + "/saml/logout"

    # IdP section

    # or settings.idp_cert_fingerprint           = "3B:05:BE:0A:EC:84:CC:D4:75:97:B3:A2:22:AC:56:21:44:EF:59:E6"
    #    settings.idp_cert_fingerprint_algorithm = XMLSecurity::Document::SHA1

    settings.name_identifier_format         = "urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress"

    # Security section
    settings.security[:authn_requests_signed] = false
    settings.security[:logout_requests_signed] = false
    settings.security[:logout_responses_signed] = false
    settings.security[:metadata_signed] = false
    settings.security[:digest_method] = XMLSecurity::Document::SHA1
    settings.security[:signature_method] = XMLSecurity::Document::RSA_SHA1

    settings
  end
end
