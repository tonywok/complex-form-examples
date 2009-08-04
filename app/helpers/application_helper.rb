# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def add_child_link(name, f, method)
    fields = new_child_fields(f, method)
    js = "insert_fields(this, \"#{method}\", \"#{escape_javascript(fields)}\")"
    "<a href=\"#\" onclick=\"#{h(js)}\">#{name}</a>"
    #link_to_function(name, "insert_fields(\"#{method}\", \"#{escape_javascript(h(fields))}\");")
  end
  
  def new_child_fields(form_builder, method, options = {})
    options[:object] ||= form_builder.object.class.reflect_on_association(method).klass.new
    options[:partial] ||= method.to_s.singularize
    options[:form_builder_local] ||= :f
    form_builder.fields_for(method, options[:object], :child_index => "new_#{method}") do |f|
      render(:partial => options[:partial], :locals => { options[:form_builder_local] => f })
    end
  end
end
