<script type="text/x-handlebars" data-template-name="Nmdb-search">
  <div class="row container col-sm-12">
    <div class="btn-toolbar visible-xs visible-sm" id="results-buttons">
      <div class="btn-group col-xs-12 col-sm-12">
      </div>
    </div>
  </div>
  <div class="row container col-sm-12 col-md-12 col-lg-12">
    {{movies-results movies=model.movies}}
    {{people-results people=model.people}}
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
