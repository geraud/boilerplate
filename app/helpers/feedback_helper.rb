module FeedbackHelper

  def show_feedback
    page.js_call 'App.util.feedback.hideAll'
    page.js_call 'App.util.feedback.show', @context.flash[:feedback].map { |f| f.to_s.tr('.', '_') }
  end

  def feedback(kind, namespace, field, *elements)
    capture_haml do
      process_feedback(kind, namespace, field, elements) do |feedback_kind, feedback_element_id, feedback_text|
        haml_tag :div, :class => %W(feedback #{kind} hidden), :id => element_id do
          haml_concat(feedback_text)
        end
      end
    end
  end

  def process_feedback(kind, namespace, field, elements, &block)
    process_hash_feedaback(kind, namespace, field, elements.extract_options!, &block)
    process_simple_feedback(kind, namespace, field, elements, &block)
  end

protected

  def process_feedback(kind, namespace, field, elements, &block)
    process_hash_feedaback(kind, namespace, field, elements.extract_options!, &block)
    process_simple_feedback(kind, namespace, field, elements, &block)
  end

  def process_hash_feedaback(kind, namespace, field, hash_feedback, &block)
    hash_feedback.each do |element, value|
      case value
      when Array
        value = t(*value) if value.is_a? Array
      when Hash
        value = t(translation_key(namespace, field, kind, element), value)
      end
      block.call(kind, feedback_id(kind, namespace, field, element), value)
    end
  end

  def process_simple_feedback(kind, namespace, field, elements, &block)
    elements.flatten.each do |element|
      value = t(translation_key(namespace, field, kind, element))
      block.call(kind, feedback_id(kind, namespace, field, element), value)
    end
  end

  def translation_key(*args)
    return args.map(&:to_s).join('.')
  end

  def feedback_id(*fragments)
    return fragments.compact.map(&:to_s).join('_').squeeze('_')
  end

end
