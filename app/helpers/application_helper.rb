module ApplicationHelper

	def link(text, target, attributes = {})
  attributes['data-remote'] = true
  super
end

end
