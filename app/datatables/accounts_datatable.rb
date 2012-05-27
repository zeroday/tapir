class AccountsDatatable
  delegate :params, :h, :link_to, :number_to_currency, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Account.count,
      iTotalDisplayRecords: accounts.total_entries,
      aaData: data
    }
  end

private

  def data
    accounts.order(:account_name).map do |account|
      [
        link_to(h(account.account_name), account),
        h(account.service_name),
        account.web_uri, 
        account.check_uri
      ]
    end
  end

  def accounts
    @accounts ||= fetch_accounts
  end

  def fetch_accounts
    accounts = Account.order("#{sort_column} #{sort_direction}")
    accounts = accounts.page(page).per_page(per_page)
    if params[:sSearch].present?
      accounts = accounts.where("account_name like :search or service_name like :search", search: "%#{params[:sSearch]}%")
    end
    accounts
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[account_name service_name web_uri check_uri]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end
