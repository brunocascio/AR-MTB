#= require active_admin/base
#= require multi-select
#= require active_admin/select2
$ -> $("select:not([multiple])").each -> $(@).select2({allowClear: true})
$ -> $("select[data-multi-select=true]").each -> $(@).multiSelect()
