class RelationshipsController < ApplicationController

  def create
    followed_user = User.find(params[:user_id])
    relationship = current_user.follower.new(followed_id: followed_user.id)
    relationship.save
    # binding.pry
    redirect_to request.referer
  end

  def destroy
    followed_user = User.find(params[:user_id])
    relationship = current_user.follower.find_by(followed_id: followed_user.id)
    relationship.destroy
    redirect_to request.referer
  end

end
