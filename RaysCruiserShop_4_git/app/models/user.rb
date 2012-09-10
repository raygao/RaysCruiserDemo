require Rails.root.join('lib','salesforce.rb')
require 'pp'
class User
  include Salesforce::Connector
  include Salesforce

  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable

  include Canable::Cans

  ## Database authenticatable
  field :email, :type => String, :default => ""
  field :encrypted_password, :type => String, :default => ""

  #index({ email: 1 }, { unique: true, name: "email_index" })
  #validates :email, uniqueness: true

  ## Recoverable
  field :reset_password_token, :type => String
  field :reset_password_sent_at, :type => Time

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
  field :sign_in_count, :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at, :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip, :type => String

  ## Encryptable
  # field :password_salt, :type => String

  ## Confirmable
  # field :confirmation_token,   :type => String
  # field :confirmed_at,         :type => Time
  # field :confirmation_sent_at, :type => Time
  # field :unconfirmed_email,    :type => String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, :type => Integer, :default => 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    :type => String # Only if unlock strategy is :email or :both
  # field :locked_at,       :type => Time

  ## Token authenticatable
  # field :authentication_token, :type => String

  ####################################################
  field :first_name, type: String
  field :last_name, type: String
  field :business_name, type: String
  field :user_role_id, type: String
  field :phone, type: String
  field :address, type: String
  field :city, type: String
  field :state, type: String
  field :zip, type: String
  field :sf_lead_id, type: String

  field :show_home_page, type: Boolean

  validates_presence_of :first_name, :last_name, :business_name, :zip

  belongs_to :user_role, :class_name => "Urole", :foreign_key => "user_role_id"

  has_many :orders, :class_name => "Order", :dependent => :destroy, :autosave => true, :foreign_key => "owner_id"
  has_many :order_items, :class_name => "OrderItem", :dependent => :destroy, :autosave => true

  #   after_create  :send_welcome_mail

  before_save do
    #Save a lead object in the Salesforce
    if (self.new_record?)
      @client = self.dbdc_client
      @client.sobject_module = Salesforce


      newlead = Salesforce::Lead.new()
      newlead.OwnerId = @client.user_id
      newlead.FirstName = self.first_name
      newlead.LastName = self.last_name
      newlead.Street = self.address
      newlead.Company = self.business_name
      newlead.Email = self.email
      newlead.City = self.city
      newlead.State = self.state
      newlead.PostalCode = self.zip
      newlead.Phone = self.phone
      newlead.IsConverted = false
      newlead.IsDeleted = false
      newlead.IsUnreadByOwner = false

      newlead.save()
      self.sf_lead_id = newlead.Id

      #follow this new Order with Chatter
      me = Databasedotcom::Chatter::User.find(@client, 'me')
      me.follow(newlead.Id)
      # Announce it on Chatter
      Databasedotcom::Chatter::RecordFeed.post(@client, newlead.Id, :text=> 'New Lead created.')

      # Send welcome email. Previously, putting it in the after_save() caused problem - redundant email on each login.
      # Mongoid always call that hook, regards if it's new or existing record.
      send_welcome_mail
    end

    set_urole()
  end

  #send welcome mail after User has been created.
  after_save do
    # Moved to before_save method. It was causing redundant email on each login.
  end

  private
  def send_welcome_mail
    UserMailer.welcome_email(self).deliver
  end

  # Set User Profile. If none is set, this will be a 'regular' user.
  def set_urole
    begin
      #@client.sobject_module = Salesforce   #Using Salesforce Name, to avoid collision with my 'Order' Object in MongoDB.
      if self.user_role.nil?
        #self.user_role = UserRole.where(name: "regular").first
        self.user_role_id = Urole.where(name: "regular").first.id
        logger.info "Setting this user '#{self.email}' to use 'regular' role @ #{Time.now}."
      else
        logger.info "User '#{self.email}' is using '#{self.user_role.name}' role @ #{Time.now}."
      end
    rescue Exception => e
      logger.info 'Your DB has not been seeded. Please seed it first. '  + e.message
    end
  end

end