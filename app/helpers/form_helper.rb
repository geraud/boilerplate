module FormHelper

  def build_fields_for(record_or_name_or_array, *args, &block)
    options = args.extract_options!
    options[:builder] = Boilerplate::FormBuilder
    layout_style = (options.delete(:layout_style) || :default).to_sym
    fields_for(record_or_name_or_array, *(args << options)) do |form_builder|
      block.call(Boilerplate::FormLayoutManager.new(form_builder, layout_style))
    end
  end

  def build_form_for(*args, &block)
    options = args.extract_options!
    options[:builder] = Boilerplate::FormBuilder
    options[:builder_sytle] = (options.delete(:layout_style) || :default).to_sym
    return build_fields_for(*(args << options), &block)
  end

end
