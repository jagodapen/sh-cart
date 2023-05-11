# frozen_string_literal: true

class ShoppingListsController < ApplicationController
  before_action :set_shopping_list, only: %i(show edit update destroy)

  def index
    @shopping_lists = repository.all
  end

  def show
    respond_to do |format|
      format.xlsx  { xlsx_format }
      format.html
      format.csv  { csv_format }
      format.pdf { pdf_format }
    end
  end

  def new
    @shopping_list = repository.new_entity
    build_shopping_list_product
    build_shopping_list_email
  end

  def edit
    build_shopping_list_product
    build_shopping_list_email
  end

  def create
    check_email_selection
    @shopping_list = repository.new_entity(attrs: shopping_list_params)

    if repository.save(@shopping_list)
      redirect_to shopping_list_url(@shopping_list), notice: "Shopping list was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    check_email_selection
    @shopping_list.attributes = shopping_list_params

    if repository.save(@shopping_list)
      redirect_to shopping_list_url(@shopping_list), notice: "Shopping list was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    repository.delete(@shopping_list)

    redirect_to shopping_lists_url, notice: "Shopping list was successfully destroyed."
  end

  def send_email_now
    @shopping_list = ShoppingList.find(params[:format])
    ShoppingListMailer.with(shopping_list: @shopping_list).shopping_list_email.deliver_now
    redirect_to shopping_list_url(@shopping_list), notice: "Shopping list was send."
  end

  private

  def repository
    @repository ||= ShoppingListRepository.new
  end

  def set_shopping_list
    @shopping_list = repository.find(id: params[:id])
  end

  def shopping_list_params
    params.require(:shopping_list).permit(:name, :shopping_day, :status, :send_email,
                                          shopping_list_products_attributes:
                                            %i(id shopping_list_id product_id quantity _destroy),
                                          shopping_list_email_attributes:
                                            %i(id shopping_list_id send_date file_format recipient was_send _destroy))
  end

  def check_email_selection
    return unless params.dig(:shopping_list, :send_email) == "0"

    params[:shopping_list].delete :shopping_list_email_attributes
  end

  def build_shopping_list_product
    @shopping_list_product = @shopping_list.shopping_list_products.build
  end

  def build_shopping_list_email
    @shopping_list_email = @shopping_list.build_shopping_list_email
  end

  def file_name
    "#{@shopping_list.name}_#{@shopping_list.shopping_day}"
  end

  def xlsx_format
    response.headers["Content-Disposition"] = "attachment; filename=#{file_name}.xlsx"
  end

  def csv_format
    response.headers["Content-Type"] = "text/csv"
    response.headers["Content-Disposition"] = "attachment; filename=#{file_name}.csv"
  end

  def pdf_format
    pdf = ShoppingListPdf.new(@shopping_list)
    send_data pdf.render, filename: file_name.to_s,
                          type: "application/pdf",
                          disposition: "inline"
  end
end
