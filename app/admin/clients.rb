ActiveAdmin.register Client do
  permit_params Client.attribute_names.map{|n| n.to_sym}

  action_item :view, only: :show do
    link_to 'Se connecter en tant que', admin_interface_connect_as_this_client_path(client.id)
  end

end
