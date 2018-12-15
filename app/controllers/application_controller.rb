require 'open-uri'
require 'json'

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_locale_from_subdomain
  before_action :check_for_redirection
  before_action :strip_file_extension
  before_action :authorize, if: :staging?

  helper :meta

  def staging?
    ENV['ON_STAGING'] == 'TRUE'
  end
  helper_method :staging?

  def lite_mode?
    request.subdomain == 'lite'
  end
  helper_method :lite_mode?

  def media_mode?
    !lite_mode?
  end
  helper_method :media_mode?

  def render_content article
    cache [:article_content, article, lite_mode?] do
      article.content_rendered include_media: media_mode?
    end
  end
  helper_method :render_content

  def signed_in?
    current_user
  end
  helper_method :signed_in?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def authorize
    redirect_to signin_url, alert: 'You need to sign in to view that page.' unless signed_in?
  end

  def set_locale_from_subdomain
    locale = request.subdomain
    I18n.locale = locale if I18n.available_locales.include?(locale.to_sym)

    # Force the subdomain to match the locale.
    # Don’t do this in development, because typically local development
    # environments don’t support subdomains (en.localhost doesn’t resolve).
    if (I18n.locale != I18n.default_locale) && # Don’t redirect to en.crimethinc.com
       request.subdomain.empty? &&             # Don’t redirect if there’s a subdomain
       Rails.env.production?                   # Don’t redirect in development

      return redirect_to({ subdomain: I18n.locale }.merge(params.permit!))
    end
  end

  def check_for_redirection
    redirect = Redirect.where(source_path: request.path.downcase).last
    redirect = Redirect.where(source_path: "#{request.path.downcase}/").last if redirect.blank?

    return redirect_to(redirect.target_path.downcase, status: redirect.temporary? ? 302 : 301) if redirect.present?
  end

  # TODO: move to rack middleware
  def strip_file_extension
    return redirect_to request.path.sub(/\.html/, '') if /\.html/.match?(request.path)
  end

  # TODO: move to meta helper
  def current_resource_name
    request.path.split('admin/').last.split('/').first.capitalize.singularize
  end
  helper_method :current_resource_name

  # TODO: move to meta helper
  def page_title
    if @title.present?
      t(:site_name) + prepend_admin_if_needed + @title
    else
      t(:site_name)
    end
  end
  helper_method :page_title

  def title_for *page_keys
    pieces = []

    if page_keys.first.is_a? Symbol
      namespace = page_keys.shift
      page_keys.unshift :index
    end

    page_keys.each do |key|
      piece = I18n.t("page_titles.#{namespace}.#{key}")
      pieces << (piece.match?(/translation missing/) ? key : piece)
    end

    pieces.flatten.join ' : '
  end

  # TODO: move to meta helper
  def prepend_admin_if_needed
    if controller_path.match(%r{\Aadmin\/.*\z}).present?
      " #{t('admin.title_prepend')} : "
    else
      ' : '
    end
  end
  helper_method :prepend_admin_if_needed

  # TODO: move to a helper
  def author
    t(:site_author)
  end
  helper_method :author

  def root_url
    Rails.env.development? ? 'http://localhost:3000' : 'https://crimethinc.com'
  end
  helper_method :root_url
end
