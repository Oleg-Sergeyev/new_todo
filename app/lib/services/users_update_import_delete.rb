# frozen_string_literal: true

# module Callable
module Callable
  def self.included(base)
    base.instance_eval do
      def call(*args)
        new.call(*args)
      end
    end
  end
end

module Services
  # class UsersImport
  class UsersUpdateImportDelete
    include Callable

    def call(file_path)
      workbook = Roo::Spreadsheet.open file_path
      worksheets = workbook.sheets
      puts "Found #{worksheets.count} worksheets"
      roles = Role.all.map { |role| [role.code, role.id] }.to_h
      user_ids = User.ids
      user_emails = User.all.map(&:email)

      worksheets.each do |worksheet|
        puts "Reading: #{worksheet}"
        workbook.sheet(worksheet).each_row_streaming do |row|
          break if row.empty?

          id, name, email, code, action = parse_row(row)
          puts "Reading: #{id}, #{name}, #{email}, #{code}, #{action}"
          if action && action == 'delete'
            delete_user(email)
            next
          end
          if user_emails.include?(email) || user_ids.include?(id.to_i)
            update(name, email, roles[code])
          else
            create(name, email, roles[code])
          end
        end
      end
    end

    private

    def create(name, email, role)
      hash_user =
        {
          name: name,
          email: email,
          password: email,
          role_id: role,
          state: 'created',
          events_unffd_count: 0,
          events_ffd_count: 0,
          items_unffd_count: 0,
          items_ffd_count: 0
        }
      User.create! hash_user
    end

    def update(name, email, role)
      User.find_by(email: email).update(name: name, email: email, role_id: role, state: 'active')
    end

    def delete_user(email)
      user = User.find_by(email: email.to_s)
      user&.destroy
    end

    def parse_row(row)
      array = []
      row[0].nil? ? array.push(0) : array.push(row[0].value.to_i)
      row[1].nil? ?  array.push('') : array.push(row[1].value)
      row[2].nil? ?  array.push('') : array.push(row[2].value)
      row[3].nil? ?  array.push('') : array.push(row[3].value)
      row[4].nil? ?  array.push('') : array.push(row[4].value)
      array
    end
  end
end
