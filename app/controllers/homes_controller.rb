class HomesController < ApplicationController

	def show
		# http://localhost:3000/homes?t=31-24-25-23
		#ids = params[:t].split('-')
		#@prop_display = PropDisplay.find_by_id_and_sender_id_and_receiver_id_and_admin_user_id(ids[0], ids[1], ids[2], ids[3])
	end

end
