@onReady ->
  $('.dates-picker').daterangepicker
    opens: 'left'
    maxDate: moment()
    locale:
      format: 'MMM Do, YY'
    ranges:
     'Today': [moment().startOf('day'), moment()],
     'This Week': [moment().startOf('week'), moment()],
     'This Month': [moment().startOf('month'), moment()],
     'This Year': [moment().startOf('year'), moment()],
    (start, end, label) ->
      $('#since').val(start.format('YYYY-MM-DD HH:mm'))
      $('#upto').val(end.format('YYYY-MM-DD HH:mm')).parents('form').submit()
