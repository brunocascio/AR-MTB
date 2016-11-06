#= require active_admin/base
#= require multi-select
$ -> $("select[data-multi-select=true]").each -> $(@).multiSelect()
