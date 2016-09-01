class ConnectionSerializer < ActiveModel::Serializer
  attributes :id , :wifi_name , :connected_at , :disconnected_at , :bill , :rating

  def wifi_name
  	object.wifi.name
  end

  def connected_at
  	unless object.connected_at.nil?
     object.connected_at.strftime("%I:%M%p")
    end
  end

  def disconnected_at
    unless object.disconnected_at.nil?
  	 object.disconnected_at.strftime("%I:%M%p")
    end
  end

  def bill
    object.total_bill.round(2)
  end

  def rating
	count = 0
	unless object.rating.nil?
  		count = object.rating.rate
	end
	count
  end
end
