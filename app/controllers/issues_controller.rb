class IssuesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_issue, only: :destroy

  def index
    @issues = Issue.ordered.page(params[:page])
  end

  def destroy
    @issue.resolve!(current_user)
    respond_to do |format|
      format.html { redirect_to issues_path, notice: 'Issue was resolved' }
      format.json { head :no_content }
    end
  end

  private

  def set_issue
    @issue = Issue.find(params[:id])
  end
end
