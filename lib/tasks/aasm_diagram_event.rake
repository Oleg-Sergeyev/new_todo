# frozen_string_literal: true

if Rails.env.development?
  namespace :aasm_diagram do
    desc 'generate diagrams'
    task event: :environment do
      AASMDiagram::Diagram.new(Event.new.aasm, 'tmp/event.png')
      puts 'Diagram created in tmp/event.png'
    end
  end
end
