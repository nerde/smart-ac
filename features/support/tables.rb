# frozen_string_literal: true

def add_association_column(table, records, column, klass: column.camelize.constantize, foreign_key: "#{column}_id")
  return unless table.headers.include?(column)

  assocs = klass.where(id: records.map { |b| b[foreign_key] }).to_a

  records.map! do |rec|
    assoc = assocs.find { |a| a.id == rec[foreign_key] }
    assoc = yield(assoc) if assoc
    rec.merge(column => assoc.to_s)
  end
end
