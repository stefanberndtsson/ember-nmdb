<script type="text/x-handlebars" data-template-name="Nmdb-search">
  <div class="container">
    {{search-select-buttons}}
  </div>
  <div class="container">
    <div class="col-md-6">
      {{#if moviesSelected}}
      {{movies-results movies=model.movies}}
      {{/if}}
    </div>
    <div class="col-md-6">
      {{#if peopleSelected}}
      {{people-results people=model.people}}
      {{/if}}
    </div>
  </div>
</script>

<script type="text/x-handlebars" data-template-name="Nmdb-components/search-select-buttons">
  <div class="btn-toolbar visible-xs visible-sm" id="results-buttons">
    <div class="btn-group col-xs-12 col-sm-12">
      <button {{bind-attr class=":btn :btn-default :col-xs-6 :col-sm-6 moviesSelected:active"}} {{action selectMovies}}>
	Movies
      </button>
      <button {{bind-attr class=":btn :btn-default :col-xs-6 :col-sm-6 peopleSelected:active"}} {{action selectPeople}}>
	People
      </button>
    </div>
  </div>
</script>

<script type="text/x-handlebars" data-template-name="Nmdb-components/movies-results">
  <ul class="list-group">
    {{#if movies}}
    <h2 class="list-group-item-heading">Movies</h2>
    {{/if}}
    {{#each movies}}
    <li class="list-group-item">{{#link-to 'movie' id}}{{full_title}}{{/link-to}}</li>
    {{/each}}
  </ul>
</script>

<script type="text/x-handlebars" data-template-name="Nmdb-components/people-results">
    <ul class="list-group">
      {{#if people}}
      <h2 class="list-group-item-heading">People</h2>
      {{/if}}
      {{#each people}}
      <li class="list-group-item">
        {{#link-to 'person' id}}
        {{first_name}} {{last_name}} {{#if name_count}}({{name_count}}){{/if}}
        {{/link-to}}
      </li>
      {{/each}}
    </ul>
</script>
