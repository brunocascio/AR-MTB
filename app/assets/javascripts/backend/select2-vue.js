Vue.component('select2', {
  props: ['value'],
  template: '#select2-template',
  mounted: function () {
    var vm = this
    $(this.$el)
      .val(this.value)
      // init select2
      .select2({ data: this.options })
      // emit event on change.
      .on('change', function () {
        vm.$emit('input', this.value)
      })
  },
  watch: {
    value: function (value) {
      // update value
      $(this.$el).val(value)
    }
  },
  destroyed: function () {
    $(this.$el).off().select2('destroy')
  }
})
