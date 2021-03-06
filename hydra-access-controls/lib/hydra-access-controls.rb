require 'rails'
require 'active-fedora'
require 'blacklight'
require 'cancan'

module Hydra
  extend ActiveSupport::Autoload
  autoload :AccessControls
  autoload :User
  autoload :AccessControlsEnforcement
  autoload :PolicyAwareAccessControlsEnforcement
  autoload :Ability
  autoload :Config
  autoload :Datastream
  autoload :PolicyAwareAbility
  autoload :AdminPolicy
  autoload :RoleMapperBehavior
  autoload :PermissionsQuery
  autoload :PermissionsCache
  autoload :PermissionsSolrDocument

  class << self
    def configure(_ = nil)
      @config ||= Config.new
      yield @config if block_given?
      @config
    end
    alias :config :configure
  end

  class Engine < Rails::Engine
    # autoload_paths is only necessary for Rails 3
    config.autoload_paths += %W(
      #{config.root}/app/models/concerns
    )
  end

  # This error is raised when a user isn't allowed to access a given controller action.
  # This usually happens within a call to AccessControlsEnforcement#enforce_access_controls but can be
  # raised manually.
  class AccessDenied < ::CanCan::AccessDenied; end
end
