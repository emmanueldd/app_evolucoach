CarrierWave.configure do |config| # Bien penser à rendre le bucket public
  config.storage    = :aws
  config.aws_bucket = 'evolucoach-app'
  # config.aws_bucket = ENV.fetch('S3_BUCKET_NAME')
  config.aws_acl    = 'public-read'
  config.aws_authenticated_url_expiration = 60 * 60 * 24 * 7
  config.aws_credentials = {
    access_key_id:     'AKIAJ3NGPYRQY75BOJUQ',
    # access_key_id:     ENV.fetch('AWS_ACCESS_KEY_ID'),
    secret_access_key: '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',
    # secret_access_key: ENV.fetch('AWS_SECRET_ACCESS_KEY'),
    region:            'eu-west-3' # Required
    # region:            ENV.fetch('AWS_REGION') # Required
  }
end



# FRESH-MCA = Hébeger les images sur cloudflare

# CarrierWave.configure do |config|
#   # config.fog_provider = 'fog/aws'
#   config.fog_credentials = {
#     :provider               => 'AWS',
#     :aws_access_key_id      => ENV["AWS_ACCESS_KEY"],
#     :aws_secret_access_key  => ENV["AWS_SECRET_KEY"],
#     :region                 => 'eu-central-1'
#   }
#   # For testing, upload files to local `tmp` folder.
#   if Rails.env.test? || Rails.env.cucumber?
#     config.storage = :file
#     config.enable_processing = false
#     config.root = "#{Rails.root}/tmp"
#   else
#     config.storage = :fog
#   end
#   config.storage = :fog
#   config.fog_directory = ENV["AWS_BUCKET"]
#   config.cache_dir = "#{Rails.root}/tmp/uploads"
#   config.asset_host = 'https://files.macoiffeuseafro.com'
# end
