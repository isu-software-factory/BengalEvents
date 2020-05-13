# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')
Rails.application.config.assets.precompile += %w( sessions )
Rails.application.config.assets.precompile += %w( registrations.js )
Rails.application.config.assets.precompile += %w( students.js )
Rails.application.config.assets.precompile += %w( sponsors.js )
Rails.application.config.assets.precompile += %w( teams.js )
Rails.application.config.assets.precompile += %w( homeroutes.js )
Rails.application.config.assets.precompile += %w( events.js )
Rails.application.config.assets.precompile += %w( activities.js )
Rails.application.config.assets.precompile += %w( coordinators.js )
Rails.application.config.assets.precompile += %w( setups.js)

# Allow overriding of the sprockets cache path
Rails.application.config.assets.configure do |env|
  env.cache = Sprockets::Cache::FileStore.new(
      ENV.fetch("SPROCKETS_CACHE", "#{env.root}/tmp/cache/assets"),
      Rails.application.config.assets.cache_limit,
      env.logger
  )
end

# Precompile additional assets.
# application.js, application.scss, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w( admins.js admins.css)
Rails.application.config.assets.precompile += %w(custom.scss.erb)
