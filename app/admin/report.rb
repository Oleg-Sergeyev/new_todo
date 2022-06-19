# frozen_string_literal: true

ActiveAdmin.register_page 'Отчет' do
  menu priority: 5, label: I18n.t('active_admin.label.reports').capitalize
  controller do
    def date_interval
      report = params['report_form']
      return [nil, nil] unless report

      from_date = Time.find_zone('Moscow').local(
        report['from(1i)'].to_i,
        report['from(2i)'].to_i,
        report['from(3i)'].to_i,
        report['from(4i)'].to_i,
        report['from(5i)'].to_i
      )
      to_date = Time.find_zone('Moscow').local(
        report['to(1i)'].to_i,
        report['to(2i)'].to_i,
        report['to(3i)'].to_i,
        report['to(4i)'].to_i,
        report['to(5i)'].to_i
      )

      [from_date, to_date]
    end
  end

  page_action :report, method: :post do
    from_date, to_date = date_interval
    send_data Services::UsersReport.call(from_date, to_date),
              type: 'application/octet-stream',
              filename: 'user.xlsx'
  end
  content title: I18n.t('label.otchets').capitalize do
    panel I18n.t('home_tasks.task_5').capitalize do
      button_to(t('label.download_book'), admin_excel_just_excel_path, method: 'post', id: 'download_book')
    end
    render partial: 'form'
  end
end
