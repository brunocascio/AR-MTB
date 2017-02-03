Vue.component('timepicker', {
  props: ['value'],
  template: '#timepicker-template',
  mounted: function () {
    var vm = this
    $(this.$el)
      .val(this.value)
      // init timepicker
      .timepicker({
        'timeFormat': 'H:i:s',
        'minTime': '00:00:00',
        'maxTime': '03:00:00',
        'step': 1 / 60,
        'orientation': 'b'
      })
      // emit event on change.
      .on('change', function () {
        vm.$emit('input', this.value)
      })
  },
  watch: {
    value: function (value) {
      // update value
      $(this.$el).val(value)
    },
  },
  destroyed: function () {
    $(this.$el).off().timepicker('remove')
  }
})
