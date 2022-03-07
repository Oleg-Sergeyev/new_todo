# frozen_string_literal: true
require 'RMagick'

module Admin
  # class AboutController < Admin::ApplicationController
  class ImagesController < Admin::ApplicationController
    skip_before_action :verify_authenticity_token, only: [:index, :create]
    add_breadcrumb 'images', :admin_images_path
    
    def index; end
    def new; end
    
    # def upload_image
    #   uploaded_io = params[:about][:picture]
    #   File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
    #     file.write(uploaded_io.read)
    #   end
    # end

    def create
      # name = params[:upload][:file].original_filename
      path = File.join(Rails.root, 'app', 'assets', 'images', 'about_image.png')
      File.open(path, 'wb') { |f| f.write(params[:upload][:file].read) }
      image = Magick::Image.read(path).first
      new_path = File.join(Rails.root, 'app', 'assets', 'images', 'about_image_resize.png')
      image.change_geometry!('640x480') do |cols, rows, img|
        newimg = img.resize(cols, rows)
        newimg.write(new_path)
      end
      #message[:notice] = "File uploaded : #{name}"
      redirect_to admin_images_path #(message: "File uploaded : #{name}")
    end

    def resize_image(file)
      image = Magick::Image.read(file.filename).first
      image.change_geometry!('640x480') do |cols, rows, img|
        newimg = img.resize(cols, rows)
        newimg.write('about_image_resize.png')
      end
    end
  end
end
