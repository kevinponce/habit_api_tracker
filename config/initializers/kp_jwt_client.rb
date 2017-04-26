# frozen_string_literal: true

# Use this hook to configure KpJwtClient
KpJwtClient.setup do |config|
  # Signature key
  config.token_secret_signature_key = -> { '908bec067ad8d4dce230e76858ce9113f13f64f50d6b09c1065f29561b81b730375900b5ec8f0fdd073151bed136e1aa1c6bace5bfb0654a576f215d653b2c53' }
end
