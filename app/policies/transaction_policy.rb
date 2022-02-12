class TransactionPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      user.transactions
    end
  end

  def new?
    record.account.user == user
  end

  def create?
    record.account.user == user
  end

  def update?
    record.account.user == user
  end

  def destroy?
    record.account.user == user
  end
end
