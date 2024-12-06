ActiveAdmin.register Author do
  permit_params :name, :biography

  index do
    selectable_column
    id_column
    column :name
    column :biography
    actions
  end

  filter :name
  filter :biography
end
