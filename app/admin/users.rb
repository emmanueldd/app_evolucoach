ActiveAdmin.register User do
  permit_params User.attribute_names.map{|n| n.to_sym}

  action_item :view, only: :show do
    link_to 'Se connecter en tant que', admin_interface_connect_as_this_user_path(user.id)
  end
end
