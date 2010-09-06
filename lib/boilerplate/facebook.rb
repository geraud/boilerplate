module Boilerplate
  module Facebook

  protected

    def setup_rest_graph
      @rest_graph = RestGraph.new
      @rest_graph.parse_cookies!(cookies)
    end

    def facebook_app_id
      #  $stderr.puts "getting #{@rest_graph.inspect} #{@rest_graph.app_id}"
      @rest_graph.app_id
    end

    def find_or_create_facebook_user
      me = @rest_graph.get('me')
      return nil unless me

      user = User.find_by_facebook_id(me['id']) || User.find_or_initialize_by_email(me['email'])
      attributes = { :facebook_access_token => @rest_graph.access_token }
      if user.new_record?
        attributes.merge!(
          :first_name => me['first_name'],
          :last_name => me['last_name'],
          :gender => me['gender'] || 'female',
          :facebook_id => me['id']
        )
      else
        # update attributes?
      end
      user.update_attributes!(attributes)
      return user
    end

    def self.included(application_controller)
      application_controller.module_eval do
        before_filter :setup_rest_graph
        helper_method :facebook_app_id
      end
    end

  end
end
