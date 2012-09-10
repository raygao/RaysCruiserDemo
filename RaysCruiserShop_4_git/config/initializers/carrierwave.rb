
CarrierWave.configure do |config|
  config.permissions = 0666
  config.storage = :fog

  config.fog_credentials = {
      :provider => 'AWS', # required
      :aws_access_key_id => SiteConfig[:aws][:key], # required
      :aws_secret_access_key => SiteConfig[:aws][:secret], # required
      :region => 'us-east-1' # optional, defaults to 'us-east-1'
  }

  #config.fog_host = "http://localhost:3000" # optional, defaults to nil
  # config.fog_public = false # optional, defaults to true
  config.fog_attributes = {'Cache-Control' => 'max-age=315576000'} # optional, defaults to {}
end

if Rails.env.test? or Rails.env.cucumber?
  CarrierWave.configure do |config|
    config.fog_directory = 'rays-cruiser' # name of the bucket on S3
    #config.storage = :file       # in the test mode, save to local file system.
    #config.enable_processing = false
  end

elsif Rails.env.deveopment?
  CarrierWave.configure do |config|
    config.fog_directory = 'rays-cruiser' # name of the bucket on S3
  end

else
  CarrierWave.configure do |config|
    config.fog_directory = 'rays-cruiser' # name of the bucket on S3
  end

end
