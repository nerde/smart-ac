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

def html_table_to_hashes(selector: 'table', headers_idx: html_table_headers_idx(selector: selector), rows: (0..-1))
  all("#{selector} > tbody > tr")[rows].map do |row|
    cells = row.all('td')

    headers_idx.reduce({}) do |hsh, header|
      hsh.merge(header.first => Array(header.last).map { |i| cells[i].text }.reject(&:blank?).join(' '))
    end
  end
end

def html_table_headers_idx(selector: 'table')
  headers = all("#{selector} > thead > tr > th")

  offset = 0
  headers.each_with_index.select { |h, _| h.text.present? }.map do |h, idx|
    colspan = (h['colspan'] || 1).to_i
    [h.text, ((idx + offset)..(idx + offset + colspan - 1)).to_a].tap { offset += colspan - 1 }
  end
end

def description_list_to_hash(selector: 'dl')
  Hash[%w[dt dd].map { |el| all("#{selector} > #{el}").map(&:text) }.reduce(:zip)]
end
