module Salesforce
  # This is used to hold Salesforce materilized objects

  module Connector
    module ClassMethods
      def dbdc_client
        unless @dbdc_client
          config_file = Rails.root.join('config','databasedotcom.yml')
          @dbdc_client = Databasedotcom::Client.new(config_file.to_s)
          @dbdc_client.verify_mode = OpenSSL::SSL::VERIFY_NONE
          @dbdc_client.sobject_module = Salesforce   #Using Salesforce Name, to avoid collision with my 'Order' Object in MongoDB.
          ENV['access_token'] = @dbdc_client.authenticate :username => ENV['sfdc_username'], :password => ENV['sfdc_password']
          puts "<html><body><b>New access token from salesforce. Saved to session.</b><br>"+ENV['access_token']+"UserID: #{@dbdc_client.user_id}</body></html>"

          @dbdc_client.materialize('Cruiser_Order__c')
          @dbdc_client.materialize('Lead')
          @dbdc_client.materialize('Lead')
        end

        @dbdc_client
      end

      def dbdc_client=(client)
        @dbdc_client = client
      end

      def sobject_types
        unless @sobject_types
          @sobject_types = dbdc_client.list_sobjects
        end

        @sobject_types
      end

      def const_missing(sym)
        if sobject_types.include?(sym.to_s)
          dbdc_client.materialize(sym.to_s)
        else
          super
        end
      end
    end

    module InstanceMethods
      def dbdc_client
        self.class.dbdc_client
      end

      def sobject_types
        self.class.sobject_types
      end
    end

    def self.included(base)
      base.send(:include, InstanceMethods)
      base.send(:extend, ClassMethods)
    end
  end
end


