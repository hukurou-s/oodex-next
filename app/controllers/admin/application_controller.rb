# frozen_string_literal: true

class Admin::ApplicationController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_ta!

  layout 'admin'
end
