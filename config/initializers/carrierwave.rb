require 'carrierwave/storage/fog'
#Excon.defaults[:write_timeout] = 1000
#  Excon.defaults = Excon.defaults.mere(:write_timeout => 10.minutes.to_i)

if Rails.env.development? || Rails.env.test?
  CarrierWave.configure do |config|
    config.fog_provider = 'fog/aws'
    config.storage = :file
#    config.storage = :fog
#    config.root = "#{Rails.root}/tmp"
#    config.cache_dir = "#{Rails.root}/tmp/images"
      config.fog_credentials = { 
      :provider               => 'AWS',
      :aws_access_key_id      => AWS_KEY,
      :aws_secret_access_key  => AWS_SECRET_KEY, 
      :persistent             => false,
      :region             => 'us-east-1'
    }
    config.permissions = 0777
    config.fog_directory  = 'authorprofile'
    config.fog_public     = true
#    config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}
  end
end
  
if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      :provider               => 'AWS',
      :aws_access_key_id      => ENV['AWS_KEY'],    
      :aws_secret_access_key  => ENV['AWS_SECRET_KEY'],  
      :persistent             => false,
#      :connect_timeout=>60
      :region             => 'us-east-1'
    }
    config.storage = :fog
    config.permissions = 0777
    config.fog_directory  = 'authorprofile'
    config.fog_public     = true
    config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}
#    config.fog_host     = 'https://authorprofile.s3.amazonaws.com'
  end
end
