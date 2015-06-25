class ContactsController < ApplicationController
  def index
    u = Contact.find_by_user_id(params[:user_id])
    render json:: u.owner.concat(
      u.shared_users
    )
  end

  def create
    contact = Contact.new(contact_params)
    if contact.save
      render json: contact
    else
      render(
        json: contact.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  def show
    contact = Contact.find_by_id(params[:id])
    render json: contact
  end

  def update
    contact = Contact.find_by_id(params[:id])
    contact.update(contact_params)
    render json: contact
  end

  def destroy
    contact = Contact.find_by_id(params[:id])
    contact.destroy
    render text: "contact Destroyed!", json: contact


  end

  private
  def contact_params
    params[:contact].permit(:name, :email, :user_id)
  end
end
