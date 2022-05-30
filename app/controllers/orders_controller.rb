# frozen_string_literal: true

class OrdersController < ApplicationController
  skip_before_action :verify_authenticity_token, except: :create

  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_combine_id)
    if @order.save
      @form_info = Newebpay::Mpg.new(@order).form_info
    else
      render :new
    end
  end

  def confirm
    @response = Newebpay::MpgResponse.new(params[:TradeInfo])
    order = Order.find_by(order_no: @response.order_no)
    order.update(
      transaction_no: @response.trans_no,
      newebpay_amt: @response.newebpay_amt,
      pay_at: @response.pay_at,
      status: @response.status,
      card_last_4_no: @response.card_last_4_no,
      pay_type: @response.pay_type
    )
    @username = order.username

    redirect_to success_order_path(order)
  end

  def success
    @order = Order.find(params[:id])
  end

  private


  def order_params
    params.require(:order).permit(:username, :amount, :memo)
  end

  def order_combine_id
    order_params.merge(user_id: current_user.id)
  end

end
