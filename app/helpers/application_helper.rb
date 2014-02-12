module ApplicationHelper

	def display_string(value)
		return "" unless value
		raw(simple_format(
			value.html_safe.gsub(/((http|https):\/\/(\S)+|www[.]\S+[.]\S+)/) do |e|
				link_to e, ("http://" unless e.starts_with?("http")).to_s + e
			end
		))
	end

	def icon type, space=true
		content_tag(:i, (space ? " " : ""), class: "icon icon-#{type}")
	end

end
