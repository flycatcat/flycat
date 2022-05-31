class Api::V1::BulletinsController < ApplicationController
  def read
    bulletin = Bulletin.find(params[:id])
    message = 'no action'

    unless current_user.read_bulletins.exists?(bulletin.id)
      current_user.read_bulletins << bulletin
      current_user.bulletin_reads.update(is_read: true)
      count = bulletin.bulletin_reads.where(is_read: true).size
      message = 'added'
    end

    render json: { message: message, count: count }
  end

  def unread
    bulletin = Bulletin.find(params[:id])
    message = 'no action'

    if current_user.read_bulletins.exists?(bulletin.id)
      current_user.read_bulletins.destroy(bulletin)
      count = bulletin.bulletin_reads.where(is_read: true).size
      message = 'removed'
    end

    render json: { message: message, count: count }
  end
end
