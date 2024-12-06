ActiveAdmin.register Order do
  permit_params :status, :user_id

  index do
    selectable_column
    id_column
    column :user
    column :status
    column :created_at
    column "Total Price" do |order|
      order.line_items.sum { |item| item.price * item.quantity }
    end
    actions
  end

  filter :user
  filter :status
  filter :created_at

  form do |f|
    f.inputs do
      f.input :status
      f.input :user
    end
    f.actions
  end
end
