# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def remove_child_link(name, f)
    f.hidden_field(:_delete) + "<a href=\"javascript:void(0)\" class=\"remove_child\">#{name}</a>"
  end
  
  def add_child_link(name, association)
    "<a href=\"javascript:void(0)\" class=\"add_child\" data-association=\"#{association.to_s}\">#{name}</a>"
  end
  
  def new_child_fields_template(form_builder, association, options = {})
    options[:object] ||= form_builder.object.class.reflect_on_association(association).klass.new
    options[:partial] ||= association.to_s.singularize
    options[:form_builder_local] ||= :f
    
    ret = "<div id=\"#{association}_fields_template\" style=\"display: none\">"
    form_builder.fields_for(association, options[:object], :child_index => "new_#{association}") do |f|
      ret += render(:partial => options[:partial], :locals => {options[:form_builder_local] => f})
    end
    ret += "</div>"
    ret
  end
end