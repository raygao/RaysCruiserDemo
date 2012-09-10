require 'pp'
require Rails.root.join('lib','salesforce.rb')

class ApplicationController < ActionController::Base
  protect_from_forgery
  include Salesforce::Connector
  include Salesforce

  before_filter :authenticate_user!, :except => 'front_door'

  include Canable::Enforcers
  helper_method :can_view?, :can_create?, :can_update?, :can_destroy?

  # Sign out and redirect user to sign in page.
  def signin
    sign_out
    redirect_to '/users/sign_in'
  end

  # Sign out and redirect user to sign up page.#
  def signup
    sign_out
    puts '----signup called.----'
    redirect_to '/users/sign_up'
  end

  # See Canable on github
  private :enforce_view_permission, :enforce_update_permission, :enforce_create_permission, :enforce_destroy_permission
  def enforce_view_permission(resource)
    raise Canable::Transgression unless can_view?(resource)
  end

  def enforce_update_permission(resource)
    raise Canable::Transgression unless can_update?(resource)
  end

  def enforce_destroy_permission(resource)    raise Canable::Transgression unless can_destroy?(resource)
  end

  def enforce_create_permission(resource)
    raise Canable::Transgression unless can_create?(resource)
  end

  def sfdcauth
    @client = self.dbdc_client

    #old way without the library, see Rails.root."/lib/salesforce.rb"
    #client = Databasedotcom::Client.new("config/databasedotcom.yml")
    #client.verify_mode = OpenSSL::SSL::VERIFY_NONE
    #client.sobject_module = Salesforce   #Using Salesforce Name, to avoid collision with my 'Order' Object in MongoDB.
    #ENV['access_token'] = client.authenticate :username => ENV['sfdc_username'], :password => ENV['sfdc_password']
    #puts "<html><body><b>New access token from salesforce. Saved to session.</b><br>"+ENV['access_token']+"UserID: #{client.user_id}</body></html>"
    #return client
  end

  def post_to_chatter (client, sobject, message)
    Databasedotcom::Chatter::RecordFeed.post(client, sobject.Id, :text=> message)
  end

end
