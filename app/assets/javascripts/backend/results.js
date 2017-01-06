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
    // this.populateCategories();
  },
  methods: {
    _get(url) {
      return new Promise((resolve, reject) => {
        return this.$http
          .get(url)
          .then(
            // success
            (r) => resolve(r.json()),
            // fails
            (err) => {
              console.error(err);
              reject(arguments);
            }
          );
      });
    },
    _post(url, data) {
      return new Promise((resolve, reject) => {
        return this.$http
          .post(url, data)
          .then(
            // success
            (r) => resolve(r.json()),
            // fails
            (err) => {
              console.error(err);
              reject(arguments);
            }
          );
      });
    },
    populateChampionships() {
      this._get('/admin/championships.json')
        .then((json) => this.championships = json)
        .catch((error) => this.championships = []);
    },
    populateSchedules(championship_id) {
      return this._get(`/admin/championships/${championship_id}/schedules.json`)
        .then((json) => this.schedules = json)
        .catch((err) => this.schedules = []);
    },
    populateRaces(schedule_id) {
      return this._get(`/admin/schedules/${schedule_id}/races.json`)
        .then((json) => this.races = json)
        .catch((err) => this.races = []);
    },
    populateCategories() {
      return this._get('/admin/categories.json')
        .then((json) => this.categories = json)
        .catch((err) => this.categories = []);
    },
    calculateSubCategories(cat_id) {
      var subcategories = this.participants.map((p) => p.subcategory);
      this.subcategories = uniqueBy(subcategories, (s) => s.id);
    },
    populateParticipants() {
      let q = `q[championship_id_eq]=${this.championship}`;
      q += `&q[category_id_eq]=${this.category}`;
      this._get(`/admin/participants.json?${q}`)
        .then((json) => this.participants = json)
        .catch((err) => this.participants = []);
    },
    fetchResults() {
      const q = `q[subcategory_id_eq]=${this.subcategory}`;
      return this._get(`/admin/races/${this.race}/results.json?${q}`)
        .then((json) => this.results = json)
        .catch((json) => this.results = []);
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
      this._post('/admin/add_results/store', JSON.stringify(this.form))
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
      this.participants_by_subcategory = this.participants
        .filter((p) => p.subcategory.id == this.subcategory);
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
