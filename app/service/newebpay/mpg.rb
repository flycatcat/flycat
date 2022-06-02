# frozen_string_literal: true

module Newebpay
  class Mpg
    attr_accessor :info

    def initialize(order)
      @key = ENV.fetch('hash_key', nil)
      @iv = ENV.fetch('hash_iv', nil)
      @merchant_id = ENV.fetch('merchant_id', nil)
      @info = {}
      @flycatOrderNo = order.order_no
      @amount = order.amount
      @order = order
      set_info
    end

    def form_info
      {
        MerchantID: @merchant_id,
        TradeInfo: trade_info,
        TradeSha: trade_sha,
        Version: '2.0'
      }
    end

    private

    def trade_info
      aes_encode(url_encoded_query_string)
    end

    def trade_sha
      sha256_encode(@key, @iv, trade_info)
    end

    def set_info
      info[:MerchantID] = @merchant_id
      info[:MerchantOrderNo] = @flycatOrderNo
      info[:Amt] = "500"
      info[:ItemDesc] = 'Flycat'
      info[:Email] = ''
      info[:TimeStamp] = Time.now.to_i
      info[:RespondType] = 'JSON'
      info[:Version] = '2.0'
      info[:ReturnURL] = "#{ENV.fetch('ReturnURL', '')}/orders/#{@order.company_id}/confirm"
      info[:NotifyURL] = ENV.fetch('NotifyURL', "")
      info[:LoginType] = 0
      info[:CREDIT] =  1
      info[:VACC] = 1
    end

    def url_encoded_query_string
      URI.encode_www_form(info)
    end

    def aes_encode(string)
      cipher = OpenSSL::Cipher.new('aes-256-cbc')
      cipher.encrypt
      cipher.key = @key
      cipher.iv = @iv
      cipher.padding = 0
      padding_data = add_padding(string)
      encrypted = cipher.update(padding_data) + cipher.final
      encrypted.unpack1('H*')
    end

    def add_padding(data, block_size = 32)
      pad = block_size - (data.length % block_size)
      data + (pad.chr * pad)
    end

    # SHA加密
    def sha256_encode(key, iv, trade_info)
      encode_string = "HashKey=#{key}&#{trade_info}&HashIV=#{iv}"
      Digest::SHA256.hexdigest(encode_string).upcase
    end
  end
end
