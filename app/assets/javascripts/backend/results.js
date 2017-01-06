//= require vue
//= require vue-resource
//= require ./select2-vue

function uniqueBy(arr, fn) {
  var unique = {};
  var distinct = [];
  arr.forEach(function (x) {
    var key = fn(x);
    if (!unique[key]) {
      distinct.push(x);
      unique[key] = true;
    }
  });
  return distinct;
}

var app = new Vue({
  el: '#app',
  http: {
    headers: {
      'X-CSRF-Token': $('[name="csrf-token"]').attr('content')
    }
  },
  data: {
    championship: null,
    schedule: null,
    race: null,
    subcategory: null,
    category: null,
    championships: [],
    schedules: [],
    races: [],
    categories: [],
    subcategories: [],
    participants: [],
    participants_by_subcategory: [],
    show_table_participants: false,
    freeze_form: false,
    // form
    form: []
  },
  created() {
    this.populateChampionships();
    this.populateCategories();
  },
  methods: {
    populateChampionships() {
      return this.$http.get('/admin/championships.json')
      .then((response) => response.json())
      .then((json) => this.championships = json);
    },
    populateSchedules(championship_id) {
      return this.$http.get('/admin/championships/'+championship_id+'/schedules.json')
      .then((response) => response.json())
      .then((json) => this.schedules = json);
    },
    populateRaces(schedule_id) {
      return this.$http.get('/admin/schedules/'+schedule_id+'/races.json')
      .then((response) => response.json())
      .then((json) => this.races = json);
    },
    populateCategories() {
      return this.$http.get('/admin/categories.json')
      .then((response) => response.json())
      .then((json) => this.categories = json);
    },
    calculateSubCategories(cat_id) {
      var subcategories = this.participants.map((p) => p.subcategory);
      this.subcategories = uniqueBy(subcategories, (s) => s.id);
    },
    populateParticipants() {
      var q = "?";
      q += "q[championship_id_eq]=" + this.championship;
      q += "&q[category_id_eq]=" + this.category;
      this.$http.get('/admin/participants.json'+q)
      .then((response) => response.json())
      .then((json) => this.participants = json);
    },
    fetchResults() {
      var q = "?";
      q += "q[subcategory_id_eq]=" + this.subcategory;
      q += "&q[race_id_eq]=" + this.race;
      return this.$http.get('/admin/races/1/results.json'+q)
        .then((response) => response.json())
        .then((json) => this.results = json);
    },
    show() {
      this.freeze_form = true;
      this.fetchResults().then((results) => {
        // TODO: Compare results with current participant and set the data
        // this.form = results.map((r) => {
        //   var find = this.form.filter((e) => e.participant_id == r.participant_id);
        //   if (find) return Object.assign({}, find, r);
        //   return r;
        // });
        this.show_table_participants = true;
      });
    },
    submit() {
      const json = JSON.stringify(this.form);
      this.$http.post('/admin/add_results/store', json)
        .then((response) => {
          console.log(response);
          return response.json()
        })
        .then((json) => console.log(json));
    }
  },
  watch: {
    championship(championship_id) {
      this.schedules = [];
      this.populateSchedules(championship_id);
    },
    schedule(schedule_id) {
      this.races = [];
      this.populateRaces(schedule_id);
    },
    race(race_id) {
      var race = this.races.filter((r) => r.id == race_id);
      this.category = race[0].category_id;
      this.participants = [];
      this.populateParticipants();
    },
    subcategory() {
      this.participants_by_subcategory = this.participants.filter((p) => p.subcategory.id == this.subcategory);
    },
    participants() {
      this.calculateSubCategories();
    },
    participants_by_subcategory() {
      this.form = [];
      this.participants_by_subcategory.forEach((p) => {
        this.form.push({
          participant: p,
          participant_id: p.id,
          participant_number: null,
          category_id: p.category.id,
          category_name: p.category.name,
          subcategory_id: p.subcategory.id,
          subcategory_name: p.subcategory.name,
          race_id: this.race,
        })
      });
    }
  }
});
