# frozen_string_literal: true

ActiveAdmin.register_page 'Импорт/экспорт пользователей' do
  page_action :download, method: :post do
    send_data Services::UsersDownload.call,
              type: 'application/octet-stream',
              filename: 'user.xlsx'
  end

  page_action :upload, method: :post do
    Services::UsersImport.call(params['uploads_form']['excel'].tempfile)
    flash[:notice] = 'Пользователи были успешно обновлены'
    redirect_to action: :index
  end

  content title: 'Импорт/экспорт пользователей' do
    panel 'Экспорт' do
      semantic_form_for 'downloads_form', url: { action: :download } do |f|
        f.button 'Скачать'
      end
    end
    panel 'Импорт' do
      form_for 'uploads_form', url: { action: :upload }, html: { multipart: true } do |f|
        f.file_field :excel, as: :file
        f.button 'Загрузить'
      end
    end
  end
end
