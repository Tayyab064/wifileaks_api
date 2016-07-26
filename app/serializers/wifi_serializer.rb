class WifiSerializer < ActiveModel::Serializer
  attributes :id , :lat , :long , :address , :name , :ssid , :security_type , :password , :price , :data_usage , :earning , :no_of_users , :rating

  def earning
  	pri = 0
  	object.connections.each do |con|
  		pri =  pri + con.total_bill
  	end
  	pri
  end

  def rating
  	count = 0
  	ra = 0
  	object.connections.each do |rat|
  		unless rat.rating.nil?
	  		ra = ra + rat.rating.rate
	  		count = count + 1
		end
  	end
  	(ra.to_f()/count).round(1)
  end

  def data_usage
  	data = 0
  	object.connections.each do |dat|
  		data = data + ( dat.download_data + dat.upload_data )
  	end
  	data.round(2)
  end

  def no_of_users
  	object.connections.count
  end
end
