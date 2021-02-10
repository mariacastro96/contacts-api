# frozen_string_literal: true

class ContactsController < ApplicationController
  def index
    @contacts = Contact.all.order(created_at: :asc)

    render_success(@contacts)
  end

  def create
    @contact = Contact.new(contact_params)

    @contact.save ? render_success(@contact) : render_error(@contact)
  end

  def update
    find_contact_by_id(params[:id])
    @contact.assign_attributes(contact_params)

    @contact.save ? render_success(@contact) : render_error(@contact)
  end

  def destroy
    find_contact_by_id(params[:id])
    @contact.destroy

    render_success(@contact)
  end

  def history
    find_versions_by_company_id(params[:id])

    render_success(@versions)
  end

  private

  def find_versions_by_company_id(id)
    @versions = ContactVersion.where(contact_id: id).order(created_at: :desc)
  end

  def find_contact_by_id(id)
    @contact = Contact.find(id)
  end

  def render_success(object)
    render json: { data: object }
  end

  def render_error(object)
    render json: {
      error: true,
      message: object.errors.full_messages.first
    }, status: 400
  end

  def contact_params
    params.require(:contact).permit(:first_name, :last_name, :email, :phone)
  end
end
