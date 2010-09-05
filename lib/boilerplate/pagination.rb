module Boilerplate
  module Pagination

  protected

    def page(name = :page)
      page = params[name.to_sym].to_i rescue nil
      return page && page > 0 ? page : nil
    end

    def self.included(application_controller)
      application_controller.class_eval do
        helper_method :page
      end
    end

  end
end
