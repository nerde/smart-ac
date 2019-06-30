module IssuesHelper
  def unresolved_issues_count
    @unresolved_issues_count ||= Issue.unresolved.count
  end
end
