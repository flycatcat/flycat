# frozen_string_literal: true

class OrdersController < ApplicationController
  protect_from_forgery except: :create
  
  def new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
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
  end

  def order_params
    params.require(:order).permit(:username, :amount, :memo)
  end
end
