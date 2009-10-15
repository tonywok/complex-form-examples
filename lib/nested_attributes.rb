class NestedAttributes
  def initialize(attrs)
    @attrs = attrs
  end
  
  def all_blank?
    blank = true
    @attrs.keys.select { |k| !k.match(/_attributes$/) }.each do |key|
      blank = false if !@attrs[key].blank?
    end
    blank
  end
end