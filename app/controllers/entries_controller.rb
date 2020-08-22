class EntriesController < ApplicationController

	def create
		entry = current_user.entries.build(event_id: params[:event_id])
		entry.save!
		entry.create_notification_entry(current_user)
		redirect_to request.referer
	end

	def destroy
		current_user.entries.find_by(event_id: params[:event_id]).destroy!
		redirect_to request.referer
	end
end
