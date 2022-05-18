module Newebpay
  class Mpg
    attr_accessor :info

    def initialize
			# 建議 hash key / iv & merchant id 都使用環境變數
      @key = ENV['hash_key']
      @iv = ENV['hash_iv']
      @merchant_id = ENV['merchant_id']
      @info = {}  # 使用 attr_accessor 讓 info 方便存取
      set_info
    end

    
    def form_info
      {
        MerchantID: @merchant_id,
        TradeInfo: trade_info,
        TradeSha: trade_sha,
        Version: "2.0"
      }
    end

    private
    # AES256加密後資訊
    def trade_info
      aes_encode(url_encoded_query_string)
    end
    # SHA加密後資訊
    def trade_sha
      sha256_encode(@key, @iv, trade_info)
    end

    def set_info
      order = Order.last
      info[:MerchantID] = @merchant_id
      info[:MerchantOrderNo] = flycatOrderNo
      info[:Amt] = order.amount
      info[:ItemDesc] = "Flycat"
      info[:Email] = ''
      info[:TimeStamp] = Time.now.to_i
      info[:RespondType] = "JSON"
      info[:Version] = "2.0"
			# url 也建議使用環境變數
      info[:ReturnURL] = ENV['ReturnURL'] 
      info[:NotifyURL] = "https://...."
      info[:LoginType] = 0
      info[:CREDIT] =  1,
      info[:VACC] = 1
    end

    
    # 將商品編號設置年月日時分星期+亂碼7位數
    def flycatOrderNo
      flycat = "flycat#{Time.current.strftime("%Y%m%d%H%M%w")}"
      random = [*'a'..'z', *'A'..'Z', *'0'..'9']
      return flycat + random.sample(7).join
    end
    # 將加密後的內容轉為query string
    def url_encoded_query_string
      URI.encode_www_form(info)
    end

    def aes_encode(string)
      cipher = OpenSSL::Cipher::AES256.new(:CBC)
      cipher.encrypt
      cipher.key = @key
      cipher.iv = @iv
      cipher.padding = 0
      padding_data = add_padding(string)
      encrypted = cipher.update(padding_data) + cipher.final
      encrypted.unpack('H*').first
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