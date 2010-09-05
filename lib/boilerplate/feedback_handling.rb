module Boilerplate
  module FeedbackHandling

  protected

    def add_error(*fragments)
      return add_feedback('error', *fragments)
    end

    def remove_error(*fragments)
      return remove_feedback('error', *fragments)
    end

    def has_error?(*fragments)
      return has_feedback?('error', *fragments)
    end

    def prioritize_errors(*args)
      return prioritize_feedback('error', *args)
    end

    def add_notice(*fragments)
      return add_feedback('notice', *fragments)
    end

    def remove_notice(*fragments)
      return remove_feedback('notice', *fragments)
    end

    def has_notice?(*fragments)
      return has_feedback?('notice', *fragments)
    end

    def prioritize_notices(*args)
      return prioritize_feedback('notice', *args)
    end

  private

    def add_feedback(*fragments)
      feedback = []

      fragments.each do|f|
        if f.respond_to? :errors
          f.errors.each do |attribute, message|
            feedback_store << make_key(feedback + [attribute, message])
          end
          return nil
        else
          feedback << f
        end
      end
      feedback_store << make_key(fragments)
      return nil
    end

    def remove_feedback(*fragments)
      key = make_key(fragments)
      feedback_store.delete_if { |item| item.starts_with?(key) }
      return nil
    end

    def has_feedback?(*fragments)
      key = make_key(fragments)
      feedback_store.each do |entry|
        return true if entry.starts_with?(key)
      end
      return false
    end

    def prioritize_feedback(*fragments)
      options = fragments.extract_options!
      base_key = make_key(fragments)

      entries_to_remove = []
      options.each do |key, value|
        previous_priority = []
        value.reverse.each do |priority_group|
          priority_group = [priority_group].flatten.map { |p| make_key(base_key, key, p) }
          common_entries = feedback_store & priority_group
          if !common_entries.empty?
            entries_to_remove << previous_priority
            previous_priority = common_entries.to_a
          end
        end
      end
      feedback_store.subtract(entries_to_remove.flatten)
    end

    def make_key(*fragments)
      return fragments.flatten.map { |f|  f.to_s.downcase.strip }.join('.')
    end

    def feedback_store
      return flash[:feedback] ||= Set.new
    end

    def self.included(action_controller)
      action_controller.class_eval do
        helper_method :prioritize_errors
        helper_method :has_errors?
        helper_method :prioritize_notices
        helper_method :has_notices?
      end
    end

  end
end
