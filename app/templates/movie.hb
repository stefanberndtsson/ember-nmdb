<script type="text/x-handlebars" data-template-name="Nmdb-movie">
  <div class="container">
    <div class="col-xs-3">
      {{outlet menu}}
    </div>
    <div class="col-xs-9">
      <div class="row">
	<div class="well well-sm">
          <h1 class="page-header">{{model.movie.full_title}}</h1>
          <div class="row container col-xs-12 col-sm-12 col-md-12 col-lg-12">
            {{#each model.genres}}
            <span class="label label-default">{{genre}}</span>
            {{/each}}
          </div>
	</div>
      </div>
      {{outlet}}
    </div>
  </div>
</script>

<script type="text/x-handlebars" data-template-name="Nmdb-movie-page">
  {{view Nmdb.MoviePageDataView}}
</script>

<script type="text/x-handlebars" data-template-name="Nmdb-movie-page-cast">
  <div class="row">
    <div class="panel panel-default">
      <div class="panel-heading">
        <h4 class="panel-title">Cast</h4>
      </div>
      <div class="panel-body">
        <table class="table table-condensed">
          <thead>
            <tr>
              <th width="1%"></th>
              <th width="39%">Cast</th>
              <th width="60%">Character</th>
            </tr>
          </thead>
          <tbody>
            {{#each model.pageData}}
            <tr>
              <th>{{sort_value}}</th>
              <td>{{#link-to 'person' id}}{{name}}{{/link-to}}</td>
              <td>
                {{character}} {{extras}}
                {{#if episode_count}}({{episode_count}} episodes){{/if}}
              </td>
            </tr>
            {{/each}}
          </tbody>
        </table>
      </div>
    </div>
  </div>
</script>

<script type="text/x-handlebars" data-template-name="Nmdb-movie-page-keywords">
  <div class="row">
    <div class="panel panel-default">
      <div class="panel-heading">
        <h4 class="panel-title">Keywords</h4>
      </div>
      <div class="panel-body">
        {{#each model.pageData}}
        <span class="col-xs-6 col-sm-6 col-md-4 col-lg-4 panel">{{keyword}}</span>
        {{/each}}
      </div>
    </div>
  </div>
</script>

<script type="text/x-handlebars" data-template-name="Nmdb-movie-page-quotes">
  <div class="row">
    <div class="panel panel-default">
      <div class="panel-heading">
        <h4 class="panel-title">Quotes</h4>
      </div>
      <div class="panel-body">
      </div>
    </div>
  </div>
</script>

