ActiveAdmin.register Client do
  permit_params Client.attribute_names.map{|n| n.to_sym}
end
