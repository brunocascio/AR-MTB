#= require active_admin/base
#= require multi-select
#= require active_admin/select2
$ -> $("select[data-multi-select=true]").each -> $(@).multiSelect()
