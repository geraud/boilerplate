module Boilerplate

class FormLayoutManager
  attr_reader :form_builder

  def initialize(builder, style)
    @form_builder = builder
    @layout_name = style
  end

  def method_missing(method_name, *args)
    options = args.extract_options!
    locals = default_locals(method_name, options).merge(
      :input_options => extract_input_options(options),
      :label_options => extract_label_options(options),
      :errors => extract_errors(options)
    )
    layout_element(locals)
  end

  def submit(title, *args)
    options = args.extract_options!.merge(:type => 'submit', :value => title)
    locals = default_locals('submit', options).merge(
      :input_options => extract_input_options(options),
      :label_options => nil,
      :errors => nil
    )
    layout_element(locals)
  end

  def base(*args)
    options = args.extract_options!.merge(:type => 'base')
    locals = default_locals('base', options).merge(
      :input_options => nil,
      :label_options => nil,
      :errors => extract_errors(options)
    )
    layout_element(locals)
  end

private

  def default_locals(method_name, options)
    type = (options[:type] || default_input_type(method_name)).to_sym
    return {
      :object_name => form_builder.object_name,
      :method_name => method_name,
      :form =>  form_builder,
      :input_type => type,
    }
  end

  def default_input_type(method, options = {})
    if column = column_for(method)
      # Special cases where the column type doesn't map to an input method.
      case column.type
      when :string
        return :password  if method.to_s =~ /password/
        return :country   if method.to_s =~ /country$/
        return :time_zone if method.to_s =~ /time_zone/
      when :integer
        return :select    if method.to_s =~ /_id$/
        return :numeric
      when :float, :decimal
        return :numeric
      when :timestamp
        return :datetime
      end

      # Try look for hints in options hash. Quite common senario: Enum keys stored as string in the database.
      return :select    if column.type == :string && options.key?(:collection)
      # Try 3: Assume the input name will be the same as the column type (e.g. string_input).
      return column.type
    else
      if builder_object
        return :select  if reflection_for(method)

        file = @object.send(method) if @object.respond_to?(method)
        return :file    if file && self.class.file_methods.any? { |m| file.respond_to?(m) }
      end

      return :select    if options.key?(:collection)
      return :password  if method.to_s =~ /password/
      return :string
    end
  end

  def column_for(method)
    obj = builder_object
    obj.column_for_attribute(method) if obj.respond_to?(:column_for_attribute)
  end

  def reflection_for(method) #:nodoc:
    obj = builder_object
    obj.class.reflect_on_association(method) if obj.class.respond_to?(:reflect_on_association)
  end

  def builder_object
    form_builder.object
  end

  def layout_element(locals)
    form_builder.template.render(:partial => "layouts/forms/#{@layout_name}", :locals => locals)
  end

  def extract_input_options(options)
    result = {}
    result[:value] = options.delete(:value)
    result[:style] = options.delete(:input_style)
    return result
  end

  def extract_label_options(options)
    result = {}
    result[:style] = options.delete(:label_style)
    return result
  end

  def extract_errors(options)
    return options.delete(:errors)
  end

end
end
