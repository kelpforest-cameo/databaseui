module CitationsHelper
	def authorcitations()
		@aut = content_tag 'script', :type => "text/javascript" do
			"value = ($('#author_cites_author_id').val());".html_safe
		@authorArray.push(@aut)
		end
	end
end
