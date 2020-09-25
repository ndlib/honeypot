Raven.configure do |config|
  # Don't clog up Sentry with stuff from test and dev
  if !Rails.env.test? && !Rails.env.development?
    config.dsn = 'https://53ab81f68bd44933913cbd2a8a67d4bd@o164480.ingest.sentry.io/5441728'
  end

  config.sanitize_fields = Rails.application.config.filter_parameters.map(&:to_s)
end