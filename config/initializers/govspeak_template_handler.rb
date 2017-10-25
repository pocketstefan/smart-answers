require 'govspeak'

module GovspeakTemplateHandler
  def self.erb
    @erb ||= ActionView::Template.registered_template_handler(:erb)
  end

  def self.call(template)
    compiled_source = erb.call(template)

    "Govspeak::Document.new(begin;#{compiled_source};end).to_html.html_safe"
  end
end

ActionView::Template.register_template_handler :govspeak, GovspeakTemplateHandler
