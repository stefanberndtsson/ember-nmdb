<script type="text/x-handlebars" data-template-name="Nmdb-search">
  <div class="container">
    <div class="row">
      {{search-select-buttons}}
    </div>
  </div>
  <div class="container">
    {{#if moviesSelected}}
    {{movies-results movies=model.movies}}
    {{/if}}
    {{#if peopleSelected}}
    {{people-results people=model.people}}
    {{/if}}
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
  <div class="list-group">
    {{#if movies}}
    <h2 class="list-group-item-heading visible-md visible-lg">Movies</h2>
    {{/if}}
    {{#each movies}}
    {{#link-to 'movie' id classNames="list-group-item list-group-link-item list-group-link-item-single"}}
      <span class="pull-right glyphicon glyphicon-chevron-right list-group-link-arrow"/>
      <h4>{{full_title}}</h4>
    {{/link-to}}
    {{/each}}
  </div>
</script>

<script type="text/x-handlebars" data-template-name="Nmdb-components/people-results">
    <div class="list-group">
      {{#if people}}
      <h2 class="list-group-item-heading visible-md visible-lg">People</h2>
      {{/if}}
      {{#each people}}
      {{#link-to 'person' id classNames="list-group-item list-group-link-item list-group-link-item-single"}}
        <span class="pull-right glyphicon glyphicon-chevron-right list-group-link-arrow"/>
        <h4>{{first_name}} {{last_name}} {{#if name_count}}({{name_count}}){{/if}}</h4>
      {{/link-to}}
      {{/each}}
    </div>
</script>
