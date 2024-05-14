class Dashboard
  def initialize()
    @active_people_ids = Person.where(active: true).select(:id)
  end

  def people_status
    active_people_pie_chart = {
      active: Person.where(active: true).count,
      inactive: Person.where(active: false).count
    }
  end

  def total_debts_by_active_people
    total_debts = Debt.where(person_id: @active_people_ids).sum(:amount)
  end

  def total_payments_by_active_people
    active_people_ids = Person.where(active: true).select(:id)
    total_payments = Payment.where(person_id: @active_people_ids).sum(:amount)
  end

  def balance_by_active_people
    total_debts = Debt.where(person_id: @active_people_ids).sum(:amount)
    total_payments = Payment.where(person_id: @active_people_ids).sum(:amount)
    balance = total_payments - total_debts
  end

  def last_debts
    last_debts = Debt.order(created_at: :desc).limit(10).map do |debt|
      [debt.id, debt.amount]
    end
  end

  def last_payments
    last_payments = Payment.order(created_at: :desc).limit(10).map do |payment|
      [payment.id, payment.amount]
    end
  end

  def latest_registrations
    # últimos associados cadastrados pelo usuário atual
    my_people = Person.where(user: User.last).order(:created_at).limit(10)
  end

end