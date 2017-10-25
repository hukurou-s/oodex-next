# frozen_string_literal: true

class Admin::ApplicationController < ApplicationController
  before_action :authenticate_admin!

  layout 'admin'
end
