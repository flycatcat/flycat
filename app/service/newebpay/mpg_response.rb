# frozen_string_literal: true

module Newebpay
  class MpgResponse
    attr_reader :status, :message, :result, :order_no, :trans_no, :newebpay_amt, :card_last_4_no, :pay_at, :pay_type

    def initialize(params)
      @key = ENV.fetch('hash_key', nil)
      @iv = ENV.fetch('hash_iv', nil)
      response = decrypy(params)
      @status = response['Status']
      @message = response['Message']
      @result = response['Result']
      @order_no = @result['MerchantOrderNo']
      @trans_no = @result['TradeNo']
      @newebpay_amt = @result['Amt']
      @card_last_4_no = @result['Card4No']
      @pay_at = @result['PayTime']
      @pay_type = @result['PaymentType']
    end

    def success?
      status === 'SUCCESS'
    end

    private

    def decrypy(encrypted_data)
      encrypted_data = [encrypted_data].pack('H*')
      decipher = OpenSSL::Cipher.new('aes-256-cbc')
      decipher.decrypt
      decipher.padding = 0
      decipher.key = @key
      decipher.iv = @iv
      data = decipher.update(encrypted_data) + decipher.final
      raw_data = strippadding(data)
      JSON.parse(raw_data)
    end

    def strippadding(data)
      slast = data[-1].ord
      slastc = slast.chr
      string_match = /#{slastc}{#{slast}}/ =~ data
      if string_match.nil?
        false
      else
        data[0, string_match]
      end
    end
  end
end
