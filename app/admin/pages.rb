ActiveAdmin.register Page do
    permit_params :title, :content
  
    index do
      selectable_column
      id_column
      column :title
      column :updated_at
      actions
    end
  
    form do |f|
      f.inputs "Page Details" do
        f.input :title, input_html: { readonly: true } # Title should not be editable to preserve the purpose
        f.input :content, as: :text
      end
      f.actions
    end
  
    show do
      attributes_table do
        row :title
        row :content do |page|
          simple_format page.content
        end
        row :updated_at
      end
    end
  end
  