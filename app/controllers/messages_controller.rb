class MessagesController < ApplicationController
  def index
    @room = Room.find(params[:room_id])
    @message = Message.new
    @messages = @room.messages.includes(:user)
  end

  def create
    @room = Room.find(params[:room_id])
    @message = @room.messages.new(message_params)
    if @message.save
      helpers = Rails.application.routes.url_helpers
      ActionCable.server.broadcast "message_channel", content: {
        id: @message.id,
        content: @message.content,
        user_name: @message.user.name,
        created_at: I18n.l(@message.created_at),
        image: @message.image.attached? ? helpers.rails_representation_url(@message.image.variant(resize: '500x500'), only_path: true) : nil,
        file: @message.file.attached? ? helpers.rails_blob_path(@message.file, only_path: true) : nil,      
      }
      # redirect_to room_messages_path(@room)
    else
      @messages = @room.messages.includes(:user)
      render :index
    end
  end

  private

  def message_params
    params.require(:message).permit(:content, :image, :file).merge(user_id: current_user.id)
  end
end
