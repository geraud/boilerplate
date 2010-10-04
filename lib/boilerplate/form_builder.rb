module Boilerplate

class FormBuilder < ActionView::Helpers::FormBuilder
  attr_reader :template
  attr_reader :object_name
  attr_reader :object
end
end
