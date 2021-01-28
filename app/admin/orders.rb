ActiveAdmin.register Order do
  permit_params Order.attribute_names.map{|n| n.to_sym}
  filter :user
  filter :client
  filter :status, as: :check_boxes, collection: proc { Order.statuses }
end
