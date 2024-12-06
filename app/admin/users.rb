ActiveAdmin.register User do
  permit_params :email, :password, :username, :created_at

  index do
    selectable_column
    id_column
    column :email
    column :username
    column :created_at
    actions
  end

  filter :email
  filter :created_at
end
