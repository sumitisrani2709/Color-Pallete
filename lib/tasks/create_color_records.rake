# frozen_string_literal: true

namespace :color do
  desc 'Create color records'
  task create_records: :environment do
    file_path = Rails.root.join('public', 'colors.txt')
    begin
      File.readlines(file_path).each do |line|
        data = line.split(':')
        Color.create(name: data[0].strip, code: data[1].strip)
      end
    rescue StandardError => e
      puts e.message
    end
  end
end
